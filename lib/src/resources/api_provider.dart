import 'package:http/http.dart' show Client;
import '../models/currency_model.dart';
import 'dart:convert';

class ApiProvider {
  Client client = Client();
  fetchCurrencies() async {
    final response = await client
        .get(Uri.https("jsonplaceholder.typicode.com", "/currencies/1"));
    Currency itemModel = Currency.fromJson(json.decode(response.body));
    return itemModel;
  }
}
