import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_login_plugin/social_login_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('social_login_plugin');

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
    expect(await SocialLoginPlugin.platformVersion, '42');
  });
}
