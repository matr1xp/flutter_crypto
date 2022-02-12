// ignore_for_file: non_constant_identifier_names

import 'package:cryptocoins_icons/cryptocoins_icons.dart';
import 'package:flutter/material.dart';

class Currency {
  late int _id;
  late String _name;
  late String _symbol;
  late double _price;
  late double _percent_change_24h;
  late Icon? _icon;

  Currency.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _name = parsedJson['name'];
    _symbol = parsedJson['symbol'];

    var quoteKeys = parsedJson['quote'].keys;
    _price = parsedJson['quote'][quoteKeys.first]['price'];
    _percent_change_24h =
        parsedJson['quote'][quoteKeys.first]['percent_change_24h'];

    var cryptoIcon = CryptoCoinIcons.getCryptoIcon(_symbol);
    _icon = cryptoIcon != null ? Icon(cryptoIcon, size: 36.0) : null;
  }

  int get id => _id;
  String get name => _name;
  String get symbol => _symbol;
  double get price => _price;
  double get percent_change_24h => _percent_change_24h;
  Icon? get icon => _icon;
}
