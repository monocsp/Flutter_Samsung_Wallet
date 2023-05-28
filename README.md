## Samsung Wallet Sample 1.0

Samsung Wallet Sample for Flutter

support flutter >= 3.0, dart >= 2.14.0, < 4.0.0


## More Information

You can get more information the [Samsung Wallet](https://developer.samsung.com/wallet/api/overview.html) documentation.

## References

This package based on the Android sample code from Samsung Wallet. 
If you need the reference code, you can click [here](https://developer.samsung.com/wallet/samplecode.html) to access it.

## How to use

1. add dependency to pubspec.yaml

```yaml
dependencies:
  flutter_samsung_wallet: 
```

2. add Permission in AndroidManifest.xml

Add two line for android internet permission


<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

If you want more information, check [this](https://developer.android.com/training/basics/network-ops/connecting?hl=ko)

3. Set main

Please add 'WidgetsFlutterBinding.ensureInitialized();' code into your main

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
```

4. Initialization SamsungWallet

Initialization SamsungWallet Object

```dart
  final samsungWalletPlugin = SamsungWallet(
      countryCode: countryCode,
      partnerCode: partnerCode,
      impressionURL: impressionUrl);
```
If you initialize the SamsungWallet object, it will automatically check SamsungWallet support immediately. 

The results can be viewed in the debug console log.

5. Add Card

If Samsung wallet is supported, you can add card.

```dart
samsungWalletPlugin.addCardToSamsungWallet(
        cardID: cardId, cData: cdata, clickURL: clickUrl);
```

You can get cdata JWT Generator. Please check [here] (https://developer.samsung.com/wallet/samplecode.html) about JWT Generator




