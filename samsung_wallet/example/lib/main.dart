import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:samsung_wallet/samsung_wallet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static const String impressionUrl = "[ Impression Url ]";
  static const String countryCode = "KR";
  static const String partnerCode = "[ Partner Code ]";
  static const String cardId = " [ Card Id ]";
  static const String cdata = "[ cdata ]";
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
              GestureDetector(
                  onTap: addCard, child: Image.asset("assets/wallet_card.png"))
            ],
          ),
        ),
      ),
    );
  }
}
