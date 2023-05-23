import 'samsung_wallet_platform_interface.dart';

class SamsungWallet {
  /// (optional) [countryCode] country code (ISO_3166-2)
  /// ex : "US" or "KR"
  final String? countryCode;

  /// Mandatory and Fixed
  final String serviceType = 'WALLET';

  /// mandatory paratmer [partnerCode] same as partnerId (Partner ID)
  ///
  /// You can find PartnerCode in Samsung Wallet Partners potal
  /// partner.walletsvc.samsung.com
  final String partnerCode;

  /// URL of logging a button impression event.
  /// * the value granted from partner portal
  ///
  /// mandatory paratmer [impressionURL] Impression URL
  ///
  /// You can find Impression Url in Partners Mange Wallet Card
  /// App Integration
  final String impressionURL;

  SamsungWallet({
    this.countryCode,
    required this.impressionURL,
    required this.partnerCode,
  }) {
    initialize(
      countryCode: countryCode,
      impressionURL: impressionURL,
      partnerCode: partnerCode,
    );
  }

  /// Check current device samsung wallet supported
  ///
  /// optional paramter [countryCode] country code following (ISO_3166-2)
  ///
  /// mandatory paratmer [partnerCode].
  /// Please Check your samsung wallet portal site.
  ///
  /// [serviceType] is mandatory, fixed. Someday it can be change

  Future<bool?> checkSamsungWalletSupported({
    String? countryCode,
    required String partnerCode,
  }) async =>
      await SamsungWalletPlatform.instance.checkSamsungWalletSupported(
          partnerCode: partnerCode,
          countryCode: countryCode,
          serviceType: serviceType);

  /// Add Card the provided cdata and cardid in Samsung Wallet
  ///

  /// mandatory paramter [cardId]
  ///
  /// Wallet card identifier
  /// Please Check CardId which you want to add card
  ///
  /// mandatory paratmer [clickURL].
  ///
  /// URL of logging a button click event.
  /// * the value granted from partner portal
  ///
  /// mandatory paratmer [cData]
  ///
  /// Encrypted Card object (JSON).
  /// * This field needs to be encrypted.
  ///
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
      required String partnerCode,
      required String impressionURL}) async {
    SamsungWalletPlatform.instance.initialized(
        serviceType: serviceType,
        partnerCode: partnerCode,
        impressionURL: impressionURL,
        countryCode: countryCode);
  }
}
