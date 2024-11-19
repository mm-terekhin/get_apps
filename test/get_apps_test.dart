import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_apps_flutter/get_apps.dart';

void main() {
  const getApps = GetApps();
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('mm_terekhin/get_apps_channel');
  final log = <MethodCall>[];

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    log.add(methodCall);
    if (methodCall.method == 'openMailApp') {
      return true;
    }
    return null;
  });

  tearDown(() {
    log.clear();
  });

  group('messengers', () {
    test('should get installed messengers', () async {
      final result = await getApps.getInstalledMessengers();
      expect(result, []);
    });

    test('should open messengers', () async {
      await getApps.openMessengerApp(
        type: MessengerType.telegram,
        arg: 'test',
      );
    });
  });
}
