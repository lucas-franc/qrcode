import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "users.db";
  static const _databaseVersion = 1;
  static const table = 'user';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnOcupation = 'ocupation';
  static const columnCpf = 'cpf';
  static const columnPhone = "phone";
  static const columnEmail = "email";
  static const columnStatus = 'status';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database = DatabaseHelper._database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
CREATE TABLE $table (
  $columnId INTEGER PRIMARY KEY,
  $columnName TEXT NOT NULL,
  $columnCpf TEXT NOT NULL,
  $columnOcupation TEXT NOT NULL,
  $columnPhone TEXT NOT NULL,
  $columnEmail TEXT NOT NULL,
  $columnStatus TEXT NOT NULL
);
""");
  }

  Future<int> insert(Map<String, dynamic> map) async {
    Database db = await instance.database;
    return await db.insert(table, map);
  }

  Future<List<User>> queryAllRows() async {
    Database db = await instance.database;
    var result = await db.query(table);

    List<User> list = result.isNotEmpty
        ? result.map((user) => User.fromMap(user)).toList()
        : [];
    return list;
  }

  Future<int> update(User user) async {
    Database db = await instance.database;
    int id = user.toMap()[columnId];
    return await db
        .update(table, user.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    Database db = await instance.database;
    return await db.close();
  }
}
