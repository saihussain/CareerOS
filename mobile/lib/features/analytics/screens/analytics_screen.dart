import 'package:flutter/material.dart';

import '../models/analytics_model.dart';
import '../repositories/analytics_repository.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() =>
      _AnalyticsScreenState();
}

class _AnalyticsScreenState
    extends State<AnalyticsScreen> {
  final AnalyticsRepository repository =
      AnalyticsRepository();

  AnalyticsModel? analytics;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    try {
      analytics =
          await repository.getAnalytics();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Widget scoreCard(
    String title,
    int score,
    Color color,
    IconData icon,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor:
                  color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [

                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  LinearProgressIndicator(
                    value: score / 100,
                    minHeight: 8,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Text(
              "$score%",
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Analytics"),
      ),
      body: RefreshIndicator(
        onRefresh: loadAnalytics,
        child: ListView(
          padding:
              const EdgeInsets.all(20),
          children: [

            scoreCard(
              "Career Readiness",
              analytics!
                  .careerReadiness,
              Colors.blue,
              Icons.analytics,
            ),

            scoreCard(
              "Profile Completion",
              analytics!
                  .profileCompletion,
              Colors.green,
              Icons.person,
            ),

            scoreCard(
              "Resume Score",
              analytics!
                  .resumeScore,
              Colors.orange,
              Icons.description,
            ),

            scoreCard(
              "Interview Score",
              analytics!
                  .interviewScore,
              Colors.purple,
              Icons.record_voice_over,
            ),

            scoreCard(
              "Learning Progress",
              analytics!
                  .learningProgress,
              Colors.red,
              Icons.school,
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                        20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: const [

                    Text(
                      "Today's Recommendation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                        "• Improve Flutter State Management"),

                    SizedBox(height: 10),

                    Text(
                        "• Complete one Mock Interview"),

                    SizedBox(height: 10),

                    Text(
                        "• Build one REST API project"),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}