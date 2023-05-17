import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:samsung_wallet/samsung_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool test = false;
  final _samsungWalletPlugin = SamsungWallet();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      test = await _samsungWalletPlugin.checkSamsungWalletSupported(
              parterCode: '4052995287435138240', countryCode: 'KR') ??
          false;
    } catch (e) {
      log("ERROR : $e");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $test\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initPlatformState();
          },
          child: Icon(Icons.textsms_sharp),
        ),
      ),
    );
  }
}
