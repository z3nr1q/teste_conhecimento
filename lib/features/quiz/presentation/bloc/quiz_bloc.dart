import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc({required this.repository}) : super(QuizInitial()) {
    on<LoadQuiz>(_onLoadQuiz);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<RestartQuiz>(_onRestartQuiz);
  }

  Future<void> _onLoadQuiz(LoadQuiz event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final questions = await repository.getQuestions(
        category: event.category,
        difficulty: event.difficulty,
      );
      if (questions.isEmpty) {
        emit(const QuizError('Nenhuma questão encontrada'));
      } else {
        emit(QuizLoaded(questions: questions));
      }
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void _onAnswerQuestion(AnswerQuestion event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      final currentQuestion = currentState.questions[currentState.currentQuestionIndex];
      final isCorrect = event.answerIndex == currentQuestion.correctOptionIndex;
      
      final newScore = isCorrect ? currentState.score + 1 : currentState.score;
      final newAnswers = List<int>.from(currentState.userAnswers)..add(event.answerIndex);

      emit(currentState.copyWith(
        score: newScore,
        userAnswers: newAnswers,
      ));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.currentQuestionIndex < currentState.questions.length - 1) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
        ));
      }
    }
  }

  void _onRestartQuiz(RestartQuiz event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      emit(QuizLoaded(
        questions: currentState.questions,
        currentQuestionIndex: 0,
        score: 0,
        userAnswers: const [],
      ));
    }
  }
}
