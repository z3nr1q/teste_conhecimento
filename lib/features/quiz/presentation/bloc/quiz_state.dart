import 'package:equatable/equatable.dart';
import '../../data/models/question_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuestionModel> questions;
  final int currentQuestionIndex;
  final int score;
  final List<int> userAnswers;

  const QuizLoaded({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.userAnswers = const [],
  });

  @override
  List<Object?> get props => [questions, currentQuestionIndex, score, userAnswers];

  QuizLoaded copyWith({
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    int? score,
    List<int>? userAnswers,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      userAnswers: userAnswers ?? this.userAnswers,
    );
  }
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
