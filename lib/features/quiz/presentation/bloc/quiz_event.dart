import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuiz extends QuizEvent {
  final String? category;
  final int? difficulty;

  const LoadQuiz({this.category, this.difficulty});

  @override
  List<Object?> get props => [category, difficulty];
}

class AnswerQuestion extends QuizEvent {
  final int answerIndex;

  const AnswerQuestion(this.answerIndex);

  @override
  List<Object?> get props => [answerIndex];
}

class NextQuestion extends QuizEvent {}

class RestartQuiz extends QuizEvent {}
