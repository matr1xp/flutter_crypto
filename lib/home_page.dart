import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crypto/src/models/currency_model.dart';
import 'package:intl/intl.dart';

import 'currencies.dart';

const boldStyle = TextStyle(fontWeight: FontWeight.bold);

class HomePage extends StatefulWidget {
  final Currencies currencies;
  // ignore: use_key_in_widget_constructors
  const HomePage(this.currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.pink];
  late Future<List<dynamic>> futureCurrencies;
  final String defaultLocale = Platform.localeName;

  @override
  void initState() {
    super.initState();
    futureCurrencies = widget.currencies.list(1, 100, 'AUD');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: futureCurrencies,
        builder: (context, snapshot) {
          return RefreshIndicator(
              displacement: 120,
              child: Scaffold(
                  appBar: AppBar(
                      actions: const [], title: const Text("Crypto App")),
                  body: _cryptoWidget(snapshot)),
              onRefresh: _pullRefresh);
        });
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    List<dynamic> freshFutureCurrencies =
        await widget.currencies.list(1, 100, 'AUD');
    setState(() {
      futureCurrencies = Future.value(freshFutureCurrencies);
    });
  }

  Widget _cryptoWidget(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Currency currency = snapshot.data[index];
            MaterialColor color = _colors[index % _colors.length];
            return _getListItemUi(currency, color, widget.currencies.currency);
          });
    } else {
      return const Center(child: Text('Loading data...'));
    }
  }

  ListTile _getListItemUi(
      Currency currency, MaterialColor color, String curSymbol) {
    return ListTile(
        leading: displayIcon(currency.icon, currency.symbol, color),
        title: Text(currency.name, style: boldStyle),
        subtitle: _getListBody(currency),
        isThreeLine: true,
        trailing: Text(currency.symbol),
        minLeadingWidth: 50);
  }

  Widget displayIcon(Icon? icon, String symbol, MaterialColor color) {
    return CircleAvatar(
        backgroundColor: icon == null ? color : null,
        foregroundColor: icon == null ? Colors.black : null,
        child: (icon ?? Text(symbol[0], style: boldStyle)));
  }

  Widget _getListBody(Currency currency) {
    String price = currency.price.toString();
    String pcntChange = currency.percent_change_24h.toString();
    var numFormat = NumberFormat.currency(locale: defaultLocale, symbol: "\$");
    if (double.parse(price) < 1.00) {
      numFormat = NumberFormat("#,##0.000000", defaultLocale);
    }
    String priceFormatted = "${numFormat.format(double.parse(price))}\n";
    TextSpan priceTextWidget = TextSpan(
        text: priceFormatted,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0));
    String pcntFormatted =
        "24H: " + (double.parse(pcntChange)).toStringAsFixed(2);
    TextSpan pcntChangeTextWidget;

    if (double.parse(pcntChange) > 0) {
      pcntChangeTextWidget = TextSpan(
          text: pcntFormatted,
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold));
    } else {
      pcntChangeTextWidget = TextSpan(
          text: pcntFormatted,
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
    }

    return Row(children: [
      Expanded(
          child: RichText(
              text:
                  TextSpan(children: [priceTextWidget, pcntChangeTextWidget]))),
      const Expanded(child: Text('') //Create Line graph widget,
          )
    ]);
  }
}
