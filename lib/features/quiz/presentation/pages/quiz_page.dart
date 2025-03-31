import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_state.dart';
import '../bloc/quiz_event.dart';
import '../widgets/question_card.dart';
import '../widgets/result_card.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Disparar evento para carregar as questões assim que a página for construída
    context.read<QuizBloc>().add(LoadQuizEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizLoadedState) {
            return state.isQuizFinished
                ? ResultCard(
                    score: state.score,
                    totalQuestions: state.questions.length,
                    onRestartQuiz: () {
                      context.read<QuizBloc>().add(RestartQuizEvent());
                    },
                  )
                : QuestionCard(
                    question: state.currentQuestion,
                    onAnswerSelected: (selectedIndex) {
                      context.read<QuizBloc>().add(
                            AnswerQuestionEvent(
                              selectedOptionIndex: selectedIndex,
                            ),
                          );
                    },
                  );
          } else if (state is QuizErrorState) {
            return Center(
              child: Text(
                'Erro: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: Text('Estado não tratado'),
          );
        },
      ),
    );
  }
}
