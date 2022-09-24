import 'package:flutter/material.dart';
import 'package:flutter_crypto/src/models/settings_model.dart';
import 'package:sqflite/sqflite.dart';

class SettingsPage extends StatefulWidget {
  final Database database;
  final List<Settings> settings;
  final String currency;
  // ignore: use_key_in_widget_constructors
  const SettingsPage(this.database, this.settings, this.currency);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var contentHeight = MediaQuery.of(context).size.height / 1.3;
    String currencySelected = widget.settings[1].value.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                height: contentHeight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                  child: Container(
                    child: Column(
                      children: [
                        Text(widget.settings[1].name.toUpperCase(),
                            textAlign: TextAlign.left),
                        DropdownButton<String>(
                          value: currencySelected,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              currencySelected = newValue!;
                            });
                          },
                          items: <String>['AUD', 'USD', 'PHP']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width - 40, 40)),
              onPressed: () {
                print('Button pressed!');
              },
              child: const Text('Apply'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
