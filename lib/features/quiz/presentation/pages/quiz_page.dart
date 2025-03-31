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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<QuizBloc>().add(RestartQuiz()),
          ),
        ],
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizInitial) {
            context.read<QuizBloc>().add(const LoadQuiz());
            return const Center(child: Text('Iniciando quiz...'));
          }

          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizError) {
            return Center(child: Text(state.message));
          }

          if (state is QuizLoaded) {
            if (state.currentQuestionIndex >= state.questions.length) {
              return ResultCard(
                score: state.score,
                totalQuestions: state.questions.length,
                onRestart: () => context.read<QuizBloc>().add(RestartQuiz()),
              );
            }

            final currentQuestion = state.questions[state.currentQuestionIndex];
            return QuestionCard(
              question: currentQuestion,
              onAnswerSelected: (index) {
                context.read<QuizBloc>().add(AnswerQuestion(index));
                context.read<QuizBloc>().add(NextQuestion());
              },
            );
          }

          return const Center(child: Text('Estado não tratado'));
        },
      ),
    );
  }
}
