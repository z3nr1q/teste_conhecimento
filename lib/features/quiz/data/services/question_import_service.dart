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
          questao: item['questao'] ?? item['question'], // Suporta ambos os formatos
          opcoes: List<String>.from(item['opcoes'] ?? item['options']), // Suporta ambos os formatos
          indiceOpcaoCorreta: item['indiceOpcaoCorreta'] ?? item['correctOptionIndex'],
          assunto: item['assunto'] ?? item['category'], // Suporta ambos os formatos
          dificuldade: item['dificuldade'] ?? item['difficulty'], // Suporta ambos os formatos
          banca: item['banca'],
          ano: item['ano'],
          edital: item['edital'],
          nivel: item['nivel'],
          instituicao: item['instituicao'],
          tipoInstituicao: item['tipoInstituicao'],
          nivelInstituicao: item['nivelInstituicao'],
          cargo: item['cargo'],
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
