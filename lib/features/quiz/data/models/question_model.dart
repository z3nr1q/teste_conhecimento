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
      'options': options.join('|'),
      'correctOptionIndex': correctOptionIndex,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      question: map['question'],
      options: (map['options'] as String).split('|'),
      correctOptionIndex: map['correctOptionIndex'],
      category: map['category'],
      difficulty: map['difficulty'],
    );
  }
}
