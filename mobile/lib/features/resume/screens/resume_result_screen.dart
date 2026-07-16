import 'package:flutter/material.dart';

import '../models/resume_analysis_model.dart';

class ResumeResultScreen extends StatelessWidget {
  final ResumeAnalysisModel analysis;

  const ResumeResultScreen({
    super.key,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = analysis.rawData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Analysis"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _section(
            title: "Evaluation",
            child: Text(
              data["evaluation"]?.toString() ??
                  "Analysis unavailable",
            ),
          ),

          const SizedBox(height: 20),

          _listSection(
            "Strengths",
            data["strengths"],
          ),

          _listSection(
            "Weaknesses",
            data["weaknesses"],
          ),

          _listSection(
            "Missing Skills",
            data["missing_skills"],
          ),

          _listSection(
            "Recommended Skills",
            data["recommended_skills"],
          ),

          _listSection(
            "Recommended Projects",
            data["recommended_projects"],
          ),

          _listSection(
            "Learning Roadmap",
            data["learning_roadmap"],
          ),

          _listSection(
            "Interview Topics",
            data["interview_topics"],
          ),

          _listSection(
            "Priority Actions",
            data["priority_actions"],
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            child,
          ],
        ),
      ),
    );
  }

  Widget _listSection(
    String title,
    dynamic items,
  ) {
    List list = [];

    if (items is List) {
      list = items;
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: _section(
        title: title,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: list.isEmpty
              ? const [
                  Text("No data available")
                ]
              : list
                  .map(
                    (e) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          const Text("• "),

                          Expanded(
                            child: Text(
                              e.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}