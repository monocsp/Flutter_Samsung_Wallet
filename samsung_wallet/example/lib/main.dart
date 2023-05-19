import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
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
  final _samsungWalletPlugin = SamsungWallet(
      countryCode: "KR",
      parterCode: "4052995287435138240",
      impressionURL:
          "https://us-rd.mcsvc.samsung.com/statistics/impression/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=1287098641030840334;co=4052995287435138240;cp=1288017491089625089;si=24;pg=101212967375212546;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4053008150902138496;li=0");

  @override
  void initState() {
    super.initState();
    // initPlatformState();
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

  addCard() async {
    bool result = await _samsungWalletPlugin.addCardToSamsungWallet(
            cardID: "3gfp5mb835p00",
            cData:
                "eyJjdHkiOiJDQVJEIiwidmVyIjoiMiIsInBhcnRuZXJJZCI6IjQwNTI5OTUyODc0MzUxMzgyNDAiLCJ1dGMiOjE2ODM2OTAzMjg0MzAsImFsZyI6IlJTMjU2In0.ZXlKbGJtTWlPaUpCTVRJNFIwTk5JaXdpWVd4bklqb2lVbE5CTVY4MUluMC5kVFVZdVNJZDBkNUhoUGNVQTJmcUJTdWx1QVFpcmxGVVVFMDdDTUN2bHFJcTNUZldxV0xsWEcxLXJfSlZKQnpXZFpJVmJFVy1oalVKbDF2bXRld2xURWxoQkF5blMxSGFxZTdjVVpBOW83Y2xoa3RKVW1CdkpWSUFXUV9xS0hmOVB6c1dFM1lLVWZEOXJTZ0VEdjZmUzloZTgyNlR3MDhnZllxRy1aMjNkbVJVRDhLeGZCN3FpVEpqejhId1pwQ2ZrTkdNb21xbGF6V3dKNVdqVGY3YVE0M0xSeTA1WUIwcFI4aFh0N1BKVXFpQzZnWWpvajhxal9Xd1pXY3JhODZmU3VYdVYyWU4xUUE3Vk9Fa0lJR21HUWwwUXR6aTNfMmFkbVluOGxrQ3RIMXkxRmEyZUZpdEktNXpya1M2S1ZLcGp0a29zbmlJLVN6cVF3VlluN0dMRWcudDdQSWxmMjNIWGtrMWtvci5HR3JZbWJtNzhyaUxWUWFzeFRDd2xFbllGamJBNlJ4TmdKWTNHOVFvM0lRSVpZc2p2ZlNjVlJNVUVQbDV2NmYzYlRXR2ViaGhKNm1CU0hMNUp1bVU0ZFNvT1d2enJFMnJoazd1X3NvbUE2OXVHbmVhSGFfa0otVnR0OXNtaTdCeTlhdW5DZ1BtWXliS1M4b2V6QWtoeVRLZWhaQ1FScDdnMmZMd2o2cXpFVUZGV3Y1RURpeHRubUpaNXBwSUJtYm93VTBsS2N5TDZha2IyOVliRjNpTDRVYmsxdXFqUWtPWnFfaVY0NmgyRmZnUTg1RW14ck1INE5ER185OXdDeHdEcGUxRlpUaEFIWXNpVWtKTlRhdThJLXd1RVh3NFdheW5VVkU0LVlnOURpRmU3aVRlT3NxSmxxSV9mR2dIM2NZWl9OTDhyR05iTzlkMzR0Mk1PNHJyM0FVRjJjaEZRLW5DdVZoUjN2TlBYaXVyTkZsNkx2QUt0eHJNalRXSHpxS1BuQ3l3RDlhbS1QdjdKdmtUNURYX0dzR1lJUHlUXzZoY1hBZDBiSVB4QkJLUWJWbEE1clJIUnlWSVJaVFdQUjdEWjN3dmRMYzRVWjFEaF96M0pTbnlVZDkwOW5EdHZieXBTcmVaeHlkM3dINnJqdjhwNFNnWmRyb1pVbklfNEFtS3pnLWUxNW1jWVVMQktBZjdnNkxmTEp5QzJtOEIyOXJLaHVzTXpBbUdWQWs1QWZlOG5wcElKWUJzM1V2cEFLSEpiT3U1a3EySE5MYVNMWEk4WkVpZElvek5OelktR3YxNGZTM19pbWtHb2pNOWdvTm1kb0lRcDd2TDBDc0xPQVFMSTZxb0NVZmZJNUgzTHZJcjd6MnRXTUtYOVAxTmN4ZV9TNjhDLTlHLXlRTXpGb2hxMHZtTVU1ck96b0lrcE9uZ0FSSV9fNUtNcFZNU3NsWmV3TmJ2QUwzLTByT0ltUG1hY0FaX0Z3T25mUnpnSGNlVVBrRFZRUk1Lc3psRzJ4RDlxOGlUMmF2XzMtanFINW1IbUYyR3ljcWUtaU54STRSU09Fd2Q1MlRGMDVlOUdLZlZRZHVfb1NNV25BLTl2MF8waEV1bFV6WXVkclRhNXBySTBVSlZYUjB5ODZiOFdwRTBVZXVXVWkxeTJ5dXhrNGVkSWdwc2p2TjN4MmRPQnpMZm5KZjBfODhLNElxVGVOODJENVNnM2ZYM0tnZHpXR1VtNGlHSnRHajNCWWh6YnF6NVNRamJNOWpSaDB1VFEwVU1RaXRWWkxsR25DUXZUa0hLa2E0eFNSRy11bmFjSXZIZEhFWmtDQVhMRlZOQ1h0aENMbVNQV2xKaFFTSElDdlVsYVVjd3ByaXBBODdiMTVzQTROQXBKWW0yUmJybDVBMGJjb1VVMVVnRFZDc3dBeXJmMi0zd2tEblBRYURxTmIyZEtjbFlzWWlxdTlsQzJGRG9xR1NLZDVTZ2R4RFR2RTNIS2FUSWxDRlBjR2JSTDhvaWd0Z0ZUNW50dU10c0ZQcWdGRWhuTE9ZWGh5TnFaYlFxZFpiOS01TzBJSDVTU1dEaVpQRmZ1bkpkRzhoQXdoWDgyd2otd0Z6Zy1NZThFRzJLalJoSFhIRXp4N1NqVGtWUmtNVlRYcWRfQlVnT2luRjhSSHNmby1fdnVIWVZCbmtlWmtBdVZRdVlmbHRCTzVvMGFLbUIzX3lxX01TVXNiQzBPbDJRSFBJT0p6dlpveDNfQlFzMjJjeEF2RFZNMS05SFJLcU5VU3B5QWtzY0cxeVg1cUlLT2V6SmFxcERVX1NuU2tNaGtUMm1od3ZPaGh4Z2J5eVQ3UHU0SXFZbVFfRTNIR2xwOWJET3UxQlF2a25IRF80MEMtZjBCZ3VzSURoc0JjT1lCN1VMb0Jwc28tRmdtWkRfcWs2MmhibW81VWdQdF9yUXVhTjNLQjVEZktySVNVNzg4MUhhNmQzYzRBTFR3d05uNDBsTEQtaWstcm1iMEEucThqUlpfNEw1ODZzclBHRUJtRFZGUQ.FxpuM0ySugGGP5Gj79hmG9sqP3GSXkVlnENHIcaL_P6JJqhWC1xUUYFWSqA4-lpGkQp60O99Nxlw-bKkBwHZdqlEd1KlfDl2DbkIkc3cd9aTPeu7M7NXAqBCtOc9Muwa0nRPXt3opk48hQxOtviqU6JDOjMREARTtHRYwQvmB5wADeeKCbLPRVI_Gk96XjX-fRZm_OzJt97abO0abMPbafbfGyeXuNV8gy82ZGCN1dyC_gfe2euBDVee_P2-u26FqwM3BpILfC5GB-25FlVdmi73covpKPbfEbud3nv0EJzhfEa7dYuvw8sS-BVwGIq52MjdyZz7Fg21UnWHDDqujQ",
            clickURL:
                "https://us-rd.mcsvc.samsung.com/statistics/click/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=1287098641019830286;co=4052995287435138240;cp=1288017491089625089;si=24;pg=101212967375212546;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4052999701162138240;li=0") ??
        false;
    log("RESULT : $result");
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
            // initPlatformState();
            addCard();
          },
          child: Icon(Icons.textsms_sharp),
        ),
      ),
    );
  }
}
