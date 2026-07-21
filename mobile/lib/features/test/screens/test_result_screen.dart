import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'test_review_screen.dart';

class TestResultScreen extends StatelessWidget {
  final String category;
  final int stage;
  final int totalQuestions;
  final int correct;
  final int wrong;
  final int unanswered;
  final int percentage;
  final String feedback;
  final int duration;
  final int timeTaken;
  final List<QuestionModel> questions;

  const TestResultScreen({
    super.key,
    required this.category,
    required this.stage,
    required this.totalQuestions,
    required this.correct,
    required this.wrong,
    required this.unanswered,
    required this.percentage,
    required this.feedback,
    required this.duration,
    required this.timeTaken,
    required this.questions,
  });

  Color get scoreColor {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Test Result"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              CircleAvatar(
                radius: 65,
                backgroundColor:
                    scoreColor.withOpacity(.12),
                child: Text(
                  "$percentage%",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                feedback,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [

                  Expanded(
                    child: _StatCard(
                      title: "Correct",
                      value: correct.toString(),
                      color: Colors.green,
                      icon: Icons.check_circle,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _StatCard(
                      title: "Wrong",
                      value: wrong.toString(),
                      color: Colors.red,
                      icon: Icons.cancel,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: _StatCard(
                      title: "Skipped",
                      value: unanswered.toString(),
                      color: Colors.orange,
                      icon: Icons.help_outline,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _StatCard(
                      title: "Accuracy",
                      value: "$percentage%",
                      color: Colors.indigo,
                      icon: Icons.analytics,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [

                      _InfoRow(
                        title: "Category",
                        value: category,
                      ),

                      const Divider(),

                      _InfoRow(
                        title: "Stage",
                        value: "Stage $stage",
                      ),

                      const Divider(),

                      _InfoRow(
                        title: "Questions",
                        value: "$totalQuestions",
                      ),

                      const Divider(),

                      _InfoRow(
                        title: "Duration",
                        value: "$duration min",
                      ),

                      const Divider(),

                      _InfoRow(
                        title: "Time Taken",
                        value: "$timeTaken min",
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.visibility),
                  label:
                      const Text("Review Answers"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TestReviewScreen(
                            questions: questions,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.home),
                  label:
                      const Text("Back to Dashboard"),
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ),
                            const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(.12),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}