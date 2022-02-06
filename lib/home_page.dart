import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cryptocoins_icons/cryptocoins_icons.dart';

class HomePage extends StatefulWidget {
  final List currencies;
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
                itemCount: widget.currencies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map currency = widget.currencies[index];
                  final MaterialColor color = _colors[index % _colors.length];

                  return _getListItemUi(currency, color);
                })),
      ],
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return ListTile(
        leading: _getCryptoIcon(currency['symbol'], color),
        title: Text(currency['name'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: _getSubTitleText(currency['quote']['AUD']['price'].toString(),
            currency['quote']['AUD']['percent_change_24h'].toString()),
        isThreeLine: true,
        trailing: Text(currency['symbol']),
        minLeadingWidth: 50);
  }

  Widget _getCryptoIcon(String symbol, MaterialColor color) {
    // ignore: unused_local_variable
    var iconData = CryptoCoinIcons.getCryptoIcon(symbol);
    var cryptoIcon = Icon(
      iconData,
      size: 20.0,
    );
    return CircleAvatar(
        // backgroundColor: color,
        child: (iconData != null ? cryptoIcon : Text(symbol[0])));
    // return CircleAvatar(backgroundColor: color, child: Text(symbol[0]));
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
