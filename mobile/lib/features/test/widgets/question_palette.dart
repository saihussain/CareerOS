import 'package:flutter/material.dart';

class QuestionPalette extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestion;
  final List<bool> answered;
  final ValueChanged<int> onQuestionSelected;

  const QuestionPalette({
    super.key,
    required this.totalQuestions,
    required this.currentQuestion,
    required this.answered,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Question Palette",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalQuestions,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                final bool isCurrent =
                    index == currentQuestion;

                final bool isAnswered =
                    answered[index];

                Color background;

                Color textColor;

                if (isCurrent) {
                  background = Colors.orange;
                  textColor = Colors.white;
                } else if (isAnswered) {
                  background = Colors.green;
                  textColor = Colors.white;
                } else {
                  background = Colors.grey.shade200;
                  textColor = Colors.black87;
                }

                return InkWell(
                  borderRadius:
                      BorderRadius.circular(12),
                  onTap: () =>
                      onQuestionSelected(index),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: textColor,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 18,
              runSpacing: 10,
              children: const [
                _Legend(
                  color: Colors.orange,
                  text: "Current",
                ),
                _Legend(
                  color: Colors.green,
                  text: "Answered",
                ),
                _Legend(
                  color: Colors.grey,
                  text: "Unanswered",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}