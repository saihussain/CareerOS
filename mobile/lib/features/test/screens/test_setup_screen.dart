import 'package:flutter/material.dart';

import 'test_screen.dart';

class TestSetupScreen extends StatefulWidget {
  const TestSetupScreen({super.key});

  @override
  State<TestSetupScreen> createState() => _TestSetupScreenState();
}

class _TestSetupScreenState extends State<TestSetupScreen> {
  final List<String> categories = [
    "Aptitude",
    "Programming",
    "Problem Solving",
  ];

  final List<String> stages = [
    "Stage 1 • Foundation",
    "Stage 2 • Beginner",
    "Stage 3 • Intermediate",
    "Stage 4 • Advanced",
    "Stage 5 • Expert",
  ];

  final List<int> questionCounts = [
    10,
    20,
    30,
  ];

  String selectedCategory = "Aptitude";
  int selectedStage = 1;
  int selectedQuestions = 10;

  int get duration {
    switch (selectedQuestions) {
      case 10:
        return 15;
      case 20:
        return 30;
      default:
        return 45;
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(
        title: const Text("Start Test"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const SizedBox(height: 10),

          const Icon(
            Icons.quiz,
            size: 70,
            color: Colors.indigo,
          ),

          const SizedBox(height: 20),

          const Text(
            "CareerOS Assessment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Select your preferences and begin your assessment.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          sectionTitle("Category"),

          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            items: categories
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
          ),

          const SizedBox(height: 25),

          sectionTitle("Stage"),

          DropdownButtonFormField<int>(
            value: selectedStage,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            items: List.generate(
              5,
              (index) => DropdownMenuItem(
                value: index + 1,
                child: Text(stages[index]),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedStage = value!;
              });
            },
          ),

          const SizedBox(height: 25),

          sectionTitle("Questions"),

          Wrap(
            spacing: 10,
            children: questionCounts.map((count) {
              return ChoiceChip(
                label: Text("$count Questions"),
                selected: selectedQuestions == count,
                onSelected: (_) {
                  setState(() {
                    selectedQuestions = count;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 0,
            color: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text("Duration"),
                    trailing: Text("$duration mins"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text("Difficulty"),
                    trailing: Text("Stage $selectedStage"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text("Questions"),
                    trailing: Text("$selectedQuestions"),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 35),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text(
                "Start Test",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TestScreen(
                      category: selectedCategory,
                      stage: selectedStage,
                      totalQuestions: selectedQuestions,
                      duration: duration,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}