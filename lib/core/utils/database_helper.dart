import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medicine_hours.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final fullPath = '$dbPath/$path';
    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE medicineHours(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            nextDoseTime TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveMedicineHour(String name, DateTime nextDoseTime) async {
    final db = await database;
    await db.insert(
      'medicineHours',
      {'name': name, 'nextDoseTime': nextDoseTime.toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateMedicineNextDoseTime(int id, DateTime nextDoseTime) async {
    final db = await database;
    await db.update(
      'medicineHours',
      {'nextDoseTime': nextDoseTime.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> fetchMedicineHours() async {
    final db = await database;
    return await db.query('medicineHours');
  }

  Future<void> deleteMedicine(int id) async {
    final db = await database;
    await db.delete('medicineHours', where: 'id = ?', whereArgs: [id]);
  }
}
