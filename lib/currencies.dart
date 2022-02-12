// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:io';

import 'package:flutter_crypto/src/models/currency_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart';

class Currencies {
  late List data = [];
  final String apiUrl = "pro-api.coinmarketcap.com";
  final String endpoint = "/v1/cryptocurrency/listings/latest";
  late String apiKey = 'x-api-key';
  late String currency = 'USD';

  Currencies([String? currency]) {
    this.currency = currency!;
  }

  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    apiKey = dotenv.env['COINMARKETCAP_API_KEY']!;
    data = await list(1, 100, currency);
  }

  Future<List> list(int start, int limit, String _currency) async {
    var queryParams = {
      'start': start.toString(),
      'limit': limit.toString(),
      'convert': _currency.trim()
    };
    var uri = Uri.https(apiUrl, endpoint, queryParams);
    Response response = await get(uri, headers: {
      HttpHeaders.acceptHeader: "application/json",
      "X-CMC_PRO_API_KEY": apiKey
    });
    Map responseObject = json.decode(response.body);
    var _data = responseObject['data'];
    _data.forEach((element) {
      var test = Currency.fromJson(element);
      data.add(test);
    });

    currency = _currency;
    return data;
  }
}
