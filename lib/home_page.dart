import 'package:flutter/material.dart';
import 'package:flutter_crypto/src/models/currency_model.dart';
import 'package:intl/intl.dart';
import 'package:cryptocoins_icons/cryptocoins_icons.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [], title: const Text("Crypto App")),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Column(
      children: [
        Flexible(
            child: ListView.builder(
                itemCount: widget.currencies.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final Currency currency = widget.currencies.data[index];
                  final MaterialColor color = _colors[index % _colors.length];

                  return _getListItemUi(
                      currency, color, widget.currencies.currency);
                })),
      ],
    );
  }

  ListTile _getListItemUi(
      Currency currency, MaterialColor color, String curSymbol) {
    return ListTile(
        leading: displayIcon(currency.icon, currency.symbol, color),
        title: Text(currency.name, style: boldStyle),
        subtitle: _getSubTitleText(
            currency.price.toString(), currency.percent_change_24h.toString()),
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

  Widget _getSubTitleText(String price, String pcntChange) {
    var oCcy = NumberFormat("#,##0.00", "en_AU");
    if (double.parse(price) < 1.00) {
      oCcy = NumberFormat("#,##0.000000", "en_AU");
    } else {
      oCcy = NumberFormat("#,##0.00", "en_AU");
    }
    String priceFormatted = "\$${oCcy.format(double.parse(price))}\n";
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

    return RichText(
        text: TextSpan(children: [priceTextWidget, pcntChangeTextWidget]));
  }
}
