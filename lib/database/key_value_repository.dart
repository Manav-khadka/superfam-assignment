import 'package:superfam_assignment/database/db_helper.dart';
import 'package:superfam_assignment/models/key_value_model.dart';

class KeyValueRepository {
  final dbHelper = DBHelper.dbHero;

  Future<int> insert(KeyValue keyValue) async {
    try {
      return await dbHelper.insertDb(keyValue.toMap());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<KeyValue>> getAllKeyValues() async {
    try {
      final List<Map<String, dynamic>> maps = await dbHelper.readDb();
      return List.generate(maps.length, (i) {
        return KeyValue(
          id: maps[i]['id'],
          key: maps[i]['key'],
          value: maps[i]['value'],
        );
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<int> update(KeyValue keyValue) async {
    try {
      return await dbHelper.updateDb(keyValue.toMap());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<int> delete(int id) async {
    try {
      return await dbHelper.deleteDb(id);
    } catch (e) {
      return Future.error(e);
    }
  }
}
