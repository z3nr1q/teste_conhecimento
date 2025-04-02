import 'dart:convert';

class QuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final int? correctOptionIndex; // Pode ser nulo para questões anuladas
  final String category;
  final int difficulty;
  
  // Campos opcionais
  final String? banca;
  final int? ano;
  final String? edital;
  final String? nivel;

  bool get isAnulada => correctOptionIndex == null;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    this.correctOptionIndex, // Agora é opcional
    required this.category,
    required this.difficulty,
    this.banca,
    this.ano,
    this.edital,
    this.nivel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': jsonEncode(options),
      'correctOptionIndex': correctOptionIndex,
      'category': category,
      'difficulty': difficulty,
      'banca': banca,
      'ano': ano,
      'edital': edital,
      'nivel': nivel,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      question: map['question'] as String,
      options: List<String>.from(
        map['options'] is String 
          ? jsonDecode(map['options'])
          : map['options'],
      ),
      correctOptionIndex: map['correctOptionIndex'] as int?,
      category: map['category'] as String,
      difficulty: map['difficulty'] as int,
      banca: map['banca'] as String?,
      ano: map['ano'] as int?,
      edital: map['edital'] as String?,
      nivel: map['nivel'] as String?,
    );
  }

  factory QuestionModel.fromJson(String source) => 
      QuestionModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, options: $options, correctOptionIndex: $correctOptionIndex, category: $category, difficulty: $difficulty)';
  }
}
