import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc({required this.repository}) : super(const QuizLoadingState()) {
    on<LoadQuizEvent>(_onLoadQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<RestartQuizEvent>(_onRestartQuiz);
  }

  Future<void> _onLoadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    emit(const QuizLoadingState());
    try {
      final questions = await repository.getQuestions();
      if (questions.isEmpty) {
        emit(const QuizErrorState('Nenhuma questão encontrada'));
      } else {
        emit(QuizLoadedState(
          questions: questions,
          currentQuestionIndex: 0,
          score: 0,
        ));
      }
    } catch (e) {
      emit(QuizErrorState('Erro ao carregar questões: $e'));
    }
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoadedState) {
      final currentState = state as QuizLoadedState;
      final isCorrect = event.selectedOptionIndex ==
          currentState.currentQuestion.correctOptionIndex;

      final newScore = isCorrect ? currentState.score + 1 : currentState.score;
      final newIndex = currentState.currentQuestionIndex + 1;

      emit(currentState.copyWith(
        currentQuestionIndex: newIndex,
        score: newScore,
      ));
    }
  }

  void _onRestartQuiz(RestartQuizEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoadedState) {
      final currentState = state as QuizLoadedState;
      emit(QuizLoadedState(
        questions: currentState.questions,
        currentQuestionIndex: 0,
        score: 0,
      ));
    }
  }
}
