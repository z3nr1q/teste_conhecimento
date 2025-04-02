import 'dart:convert';

class QuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String category;
  final int difficulty;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.category,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': jsonEncode(options), // Armazena as opções como JSON string
      'correctOptionIndex': correctOptionIndex,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      question: map['question'] as String,
      options: List<String>.from(
        map['options'] is String 
          ? jsonDecode(map['options']) 
          : map['options']
      ),
      correctOptionIndex: map['correctOptionIndex'] as int,
      category: map['category'] as String,
      difficulty: map['difficulty'] as int,
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
