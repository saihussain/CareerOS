import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/resume_model.dart';
import '../repositories/resume_generator_repository.dart';
import '../repositories/resume_repository.dart';

import 'resume_preview_screen.dart';
import 'resume_result_screen.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final ResumeRepository analyzerRepository = ResumeRepository();

  final ResumeGeneratorRepository generatorRepository =
      ResumeGeneratorRepository();

  final TextEditingController roleController =
      TextEditingController(
    text: "Flutter Developer",
  );

  File? selectedResume;

  bool loadingAnalysis = false;
  bool loadingResume = false;

  Future<void> pickResume() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null &&
        result.files.single.path != null) {
      setState(() {
        selectedResume =
            File(result.files.single.path!);
      });
    }
  }

  Future<void> generateResume() async {
    try {
      setState(() {
        loadingResume = true;
      });

      ResumeModel resume =
          await generatorRepository.generateResume();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResumePreviewScreen(
            resume: resume,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loadingResume = false;
        });
      }
    }
  }

  Future<void> analyzeResume() async {
    if (selectedResume == null) return;

    try {
      setState(() {
        loadingAnalysis = true;
      });

      final response =
          await analyzerRepository.analyzeResume(
        resume: selectedResume!,
        targetRole:
            roleController.text.trim(),
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ResumeResultScreen(
            analysis: response,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
                  "Exception: ",
                  "",
                ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loadingAnalysis = false;
        });
      }
    }
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
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
        title: const Text(
          "Resume",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [

            const Icon(
              Icons.description,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              "CareerOS Resume",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Generate a professional ATS-friendly resume using your CareerOS profile.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.auto_awesome,
                ),
                onPressed: loadingResume
                    ? null
                    : generateResume,
                label: loadingResume
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Generate Resume",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 40),

            const Divider(),

            const SizedBox(height: 25),

            sectionTitle(
              "Analyze Existing Resume",
            ),

            TextField(
              controller: roleController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Target Role",
                hintText:
                    "Example: Flutter Developer",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child:
                  ElevatedButton.icon(
                onPressed:
                    pickResume,
                icon: const Icon(
                  Icons.upload_file,
                ),
                label: const Text(
                  "Choose Resume PDF",
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (selectedResume != null)
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                  ),
                  title: Text(
                    selectedResume!
                        .path
                        .split('/')
                        .last,
                    overflow:
                        TextOverflow
                            .ellipsis,
                  ),
                ),
              ),

            const SizedBox(height: 30),
                        SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: selectedResume == null || loadingAnalysis
                    ? null
                    : analyzeResume,
                child: loadingAnalysis
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Analyze Resume",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 40),

            Card(
              color: Colors.blue.shade50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Icon(
                          Icons.tips_and_updates,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "CareerOS Tip",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      "Generate your CareerOS resume first. "
                      "It automatically uses your Profile, "
                      "Education, Experience, Skills, Projects "
                      "and Achievements to build an ATS-friendly resume.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              color: Colors.green.shade50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Icon(
                          Icons.auto_graph,
                          color: Colors.green,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "AI Resume Analysis",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      "Already have a resume? "
                      "Upload it to receive AI-powered feedback "
                      "including strengths, weaknesses, "
                      "missing skills, interview topics "
                      "and a personalized learning roadmap.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}