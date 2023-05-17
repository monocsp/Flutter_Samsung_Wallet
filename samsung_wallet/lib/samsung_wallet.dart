import 'samsung_wallet_platform_interface.dart';

class SamsungWallet {
  /// Check current device samsung wallet supported
  ///
  /// optional paramter [countryCode] country code following (ISO_3166-2)
  ///
  /// mandatory paratmer [parterCode].
  /// Please Check your samsung wallet potal site.
  ///
  /// [serviceType] is mandatory, fixed. Someday it can be change

  Future<bool?> checkSamsungWalletSupported(
      {String? countryCode, required String parterCode}) {
    return SamsungWalletPlatform.instance.checkSamsungWalletSupported(
        parterCode: parterCode, countryCode: countryCode);
  }
}
