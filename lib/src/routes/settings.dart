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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                height: contentHeight,
                child: Center(child: Text(widget.settings.toString()))),
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
