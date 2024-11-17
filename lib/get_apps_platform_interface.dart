import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'get_apps_method_channel.dart';

abstract class GetAppsPlatform extends PlatformInterface {
  /// Constructs a GetAppsPlatform.
  GetAppsPlatform() : super(token: _token);

  static final Object _token = Object();

  static GetAppsPlatform _instance = MethodChannelGetApps();

  /// The default instance of [GetAppsPlatform] to use.
  ///
  /// Defaults to [MethodChannelGetApps].
  static GetAppsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GetAppsPlatform] when
  /// they register themselves.
  static set instance(GetAppsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
