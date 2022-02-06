// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crypto/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: ".env");
  List currencies = await getCurrencies();
  runApp(MyApp(currencies));
}

class MyApp extends StatefulWidget {
  final List _currencies;
  const MyApp(this._currencies);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomePage(widget._currencies));
  }
}

Future<List> getCurrencies() async {
  var queryParameters = {'start': '1', 'limit': '500', 'convert': 'AUD'};
  String cryptoUrl = "pro-api.coinmarketcap.com";
  var uri = Uri.https(
      cryptoUrl, "/v1/cryptocurrency/listings/latest", queryParameters);
  http.Response response = await http.get(uri, headers: {
    HttpHeaders.acceptHeader: "application/json",
    "X-CMC_PRO_API_KEY": dotenv.env['COINMARKETCAP_API_KEY']!
  });
  Map responseObject = json.decode(response.body);
  return responseObject['data'];
}
