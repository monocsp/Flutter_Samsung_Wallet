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
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String impressionUrl = "[ Impression Url ]";

  /// optional
  static const String countryCode = "[ CountryCode ]";

  /// mandatory
  /// Check your Wallet Cards in Samsung Wallet Partners
  static const String partnerCode = "[ Partner Code ]";

  /// mandatory
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String cardId = "[ Card Id ]";

  /// mandatory
  /// You can get cdata to JWT Generator
  static const String cdata = "[ CData ]";

  /// mandatory
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
        body: Column(
          children: [
            const Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Center(
                  child: Text(
                'Hello Samsung Wallet!',
                style: TextStyle(fontSize: 20),
              )),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GestureDetector(
                  onTap: addCard,
                  child: Image.asset("assets/wallet_card.png")),
            )
          ],
        ),
      ),
    );
  }
}
