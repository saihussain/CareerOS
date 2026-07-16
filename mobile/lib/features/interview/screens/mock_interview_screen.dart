import 'package:flutter/material.dart';

import '../repositories/interview_repository.dart';
import 'interview_result_screen.dart';

class MockInterviewScreen extends StatefulWidget {
  final int sessionId;
  final String question;

  const MockInterviewScreen({
    super.key,
    required this.sessionId,
    required this.question,
  });

  @override
  State<MockInterviewScreen> createState() =>
      _MockInterviewScreenState();
}

class _MockInterviewScreenState
    extends State<MockInterviewScreen> {
  final InterviewRepository repository =
      InterviewRepository();

  final TextEditingController answerController =
      TextEditingController();

  late String currentQuestion;

  int questionNumber = 1;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.question;
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  Future<void> submitAnswer() async {
    if (answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your answer."),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final result =
          await repository.submitAnswer(
        sessionId: widget.sessionId,
        questionNumber: questionNumber,
        answer: answerController.text.trim(),
      );

      if (!mounted) return;

      if (result.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => InterviewResultScreen(
              score: result.score,
              feedback: result.feedback,
            ),
          ),
        );
      } else {
        setState(() {
          questionNumber++;
          currentQuestion =
              result.nextQuestion ?? "";
          answerController.clear();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Question $questionNumber / 5",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  currentQuestion,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: TextField(
                controller: answerController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical:
                    TextAlignVertical.top,
                decoration:
                    const InputDecoration(
                  hintText:
                      "Type your answer...",
                  border:
                      OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    loading ? null : submitAnswer,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Submit Answer",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}