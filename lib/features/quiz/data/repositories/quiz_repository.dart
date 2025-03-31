import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/question_model.dart';

class QuizRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.dbName);
    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        options TEXT,
        correctOptionIndex INTEGER,
        category TEXT,
        difficulty INTEGER
      )
    ''');
  }

  Future<List<QuestionModel>> getQuestions({String? category, int? difficulty}) async {
    final db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (category != null) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }

    if (difficulty != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'difficulty = ?';
      whereArgs.add(difficulty);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'questions',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
    );

    return List.generate(maps.length, (i) => QuestionModel.fromMap(maps[i]));
  }

  Future<void> insertQuestion(QuestionModel question) async {
    final db = await database;
    await db.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
