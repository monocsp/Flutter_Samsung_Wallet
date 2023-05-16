import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'samsung_wallet_platform_interface.dart';

/// An implementation of [SamsungWalletPlatform] that uses method channels.
class MethodChannelSamsungWallet extends SamsungWalletPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('samsung_wallet');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
