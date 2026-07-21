import 'package:flutter/material.dart';

import '../models/question_model.dart';

class TestReviewScreen extends StatefulWidget {
  final List<QuestionModel> questions;

  const TestReviewScreen({
    super.key,
    required this.questions,
  });

  @override
  State<TestReviewScreen> createState() =>
      _TestReviewScreenState();
}

class _TestReviewScreenState
    extends State<TestReviewScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final question =
        widget.questions[currentIndex];

    final bool correct =
        question.selectedAnswer ==
            question.correctAnswer;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Review ${currentIndex + 1}/${widget.questions.length}",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            LinearProgressIndicator(
              value:
                  (currentIndex + 1) /
                  widget.questions.length,
              minHeight: 8,
              borderRadius:
                  BorderRadius.circular(20),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                Colors.indigo
                                    .withOpacity(
                                        .1),
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        20),
                          ),
                          child: Text(
                            question.topic,
                            style:
                                const TextStyle(
                              color: Colors
                                  .indigo,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 20),

                        Text(
                          question.question,
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height: 25),

                        ...List.generate(
                          question
                              .options.length,
                          (index) {
                            final bool
                                isCorrect =
                                index ==
                                    question
                                        .correctAnswer;

                            final bool
                                isSelected =
                                index ==
                                    question
                                        .selectedAnswer;

                            Color border =
                                Colors.grey
                                    .shade300;

                            Color bg =
                                Colors.white;

                            IconData?
                                icon;

                            if (isCorrect) {
                              border =
                                  Colors.green;
                              bg = Colors
                                  .green
                                  .withOpacity(
                                      .08);
                              icon = Icons
                                  .check_circle;
                            }

                            if (isSelected &&
                                !isCorrect) {
                              border =
                                  Colors.red;
                              bg = Colors.red
                                  .withOpacity(
                                      .08);
                              icon = Icons
                                  .cancel;
                            }

                            return Container(
                              margin:
                                  const EdgeInsets
                                      .only(
                                bottom: 12,
                              ),
                              padding:
                                  const EdgeInsets
                                      .all(16),
                              decoration:
                                  BoxDecoration(
                                color: bg,
                                border:
                                    Border.all(
                                  color:
                                      border,
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            14),
                              ),
                              child: Row(
                                children: [

                                  Expanded(
                                    child:
                                        Text(
                                      question.options[
                                          index],
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            16,
                                      ),
                                    ),
                                  ),

                                  if (icon !=
                                      null)
                                    Icon(
                                      icon,
                                      color:
                                          border,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),

                        const SizedBox(
                            height: 20),

                        Card(
                          color: correct
                              ? Colors.green
                                  .shade50
                              : Colors.orange
                                  .shade50,
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .all(16),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [

                                Text(
                                  correct
                                      ? "Correct Answer"
                                      : "Explanation",
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    fontSize:
                                        17,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                Text(
                                  question
                                      .explanation,
                                  style:
                                      const TextStyle(
                                    height:
                                        1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                    onPressed: currentIndex == 0
                        ? null
                        : () {
                            setState(() {
                              currentIndex--;
                            });
                          },
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      currentIndex ==
                              widget.questions.length - 1
                          ? Icons.done
                          : Icons.arrow_forward,
                    ),
                    label: Text(
                      currentIndex ==
                              widget.questions.length - 1
                          ? "Finish Review"
                          : "Next",
                    ),
                    onPressed: () {
                      if (currentIndex ==
                          widget.questions.length - 1) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}