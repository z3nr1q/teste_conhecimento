import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final Function(int) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question.question,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
          const SizedBox(height: 32),
          ...List.generate(
            question.options.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () => onAnswerSelected(index),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  question.options[index],
                  textAlign: TextAlign.center,
                ),
              ).animate(delay: Duration(milliseconds: 100 * index))
                .fadeIn()
                .slideX(begin: 0.2, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}
