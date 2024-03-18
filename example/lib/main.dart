import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:samsung_wallet/samsung_wallet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// mandatory
  ///
  /// URL for logging a button impression event.
  /// Value granted from the Partners Portal.
  ///
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String impressionUrl = "[ Impression Url ]";

  /// optional
  ///
  /// Country code
  static const String countryCode = "[ CountryCode ]";

  /// mandatory
  ///
  /// Partner code obtained from Partners Portal
  /// Value granted from the Partners portal.
  ///
  /// Check your Wallet Cards in Samsung Wallet Partners
  static const String partnerCode = "[ Partner Code ]";

  /// mandatory
  ///
  /// Wallet card identifier obtained from Partners Portal
  /// Value granted from the Partners Portal.
  ///
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String cardId = "[ Card Id ]";

  /// mandatory
  /// You can get cdata to JWT Generator
  static const String cdata = "[ CData ]";

  /// mandatory
  ///
  /// Encrypted card object (JSON).
  /// This field needs to be encrypted.
  ///
  /// Refer to [Security](https://developer.samsung.com/wallet/api/security.html)
  /// for more details.
  ///
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String clickUrl = "[ Click Url ]";

  final _samsungWalletPlugin = SamsungWallet(
      countryCode: countryCode,
      partnerCode: partnerCode,
      impressionURL: impressionUrl);

  Future<void> checkSamsungWalletSupported() async {
    try {
      await _samsungWalletPlugin.checkSamsungWalletSupported(
              partnerCode: partnerCode, countryCode: 'KR') ??
          false;
    } catch (e) {
      log("ERROR : $e");
    }
  }

  addCard() async {
    await _samsungWalletPlugin.addCardToSamsungWallet(
        cardID: cardId, cData: cdata, clickURL: clickUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Samsung Wallet Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Hello Samsung Wallet!'),
              const SizedBox(
                height: 50,
              ),

              //  AddToSamsungWalletButton(onTapAddCard: addCard),

              const SizedBox(
                height: 50,
              ),
              AddToSamsungWalletButton.testTool(),
            ],
          ),
        ),
      ),
    );
  }
}
