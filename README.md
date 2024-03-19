## Samsung Wallet 1.1.0

Samsung Wallet for Flutter

## Requirement

support flutter >= 3.0, dart >= 2.17.0, < 4.0.0

compileSdkVersion 34

## More Information

You can get more information the [Samsung Wallet](https://developer.samsung.com/wallet/api/overview.html) documentation.

## References

This package based on the Android sample code from Samsung Wallet.
If you need the reference code, you can click [here](https://developer.samsung.com/wallet/samplecode.html) to access it.

## How to use

1. add dependency

- Add dependency to your `pubspec.yaml` file.

```yaml
dependencies:
  samsung_wallet: newest_version
```

2. Add Permission

- Add permission to your `AndroidManifest.xml` file.

```html
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

If you want more information, Please check [this](https://developer.android.com/training/basics/network-ops/connecting?hl=ko)

3. Set main

- Please add 'WidgetsFlutterBinding.ensureInitialized();' code to your main in `main.dart` file

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
```

4. Initialization SamsungWallet

- Initialization SamsungWallet Object

```dart
  final samsungWalletPlugin = SamsungWallet(
      countryCode: countryCode,
      partnerCode: partnerCode,
      impressionURL: impressionUrl);
```

If you initialize the SamsungWallet object, it will automatically check SamsungWallet support immediately.

The results can be viewed in the debug console log.

5. Create onTapMethod for add Card

- If Samsung wallet is supported, you can add card.

```dart
function onTap(){
  samsungWalletPlugin.addCardToSamsungWallet(
        cardID: cardId, cData: cdata, clickURL: clickUrl);
}
```

6. Add Samsung Wallet Button Widget

```dart
AddToSamsungWalletButton(onTapAddCard: onTap)
```

## More

1. Add to Wallet Test Tool

- If you want Using 'Add to Wallet Test Tool', try this widget

```dart
AddToSamsungWalletButton.testTool()
```

More information about 'Add to Wallet Test Tool' Please check [this](https://developer.samsung.com/wallet/wallettest.html)

2. How to make Cdata

- You can make cdata using JWT Generator. Please check [here](https://developer.samsung.com/wallet/samplecode.html) about JWT Generator

## Issues

Please file any issues, bugs or feature request as an issue on my [GitHub](https://github.com/monocsp/flutter_samsung_wallet/issues) page.
