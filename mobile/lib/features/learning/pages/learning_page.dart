import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/learning_model.dart';
import '../repositories/learning_repository.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final LearningRepository repository = LearningRepository();

  final TextEditingController roleController =
      TextEditingController(text: "Flutter Developer");

  File? resume;

  LearningModel? roadmap;

  bool loading = false;

  Future<void> pickResume() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null &&
        result.files.single.path != null) {
      setState(() {
        resume = File(result.files.single.path!);
      });
    }
  }

  Future<void> generateRoadmap() async {
    if (resume == null) return;

    setState(() {
      loading = true;
    });

    try {
      roadmap = await repository.generateRoadmap(
        resume: resume!,
        targetRole: roleController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
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

  Widget buildSection(
    String title,
    List<String> items,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
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
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...items.map(
              (e) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(
                      child: Text(e),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Roadmap"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: roleController,
              decoration: const InputDecoration(
                labelText: "Target Role",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: pickResume,
                icon: const Icon(Icons.upload_file),
                label: const Text("Choose Resume"),
              ),
            ),

            if (resume != null)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  resume!.path.split("/").last,
                ),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    loading ? null : generateRoadmap,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Generate Roadmap",
                      ),
              ),
            ),

            const SizedBox(height: 30),

            if (roadmap != null) ...[

              buildSection(
                "Skills To Learn",
                roadmap!.skills,
              ),

              buildSection(
                "Recommended Courses",
                roadmap!.courses,
              ),

              buildSection(
                "Projects",
                roadmap!.projects,
              ),

              buildSection(
                "Certifications",
                roadmap!.certifications,
              ),

            ],
          ],
        ),
      ),
    );
  }
}