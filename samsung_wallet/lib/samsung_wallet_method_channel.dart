import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'samsung_wallet_platform_interface.dart';

/// An implementation of [SamsungWalletPlatform] that uses method channels.
class MethodChannelSamsungWallet extends SamsungWalletPlatform {
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
    log("[SAMSUNG WALLET SAMPLE] : Samsung Wallet supported? ${result ? "YES!" : "NO!"}");
    return result;
  }
}
