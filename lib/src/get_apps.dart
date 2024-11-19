import 'package:flutter/services.dart';
import 'entities/entities.dart';

class GetApps {
  const GetApps();

  static const _getAppsChannel = MethodChannel('mm_terekhin/get_apps_channel');

  Future<List<AppData>> getInstalledMessengers() async {
    final appsData = <AppData>[];

    final /*List<dynamic>?*/ apps =
        await _getAppsChannel.invokeMethod('getInstalledMessengers');


    if (apps != null) {
      for (final app in apps) {
        if (app is Map) {
          final appData = AppData.fromMap(app);

          appsData.add(appData);
        }
      }
    }

    return appsData;
  }

  Future<void> openMessengerApp({
    required MessengerType type,
    required String arg,
  }) async {
    final args = <String, String?>{
      'type': type.toText(),
      'args': arg,
    };

    await _getAppsChannel.invokeMethod('openMessenger', args);
  }
}
