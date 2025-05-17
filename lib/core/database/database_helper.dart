import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'claud_assistant.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        last_login TEXT,
        settings TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE finances(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        amount REAL,
        category TEXT,
        description TEXT,
        date TEXT,
        username TEXT
      )
    ''');

    // Añadir más tablas aquí
  }

  Future<void> insertInitialUser() async {
    Database db = await database;
    await db.insert('user_data', {
      'username': 'audioblazepro',
      'last_login': DateTime.now().toUtc().toString(),
      'settings': '{"theme":"dark","notifications":true}'
    });
  }
}