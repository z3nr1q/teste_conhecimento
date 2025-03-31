import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultCard extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRestartQuiz;

  const ResultCard({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions * 100).round();
    final resultMessage = _getResultMessage(percentage);
    final resultColor = _getResultColor(percentage);

    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Resultado',
                style: Theme.of(context).textTheme.headlineMedium,
              ).animate()
                .fadeIn()
                .scale(),
              const SizedBox(height: 24),
              Text(
                '$score/$totalQuestions',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: resultColor,
                  fontWeight: FontWeight.bold,
                ),
              ).animate()
                .fadeIn()
                .scale(delay: 200.ms),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: resultColor,
                ),
              ).animate()
                .fadeIn()
                .scale(delay: 400.ms),
              const SizedBox(height: 16),
              Text(
                resultMessage,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ).animate()
                .fadeIn()
                .scale(delay: 600.ms),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRestartQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar Novamente'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ).animate()
                .fadeIn()
                .scale(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  String _getResultMessage(int percentage) {
    if (percentage >= 90) {
      return 'Excelente! Você é um mestre!';
    } else if (percentage >= 70) {
      return 'Muito bom! Continue assim!';
    } else if (percentage >= 50) {
      return 'Bom trabalho! Mas você pode melhorar.';
    } else {
      return 'Continue tentando! A prática leva à perfeição.';
    }
  }

  Color _getResultColor(int percentage) {
    if (percentage >= 90) {
      return Colors.green;
    } else if (percentage >= 70) {
      return Colors.blue;
    } else if (percentage >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
