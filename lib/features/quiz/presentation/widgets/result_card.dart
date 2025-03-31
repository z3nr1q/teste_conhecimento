import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultCard extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRestart;

  const ResultCard({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions * 100).round();
    final resultMessage = _getResultMessage(percentage);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Resultado Final',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate().fadeIn().scale(),
            const SizedBox(height: 24),
            Text(
              '$score de $totalQuestions acertos',
              style: Theme.of(context).textTheme.headlineSmall,
            ).animate(delay: const Duration(milliseconds: 200))
              .fadeIn()
              .scale(),
            const SizedBox(height: 16),
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.displayLarge,
            ).animate(delay: const Duration(milliseconds: 400))
              .fadeIn()
              .scale(),
            const SizedBox(height: 16),
            Text(
              resultMessage,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ).animate(delay: const Duration(milliseconds: 600))
              .fadeIn()
              .scale(),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar Novamente'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ).animate(delay: const Duration(milliseconds: 800))
              .fadeIn()
              .scale(),
          ],
        ),
      ),
    );
  }

  String _getResultMessage(int percentage) {
    if (percentage >= 90) return 'Excelente! Você é um mestre!';
    if (percentage >= 70) return 'Muito bom! Continue assim!';
    if (percentage >= 50) return 'Bom trabalho! Mas você pode melhorar!';
    return 'Continue praticando! Você vai melhorar!';
  }
}
