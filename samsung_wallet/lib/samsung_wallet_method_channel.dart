import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'samsung_wallet_platform_interface.dart';

/// An implementation of [SamsungWalletPlatform] that uses method channels.
class MethodChannelSamsungWallet extends SamsungWalletPlatform {
  static const String _TAG = "[SAMSUNG WALLET SAMPLE]";

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_samsung_wallet');

  @override
  Future<bool?> checkSamsungWalletSupported(
      {String? countryCode, required String parterCode}) async {
    final result = await methodChannel.invokeMethod('checkWallet', {
      'countryCode': countryCode,
      'partnerCode': parterCode,
      'serviceType': 'WALLET'
    });
    log("$_TAG : Samsung Wallet supported? ${result ? "YES!" : "NO!"}");
    return result;
  }

  @override
  Future<bool?> addCardToSamsungWallet(
      {required String cardID,
      required String cData,
      required String clickURL}) async {
    final result = await methodChannel.invokeMethod(
        'addCardToSamsungWallet',
        {"cardId": cardID, "cData": cData, "clickURL": clickURL});
    log("$_TAG : DONE? ${result ? "YES!" : "NO!"}");
    return result;
  }
}
