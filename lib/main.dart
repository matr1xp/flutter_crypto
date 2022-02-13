// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_crypto/src/database.dart';
import 'package:flutter_crypto/src/routes/home.dart';
import 'package:sqflite/sqflite.dart';

import 'src/currencies.dart';

void main() async {
  var database = await SqlDatabase().init();
  var currencies = Currencies('AUD');
  await currencies.init();
  runApp(CryptoApp(database, currencies));
}

class CryptoApp extends StatefulWidget {
  final Database database;
  final Currencies currencies;
  // ignore: use_key_in_widget_constructors
  const CryptoApp(this.database, this.currencies);

  @override
  _CryptoAppState createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomePage(widget.database, widget.currencies));
  }
}
