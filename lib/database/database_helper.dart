import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Se o banco de dados não estiver inicializado, inicializa-o.
    _database = await _initDB('medicine_hours.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();

    // Caminho absoluto para o banco de dados
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

  // Função para salvar os dados no banco com o Document Id como id
  Future<void> saveMedicineHour(String name, DateTime nextDoseTime) async {
    final db = await instance.database;
    await db.insert(
      'medicineHours',
      {'name': name, 'nextDoseTime': nextDoseTime.toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.replace, // Substitui caso o documento já exista
    );
  }

  // Função para buscar os dados
  Future<List<Map<String, dynamic>>> fetchMedicineHours() async {
    final db = await instance.database;
    return await db.query('medicineHours');
  }

  // Função para atualizar a próxima dose no banco de dados
  Future<void> updateNextDoseTime(int id, DateTime nextDoseTime) async {
    final db = await instance.database;
    await db.update(
      'medicineHours',
      {'nextDoseTime': nextDoseTime.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id], // Usando o id numérico para identificar o registro
    );
  }
}
