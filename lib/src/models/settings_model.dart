import 'package:sqflite/sqflite.dart';

class Settings {
  late int _id;
  late String _name;
  late String _value;

  Settings();

  Settings.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _name = parsedJson['name'];
    _value = parsedJson['value'];
  }

  int get id => _id;
  String get name => _name;
  String get value => _value;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'value': _value,
    };
  }

  @override
  String toString() {
    return 'Setting {id: $id, name: $name, value: $value}';
  }

  Future<int> insert(Database db) async {
    return await db.insert(
      'settings',
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getById(Database db, id) async {
    List<Map> setting = await db.query('settings',
        columns: ['id', 'name', 'value'], where: 'id = ?', whereArgs: [id]);
    if (setting.length == 1) {
      _id = setting.first['id'];
      _name = setting.first['name'];
      _value = setting.first['value'];
    }
    return setting.length;
  }

  Future<List<Settings>> getAll(Database db) async {
    List<Map> results =
        await db.query('settings', columns: ['id', 'name', 'value']);
    List<Settings> settings = [];

    for (var element in results) {
      Map<String, dynamic> map = {};
      element.forEach((key, value) => map[key] = value);
      settings.add(Settings.fromJson(map));
    }
    return settings;
  }
}
