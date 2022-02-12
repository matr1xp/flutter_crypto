import 'package:flutter/material.dart';
import 'package:flutter_crypto/home_page.dart';

import 'currencies.dart';

void main() async {
  var currencies = Currencies('AUD');
  await currencies.init();
  runApp(CryptoApp(currencies));
}

class CryptoApp extends StatefulWidget {
  final Currencies currencies;
  // ignore: use_key_in_widget_constructors
  const CryptoApp(this.currencies);

  @override
  _CryptoAppState createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomePage(widget.currencies));
  }
}
