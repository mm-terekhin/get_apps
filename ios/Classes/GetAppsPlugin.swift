import Flutter
import UIKit

public class GetAppsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mm_terekhin/get_apps_channel", binaryMessenger: registrar.messenger())
        let instance = GetAppsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]
        
        switch call.method {
        case "getInstalledMessengers":
            getInstalledMessengers(result: result)
        case "openMessenger":
            openMessenger(args: arguments)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getInstalledMessengers(result: @escaping FlutterResult) {
        var installedMessengers: [[String: Any]] = []
        
        messengers.forEach { messenger in
            let isInstalled = isAppInstalled(urlScheme: messenger.url)
            
            if (isInstalled) {
                let messenger = ["app_name": messenger.name, "type": messenger.type]
                
                installedMessengers.append(messenger)
            }
        }
        
        result(installedMessengers)
    }
    
    private func isAppInstalled(urlScheme: String) -> Bool {
        if let url = URL(string: urlScheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    private func openMessenger(args: [String: Any]?) {
        guard let type = args?["type"] as? String, let arg = args?["args"] as? String else {
            return }
        
        switch type {
        case "whatsApp":
            open(url: "whatsapp://send?phone=\(arg)")
        case "telegram":
            open(url: "tg://resolve?domain=\(arg)")
        default:
            break
        }
    }
    
    private func open(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

enum MessengerType: String {
    case whatsApp
    case telegram
}

private class App {
    let name: String;
    let type: String;
    let url: String;
    
    init(name: String, type: String, url: String) {
        self.name = name
        self.type = type
        self.url = url
    }
}


private let messengers: [App] = [
    App(name: "whatsApp", type: MessengerType.whatsApp.rawValue, url: "whatsapp://"),
    App(name: "telegram", type: MessengerType.telegram.rawValue, url: "tg://"),
]

