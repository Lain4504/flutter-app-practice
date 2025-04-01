import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:english_words/english_words.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, first TEXT, second TEXT)',
        );
      },
    );
  }

  Future<void> insertFavorite(WordPair pair) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'first': pair.first, 'second': pair.second},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(WordPair pair) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'first = ? AND second = ?',
      whereArgs: [pair.first, pair.second],
    );
  }

  Future<List<WordPair>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return WordPair(maps[i]['first'], maps[i]['second']);
    });
  }
}
