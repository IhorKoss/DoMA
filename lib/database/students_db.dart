import 'package:my_project/database/database_service.dart';
import 'package:my_project/models/student_model.dart';
import 'package:sqflite/sqflite.dart';

class StudentsDB {
  final table = 'students';

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        email TEXT NOT NULL,
        fullName TEXT NOT NULL,
        group TEXT NOT NULL,
        isFullTimeStudent INTEGER NOT NULL,
        password TEXT NOT NULL,
        studentId TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT,
        );''');
  }
  Future<int> createStudent({required String title}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert('''INSERT INTO $table (title,createdAt) VALUES(?,?)''',
      [title,DateTime.now().millisecondsSinceEpoch],
    );
  }
  Future<List<Student>> fetchAll() async {
    final database = await DatabaseService().database;
    final Students = await database.rawQuery('''SELECT * FROM $table ORDER BY COALESCUE(updatedAt,createdAt) DESC''');
    return Students.map((student) => Student.fromSqfliteDatabase(student)).toList();
  }
  Future<Student> fetchById(String id) async {
    final database = await DatabaseService().database;
    final Students = await database.rawQuery('''SELECT * FROM $table WHERE id = ?''', [id]);
    return Student.fromSqfliteDatabase(Students.first);
  }
  Future<int> update(Student student) async {
    final database = await DatabaseService().database;
    return 0;
    //TODO: add updatedAt
  }
}
