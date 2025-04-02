import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question_model.dart';

class QuizRepository {
  static const String _questionsKey = 'quiz_questions';
  final SharedPreferences _prefs;

  QuizRepository(this._prefs);

  Future<void> addQuestions(List<QuestionModel> questions) async {
    // Obtém as questões existentes
    final existingQuestions = await getAllQuestions();
    
    // Adiciona as novas questões
    final allQuestions = [...existingQuestions, ...questions];
    
    // Converte para JSON e salva
    final questionsJson = allQuestions.map((q) => q.toMap()).toList();
    await _prefs.setString(_questionsKey, json.encode(questionsJson));
  }

  Future<List<QuestionModel>> getQuestions({String? category, int? difficulty}) async {
    final questions = await getAllQuestions();
    
    return questions.where((q) {
      if (category != null && q.category != category) return false;
      if (difficulty != null && q.difficulty != difficulty) return false;
      return true;
    }).toList();
  }

  Future<List<QuestionModel>> getAllQuestions() async {
    final String? questionsJson = _prefs.getString(_questionsKey);
    if (questionsJson == null) return [];

    final List<dynamic> questionsMap = json.decode(questionsJson);
    return questionsMap.map((q) => QuestionModel.fromMap(q)).toList();
  }

  Future<void> clearQuestions() async {
    await _prefs.remove(_questionsKey);
  }
}
