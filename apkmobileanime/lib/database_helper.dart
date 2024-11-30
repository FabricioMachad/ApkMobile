import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'animes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE animes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        animeId INTEGER UNIQUE,
        title TEXT,
        imageUrl TEXT,
        synopsis TEXT
      )
    ''');
  }

  Future<int> saveAnime(Map<String, dynamic> anime) async {
    final db = await database;
    return await db.insert(
      'animes',
      {
        'animeId': anime['mal_id'],
        'title': anime['title'],
        'imageUrl': anime['images']['jpg']['large_image_url'],
        'synopsis': anime['synopsis'],
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> deleteAnime(int animeId) async {
    final db = await database;
    return await db.delete(
      'animes',
      where: 'animeId = ?',
      whereArgs: [animeId],
    );
  }

  Future<List<Map<String, dynamic>>> getSavedAnimes() async {
    final db = await database;
    return await db.query('animes');
  }
}
