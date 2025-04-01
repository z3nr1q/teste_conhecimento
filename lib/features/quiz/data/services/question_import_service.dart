import 'dart:convert';
import 'dart:io';
import '../models/question_model.dart';
import '../repositories/quiz_repository.dart';

class QuestionImportService {
  final QuizRepository repository;

  QuestionImportService({required this.repository});

  Future<List<QuestionModel>> importFromJson(String filePath) async {
    try {
      // Lê o arquivo JSON
      final file = File(filePath);
      final jsonString = await file.readAsString();
      final jsonData = json.decode(jsonString);

      // Valida o formato do JSON
      if (!jsonData.containsKey('questions') || 
          !(jsonData['questions'] is List)) {
        throw FormatException('Formato de JSON inválido. Deve conter uma lista "questions".');
      }

      // Converte cada item para QuestionModel
      final questions = (jsonData['questions'] as List)
          .map((item) => QuestionModel.fromMap(item))
          .toList();

      // Valida cada questão
      for (var question in questions) {
        if (question.options.length < 2) {
          throw FormatException(
              'Questão ${question.id} deve ter pelo menos 2 opções.');
        }
        if (question.correctOptionIndex >= question.options.length) {
          throw FormatException(
              'Índice da resposta correta inválido na questão ${question.id}.');
        }
      }

      // Salva as questões no repositório
      await repository.addQuestions(questions);

      return questions;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao importar questões: $e');
    }
  }

  Future<String> exportToJson(List<QuestionModel> questions) async {
    try {
      final jsonData = {
        'questions': questions.map((q) => q.toMap()).toList(),
      };

      return const JsonEncoder.withIndent('  ').convert(jsonData);
    } catch (e) {
      throw Exception('Erro ao exportar questões: $e');
    }
  }
}
