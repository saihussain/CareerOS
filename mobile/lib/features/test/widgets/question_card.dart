import 'package:flutter/material.dart';

import '../models/question_model.dart';
import 'option_tile.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final int questionNumber;
  final int? selectedAnswer;
  final ValueChanged<int> onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(.10),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Q$questionNumber",
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                _Badge(
                  label: question.topic,
                  color: Colors.deepPurple,
                ),

                const SizedBox(width: 8),

                _Badge(
                  label: question.difficulty,
                  color: _difficultyColor(
                    question.difficulty,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            ...List.generate(
              question.options.length,
              (index) => OptionTile(
                option: question.options[index],
                index: index,
                selectedIndex: selectedAnswer,
                onTap: onAnswerSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green;

      case "medium":
        return Colors.orange;

      case "hard":
        return Colors.red;

      default:
        return Colors.blue;
    }
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color.withOpacity(.30),
        ),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}