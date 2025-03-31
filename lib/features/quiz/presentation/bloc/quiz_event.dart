import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuizEvent extends QuizEvent {
  const LoadQuizEvent();
}

class AnswerQuestionEvent extends QuizEvent {
  final int selectedOptionIndex;

  const AnswerQuestionEvent({required this.selectedOptionIndex});

  @override
  List<Object?> get props => [selectedOptionIndex];
}

class RestartQuizEvent extends QuizEvent {
  const RestartQuizEvent();
}
