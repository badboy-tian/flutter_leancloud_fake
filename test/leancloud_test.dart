import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leancloud_fake/leancloud.dart';

void main() {
  const MethodChannel channel = MethodChannel('leancloud');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Leancloud.platformVersion, '42');
  });
}
