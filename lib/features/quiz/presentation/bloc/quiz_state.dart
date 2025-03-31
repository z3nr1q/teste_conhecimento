import 'package:equatable/equatable.dart';
import '../../data/models/question_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoadingState extends QuizState {
  const QuizLoadingState();
}

class QuizLoadedState extends QuizState {
  final List<QuestionModel> questions;
  final int currentQuestionIndex;
  final int score;

  QuestionModel get currentQuestion => questions[currentQuestionIndex];
  bool get isQuizFinished => currentQuestionIndex >= questions.length;

  const QuizLoadedState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.score,
  });

  @override
  List<Object?> get props => [questions, currentQuestionIndex, score];

  QuizLoadedState copyWith({
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    int? score,
  }) {
    return QuizLoadedState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
    );
  }
}

class QuizErrorState extends QuizState {
  final String message;

  const QuizErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
