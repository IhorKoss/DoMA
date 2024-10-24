import 'package:my_project/database/students_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }
  Future<String> get fullPath async {
    const name = 'students.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }
  Future<Database> _initialize() async {
    final path = await fullPath;
    var Database = await openDatabase(path, version: 1, onCreate: _create, singleInstance: true);
    return Database;
  }
  Future<void> _create(Database db, int version) async {
    await StudentsDB().createTable(db);
  }

}
