import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'get_apps_platform_interface.dart';

/// An implementation of [GetAppsPlatform] that uses method channels.
class MethodChannelGetApps extends GetAppsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('get_apps');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
