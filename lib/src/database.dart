import 'package:flutter/material.dart';
import 'package:flutter_crypto/src/models/settings_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  SqlDatabase();

  Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = await openDatabase(join(await getDatabasesPath(), 'crypto.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE settings(id INTEGER PRIMARY KEY, name TEXT, value TEXT)',
      );
    }, version: 1);
    Settings setting = Settings();
    setting.getById(db, 0).then((val) {
      if (val == 0) {
        Settings.fromJson({'id': 0, 'name': 'firstRun', 'value': 'false'})
            .insert(db);
        Settings.fromJson({'id': 1, 'name': 'currency', 'value': 'AUD'})
            .insert(db);
      }
    });
    return db;
  }
}
