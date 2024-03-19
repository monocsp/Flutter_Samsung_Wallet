import 'package:flutter/material.dart';
import 'package:samsung_wallet/samsung_wallet.dart';

import 'package:url_launcher/url_launcher.dart';

const String _packagePrefix = 'packages/samsung_wallet/';

/// A widget for creating an "Add to Samsung Wallet" button.
class AddToSamsungWalletButton extends StatelessWidget {
  /// Constructor for AddToSamsungWalletButton.
  ///
  /// [onTapAddCard] called when the button is tapped.
  /// [buttonDesignType] Determines the button design.
  /// [buttonTextPositionType] Determines the text position in button.
  /// [buttonThemeType] Determines button theme.

  const AddToSamsungWalletButton({
    super.key,
    this.onTapAddCard,
    this.buttonDesignType,
    this.buttonTextPositionType,
    this.buttonThemeType,
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
    );
  }

  /// Default path for the button image.
  final String _defaultButtonPath = "assets/wallet/default_wallet_design.png";

  /// Called when the button is tapped.
  final VoidCallback? onTapAddCard;

  /// Determines the button design.
  final ButtonDesignType? buttonDesignType;

  /// Determines the text position in button.
  final ButtonTextPositionType? buttonTextPositionType;

  /// Determines button theme.
  final ButtonThemeType? buttonThemeType;

  // /// Determines whether the button image should be in SVG format. Defaults to true.
  // final bool isSvg;

  @override
  Widget build(BuildContext context) {
    if (buttonDesignType == null &&
        buttonTextPositionType == null &&
        buttonThemeType == null) {
      return defaultButton();
    }

    final walletPath = "$_packagePrefix${_getButtonPath()}";
    return GestureDetector(
      onTap: onTapAddCard,
      child: _walletImage(walletPath),
    );
  }

  /// Default Setting about Button design
  Widget defaultButton() => GestureDetector(
        onTap: onTapAddCard,
        child: Image.asset(_packagePrefix + _defaultButtonPath),
      );

  /// Returns the path for the button image based on style and locale.
  String _getButtonPath() {
    if (buttonDesignType == null &&
        buttonTextPositionType == null &&
        buttonThemeType == null) {
      return _defaultButtonPath;
    }
    String design = (buttonDesignType ?? ButtonDesignType.addTo).name;
    String position =
        (buttonTextPositionType ?? ButtonTextPositionType.hor).name;
    String theme = (buttonThemeType ?? ButtonThemeType.pos).name;
    return "assets/wallet/buttons/rgb/Wallet_button_${design}_${position}_${theme}_RGB";
  }

  /// Returns the widget for the button image based on the selected format.
  Widget _walletImage(String path) =>
      // ? SvgPicture.asset(
      //     "$path.svg",
      //   ) // Loads SVG format.
      Image.asset("$path.png"); // Loads PNG format.
}
