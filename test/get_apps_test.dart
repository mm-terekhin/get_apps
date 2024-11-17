import 'package:flutter_test/flutter_test.dart';
import 'package:get_apps/get_apps.dart';
import 'package:get_apps/get_apps_platform_interface.dart';
import 'package:get_apps/get_apps_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGetAppsPlatform
    with MockPlatformInterfaceMixin
    implements GetAppsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GetAppsPlatform initialPlatform = GetAppsPlatform.instance;

  test('$MethodChannelGetApps is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGetApps>());
  });

  test('getPlatformVersion', () async {
    GetApps getAppsPlugin = GetApps();
    MockGetAppsPlatform fakePlatform = MockGetAppsPlatform();
    GetAppsPlatform.instance = fakePlatform;

    expect(await getAppsPlugin.getPlatformVersion(), '42');
  });
}
