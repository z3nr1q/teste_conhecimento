import '../models/question_model.dart';

final List<QuestionModel> testQuestions = [
  QuestionModel(
    id: 1,
    question: 'Qual é a capital do Brasil?',
    options: ['São Paulo', 'Rio de Janeiro', 'Brasília', 'Salvador'],
    correctOptionIndex: 2,
    category: 'Geografia',
    difficulty: 1,
  ),
  QuestionModel(
    id: 2,
    question: 'Quem pintou a Mona Lisa?',
    options: ['Van Gogh', 'Leonardo da Vinci', 'Picasso', 'Michelangelo'],
    correctOptionIndex: 1,
    category: 'Arte',
    difficulty: 1,
  ),
  QuestionModel(
    id: 3,
    question: 'Qual é o maior planeta do Sistema Solar?',
    options: ['Terra', 'Marte', 'Saturno', 'Júpiter'],
    correctOptionIndex: 3,
    category: 'Ciências',
    difficulty: 1,
  ),
  QuestionModel(
    id: 4,
    question: 'Em que ano o Brasil foi descoberto?',
    options: ['1500', '1492', '1502', '1494'],
    correctOptionIndex: 0,
    category: 'História',
    difficulty: 1,
  ),
  QuestionModel(
    id: 5,
    question: 'Qual é o resultado de 8 x 7?',
    options: ['54', '56', '58', '60'],
    correctOptionIndex: 1,
    category: 'Matemática',
    difficulty: 1,
  ),
];
