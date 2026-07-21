import 'package:flutter/material.dart';

import '../repositories/interview_repository.dart';
import 'mock_interview_screen.dart';

class InterviewSetupScreen extends StatefulWidget {
  const InterviewSetupScreen({super.key});

  @override
  State<InterviewSetupScreen> createState() =>
      _InterviewSetupScreenState();
}

class _InterviewSetupScreenState
    extends State<InterviewSetupScreen> {
  final InterviewRepository repository =
      InterviewRepository();

  bool loading = false;

  String role = "Flutter Developer";

  String type = "Technical";

  String difficulty = "Easy";

  Future<void> startInterview() async {
    setState(() {
      loading = true;
    });

    try {
      final session =
          await repository.startInterview(
        role: role,
        type: type,
        difficulty: difficulty,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MockInterviewScreen(
            sessionId: session.sessionId,
            question: session.question,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

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

  Widget dropdown({
    required String title,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) {
          onChanged(v);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Interview",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            dropdown(
              title: "Target Role",
              value: role,
              items: const [

                "Flutter Developer",

                "Laravel Developer",

                "Java Developer",

                "Python Developer",

                "Full Stack Developer",

                "AI Engineer",

              ],
              onChanged: (v) {
                setState(() {
                  role = v;
                });
              },
            ),

            const SizedBox(height: 20),

            dropdown(
              title: "Interview Type",
              value: type,
              items: const [

                "Technical",

                "HR",

                "Mixed",

              ],
              onChanged: (v) {
                setState(() {
                  type = v;
                });
              },
            ),

            const SizedBox(height: 20),

            dropdown(
              title: "Difficulty",
              value: difficulty,
              items: const [

                "Easy",

                "Medium",

                "Hard",

              ],
              onChanged: (v) {
                setState(() {
                  difficulty = v;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    loading ? null : startInterview,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Start Interview",
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