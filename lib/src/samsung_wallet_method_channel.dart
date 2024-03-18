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
      {String? countryCode,
      required String partnerCode,
      required String serviceType}) async {
    final result = await methodChannel.invokeMethod('checkWallet', {
      'countryCode': countryCode,
      'partnerCode': partnerCode,
      'serviceType': serviceType
    });
    log("$_TAG : Samsung Wallet supported? ${result ? "YES!" : "NO!"}");
    return result;
  }

  @override
  Future<bool?> addCardToSamsungWallet(
      {required String cardID,
      required String cData,
      required String clickURL}) async {
    final result = await methodChannel.invokeMethod('addCardToSamsungWallet',
            {"cardId": cardID, "cData": cData, "clickURL": clickURL}) ??
        false;
    log("$_TAG : Open Samsung Wallet ${result ? "Success" : "Fail"}");
    return result;
  }

  @override
  Future<void> initialized(
      {String? countryCode,
      required String partnerCode,
      required String serviceType,
      required String impressionURL}) async {
    Map result = (await methodChannel.invokeMapMethod('initialized', {
          'countryCode': countryCode,
          'partnerCode': partnerCode,
          'serviceType': serviceType,
          'impressionURL': impressionURL
        })) ??
        {"walletSupported": false, "connectedImpressionUrl": false};

    log("$_TAG : Samsung Wallet supported? ${(result["walletSupported"] ?? false) ? "YES!" : "NO!"}");
    log("$_TAG : ${(result["connectedImpressionUrl"] ?? false) ? "Success to connection" : "Fail to connection"} ImpressUrl");
    return;
  }
}
