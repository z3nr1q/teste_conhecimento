import 'dart:convert';
import '../models/question_model.dart';
import '../repositories/quiz_repository.dart';

class QuestionImportService {
  final QuizRepository repository;

  QuestionImportService(this.repository);

  Future<int> importQuestionsFromJson(String jsonString) async {
    try {
      // Decodifica o JSON
      final List<dynamic> jsonList = json.decode(jsonString);
      
      // Converte cada item para QuestionModel
      final questions = jsonList.map((item) {
        return QuestionModel(
          id: item['id'],
          question: item['question'],
          options: List<String>.from(item['options']),
          correctOptionIndex: item['correctOptionIndex'],
          category: item['category'],
          difficulty: item['difficulty'],
        );
      }).toList();

      // Salva as questões
      await repository.addQuestions(questions);
      
      return questions.length;
    } catch (e) {
      print('Erro ao importar questões: $e');
      return 0;
    }
  }
}
