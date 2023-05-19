import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'samsung_wallet_method_channel.dart';

abstract class SamsungWalletPlatform extends PlatformInterface {
  /// Constructs a SamsungWalletPlatform.
  SamsungWalletPlatform() : super(token: _token);

  static final Object _token = Object();

  static SamsungWalletPlatform _instance = MethodChannelSamsungWallet();

  /// The default instance of [SamsungWalletPlatform] to use.
  ///
  /// Defaults to [MethodChannelSamsungWallet].
  static SamsungWalletPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SamsungWalletPlatform] when
  /// they register themselves.
  static set instance(SamsungWalletPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> checkSamsungWalletSupported(
      {String? countryCode,
      required String parterCode,
      required String serviceType});

  Future<bool?> addCardToSamsungWallet(
      {required String cardID,
      required String cData,
      required String clickURL});

  Future<void> initialized(
      {String? countryCode,
      required String parterCode,
      required String impressionURL,
      required String serviceType});
}
