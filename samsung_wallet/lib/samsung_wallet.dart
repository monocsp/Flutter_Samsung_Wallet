
import 'samsung_wallet_platform_interface.dart';

class SamsungWallet {
  Future<String?> getPlatformVersion() {
    return SamsungWalletPlatform.instance.getPlatformVersion();
  }
}
