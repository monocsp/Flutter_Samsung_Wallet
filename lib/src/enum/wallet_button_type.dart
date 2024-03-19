enum ButtonDesignType {
  /// Add To Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/add-to-samsung-wallet_en.png)
  addTo(name: "AT"),

  /// Basic Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/wallet-card.png)
  basic(name: "basic"),

  /// Add To Samsung Wallet Button with Icon

  iconAddTo(name: "icon_AT"),

  /// Basic Samsung Wallet Button with Icon
  iconBasic(name: "icon_basic");

  const ButtonDesignType({required this.name});
  final String name;
}

enum ButtonTextPositionType {
  /// Horizontal Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/wallet-card-ver.png)
  hor(name: "hor"),

  /// Vertical Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/wallet-card.png)
  ver(name: "ver");

  const ButtonTextPositionType({required this.name});
  final String name;
}

enum ButtonThemeType {
  /// For Light Theme Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/wallet-card.png)
  pos(name: "pos"),

  /// For Dark Theme Samsung Wallet Button
  ///
  /// Image [Sample](https://d3unf4s5rp9dfh.cloudfront.net/SamsungWallet_doc/wallet-card-dark.png)
  rev(name: "rev");

  const ButtonThemeType({required this.name});
  final String name;
}
