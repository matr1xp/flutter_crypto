import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crypto/home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
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
    "X-CMC_PRO_API_KEY": "563b5974-f5ee-490e-869c-a1f031d31ec6"
  });
  Map responseObject = json.decode(response.body);
  return responseObject['data'];
}
