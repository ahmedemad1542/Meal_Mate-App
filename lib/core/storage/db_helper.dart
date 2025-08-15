
import 'package:meal_mate/features/home_screen/model/meal_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'meals.db');

    // لو عايز تمسح الداتا مرة واحدة أثناء التطوير فعّل السطرين دول مؤقتًا:
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2, 
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE meals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            cookingTime INTEGER,
            describtion TEXT,
            imagePath TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // أضف العمود لو مش موجود
          await db.execute('ALTER TABLE meals ADD COLUMN imagePath TEXT');
        }
      },
    );
  }

  Future<int> insertMeal(MealModel meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  Future<List<MealModel>> getAllMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('meals');
    return List.generate(maps.length, (i) => MealModel.fromMap(maps[i]));
  }

  // للمساعدة في التشخيص: اطبع أعمدة الجدول
  Future<void> debugPrintMealsSchema() async {
    final db = await database;
    final res = await db.rawQuery('PRAGMA table_info(meals)');
    debugPrint('meals columns: $res');
  }
}
