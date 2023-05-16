import 'package:flutter_test/flutter_test.dart';
import 'package:samsung_wallet/samsung_wallet.dart';
import 'package:samsung_wallet/samsung_wallet_platform_interface.dart';
import 'package:samsung_wallet/samsung_wallet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSamsungWalletPlatform
    with MockPlatformInterfaceMixin
    implements SamsungWalletPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SamsungWalletPlatform initialPlatform = SamsungWalletPlatform.instance;

  test('$MethodChannelSamsungWallet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSamsungWallet>());
  });

  test('getPlatformVersion', () async {
    SamsungWallet samsungWalletPlugin = SamsungWallet();
    MockSamsungWalletPlatform fakePlatform = MockSamsungWalletPlatform();
    SamsungWalletPlatform.instance = fakePlatform;

    expect(await samsungWalletPlugin.getPlatformVersion(), '42');
  });
}
