import 'samsung_wallet_platform_interface.dart';

class SamsungWallet {
  final String? countryCode;
  final String serviceType = 'WALLET';
  final String parterCode;
  final String impressionURL;

  SamsungWallet({
    this.countryCode,
    required this.impressionURL,
    required this.parterCode,
  }) {
    initialize(
      countryCode: countryCode,
      impressionURL: impressionURL,
      parterCode: parterCode,
    );
  }

  /// Check current device samsung wallet supported
  ///
  /// optional paramter [countryCode] country code following (ISO_3166-2)
  ///
  /// mandatory paratmer [parterCode].
  /// Please Check your samsung wallet portal site.
  ///
  /// [serviceType] is mandatory, fixed. Someday it can be change

  Future<bool?> checkSamsungWalletSupported({
    String? countryCode,
    required String parterCode,
  }) async =>
      await SamsungWalletPlatform.instance.checkSamsungWalletSupported(
          parterCode: parterCode,
          countryCode: countryCode,
          serviceType: serviceType);

  /// Add Card the provided cdata and cardid in Samsung Wallet
  ///
  /// mandatory paramter [cardId]
  /// Please Check CardId which you want to add card
  ///
  /// mandatory paratmer [clickURL].
  /// Please Check CardId which you want to add card
  ///
  /// mandatory paratmer [cData]
  /// You can get cdata from CData Generator
  /// which is you can find samsung wallet official documentation

  Future<bool?> addCardToSamsungWallet(
          {required String cardID,
          required String cData,
          required String clickURL}) async =>
      await SamsungWalletPlatform.instance.addCardToSamsungWallet(
          cardID: cardID, cData: cData, clickURL: clickURL);

  Future<void> initialize(
      {String? countryCode,
      required String parterCode,
      required String impressionURL}) async {
    await SamsungWalletPlatform.instance.initialized(
        serviceType: serviceType,
        parterCode: parterCode,
        impressionURL: impressionURL,
        countryCode: countryCode);
  }
}
