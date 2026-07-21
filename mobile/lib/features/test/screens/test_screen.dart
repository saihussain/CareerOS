import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/test_controller.dart';
import '../widgets/progress_header.dart';
import '../widgets/question_card.dart';
import '../widgets/question_palette.dart';
import 'test_result_screen.dart';

class TestScreen extends StatelessWidget {
  final String category;
  final int stage;
  final int totalQuestions;
  final int duration;

  const TestScreen({
    super.key,
    required this.category,
    required this.stage,
    required this.totalQuestions,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestController()
        ..startTest(
          category: category,
          stage: stage,
          totalQuestions: totalQuestions,
          duration: duration,
        ),
      child: Consumer<TestController>(
        builder: (context, controller, child) {
          if (controller.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (controller.questions.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text("No questions found."),
              ),
            );
          }

          if (controller.isTimeUp) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _submitTest(
                context,
                controller,
              );
            });
          }

          return Scaffold(
            backgroundColor: const Color(0xffF6F8FC),

            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(category),
            ),

            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ProgressHeader(
                      currentQuestion:
                          controller.currentIndex + 1,
                      totalQuestions:
                          controller.questions.length,
                      answeredQuestions:
                          controller.answered,
                      time:
                          controller.formattedTime,
                    ),
                  ),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isMobile =
                            constraints.maxWidth < 700;

                        if (isMobile) {
                          return SingleChildScrollView(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Column(
                              children: [
                                QuestionCard(
                                  question:
                                      controller.currentQuestion,
                                  questionNumber:
                                      controller.currentIndex +
                                          1,
                                  selectedAnswer: controller
                                      .currentQuestion
                                      .selectedAnswer,
                                  onAnswerSelected:
                                      controller.selectAnswer,
                                ),

                                const SizedBox(height: 20),

                                Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(12),
                                    child: QuestionPalette(
                                      totalQuestions:
                                          controller
                                              .questions
                                              .length,
                                      currentQuestion:
                                          controller
                                              .currentIndex,
                                      answered: controller
                                          .answeredStatus,
                                      onQuestionSelected:
                                          controller
                                              .jumpToQuestion,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child:
                                    SingleChildScrollView(
                                  child: QuestionCard(
                                    question: controller
                                        .currentQuestion,
                                    questionNumber:
                                        controller
                                                .currentIndex +
                                            1,
                                    selectedAnswer:
                                        controller
                                            .currentQuestion
                                            .selectedAnswer,
                                    onAnswerSelected:
                                        controller
                                            .selectAnswer,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 250,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(
                                  right: 16,
                                ),
                                child: QuestionPalette(
                                  totalQuestions:
                                      controller
                                          .questions
                                          .length,
                                  currentQuestion:
                                      controller
                                          .currentIndex,
                                  answered: controller
                                      .answeredStatus,
                                  onQuestionSelected:
                                      controller
                                          .jumpToQuestion,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                                    Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.arrow_back),
                              label: const Text("Previous"),
                              onPressed: controller.isFirstQuestion
                                  ? null
                                  : controller.previousQuestion,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                controller.isLastQuestion
                                    ? Icons.check
                                    : Icons.arrow_forward,
                              ),
                              label: Text(
                                controller.isLastQuestion
                                    ? "Submit"
                                    : "Next",
                              ),
                              onPressed: () {
                                if (controller.isLastQuestion) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18),
                                      ),
                                      title: const Text(
                                        "Submit Test",
                                      ),
                                      content: Text(
                                        "Answered ${controller.answered} out of ${controller.questions.length} questions.\n\nDo you want to submit the test?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            _submitTest(
                                              context,
                                              controller,
                                            );
                                          },
                                          child: const Text("Submit"),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  controller.nextQuestion();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
    void _submitTest(
    BuildContext context,
    TestController controller,
  ) {
    controller.stopTimer();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TestResultScreen(
          category: category,
          stage: stage,
          totalQuestions: controller.questions.length,
          correct: controller.correct,
          wrong: controller.wrong,
          unanswered: controller.unanswered,
          percentage: controller.percentage,
          feedback: _feedback(
            controller.percentage,
          ),
          duration: duration,
          timeTaken:
              duration -
              (controller.remainingSeconds ~/ 60),
          questions: controller.questions,
        ),
      ),
    );
  }

  String _feedback(int score) {
    if (score >= 90) {
      return "Outstanding performance! You are placement ready.";
    }

    if (score >= 75) {
      return "Excellent work! Keep practicing.";
    }

    if (score >= 60) {
      return "Good job! Improve weak areas.";
    }

    if (score >= 40) {
      return "Average performance. Practice more.";
    }

    return "Keep learning and practicing consistently.";
  }
}