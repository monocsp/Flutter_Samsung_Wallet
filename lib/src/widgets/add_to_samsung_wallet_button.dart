import 'package:flutter/material.dart';
import 'package:samsung_wallet/samsung_wallet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

const String _packagePrefix = 'packages/samsung_wallet/';

/// A widget for creating an "Add to Samsung Wallet" button.
class AddToSamsungWalletButton extends StatelessWidget {
  /// Constructor for AddToSamsungWalletButton.
  ///
  /// [onTapAddCard] called when the button is tapped.
  /// [buttonStyle] determines the visual style of the button.
  /// [buttonLocale] determines the language/locale of the button text.
  /// [isSvg] determines whether the button image should be in SVG format. Defaults to true.
  const AddToSamsungWalletButton({
    super.key,
    this.onTapAddCard,
    this.buttonStyle,
    this.buttonLocale,
    this.isSvg = true, // Defaults to true, specifying SVG format.
  });

  /// Constructor for AddToSamsungWalletButton with a test tool.
  factory AddToSamsungWalletButton.testTool() {
    final Uri testUrl =
        Uri.parse('https://partner.walletsvc.samsung.com/addToWalletTest');

    Future<void> launch() async {
      if (!await launchUrl(testUrl)) {
        throw Exception('Could not launch $testUrl');
      }
    }

    return AddToSamsungWalletButton(
      onTapAddCard: launch,
      isSvg: false,
    );
  }

  /// Default path for the button image.
  final String _defaultButtonPath = "assets/wallet/default_wallet_design";

  /// Called when the button is tapped.
  final VoidCallback? onTapAddCard;

  /// Determines the visual style of the button.
  final SamsungWalletButtonStyle? buttonStyle;

  /// Determines the language/locale of the button text.
  final SamsungWalletButtonLocale? buttonLocale;

  /// Determines whether the button image should be in SVG format. Defaults to true.
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    final walletPath = "$_packagePrefix${_getButtonPath()}";
    return GestureDetector(
      onTap: onTapAddCard,
      child: _walletImageWidget(walletPath),
    );
  }

  /// Returns the path for the button image based on style and locale.
  String _getButtonPath() {
    if (buttonStyle == null && buttonLocale == null) {
      return _defaultButtonPath;
    }
    String locale = _localePath(buttonLocale);
    String style = _stylePath(buttonStyle);
    return "assets/$locale/$style";
  }

  /// Returns the path for the button style.
  String _stylePath(SamsungWalletButtonStyle? style) =>
      (style ?? SamsungWalletButtonStyle.normal).toString();

  /// Returns the path for the button locale.
  String _localePath(SamsungWalletButtonLocale? locale) =>
      (locale ?? SamsungWalletButtonLocale.none).toString();

  /// Returns the widget for the button image based on the selected format.
  Widget _walletImageWidget(String path) => isSvg
      ? SvgPicture.asset("$path.svg") // Loads SVG format.
      : Image.asset("$path.png"); // Loads PNG format.
}
