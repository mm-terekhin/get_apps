
import 'get_apps_platform_interface.dart';

class GetApps {
  Future<String?> getPlatformVersion() {
    return GetAppsPlatform.instance.getPlatformVersion();
  }
}
