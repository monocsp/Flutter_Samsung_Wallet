import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samsung_wallet/samsung_wallet_method_channel.dart';

void main() {
  MethodChannelSamsungWallet platform = MethodChannelSamsungWallet();
  const MethodChannel channel = MethodChannel('samsung_wallet');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
