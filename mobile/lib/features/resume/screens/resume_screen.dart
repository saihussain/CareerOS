import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'resume_result_screen.dart';

import '../repositories/resume_repository.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final ResumeRepository repository = ResumeRepository();

  final TextEditingController roleController =
      TextEditingController(text: "Flutter Developer");

  File? selectedResume;

  bool loading = false;

  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedResume = File(result.files.single.path!);
      });
    }
  }

  Future<void> analyzeResume() async {
    if (selectedResume == null) return;

    setState(() {
      loading = true;
    });

    try {
      final response = await repository.analyzeResume(
        resume: selectedResume!,
        targetRole: roleController.text.trim(),
      );

      if (!mounted) return;

      
      Navigator.push(
        context,
       
        MaterialPageRoute(
            builder: (_) => ResumeResultScreen(
              analysis: response,
            ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst("Exception: ", ""),
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
  void dispose() {
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Analysis"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.picture_as_pdf,
              size: 90,
              color: Colors.red,
            ),

            const SizedBox(height: 20),

            const Text(
              "Upload Your Resume",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Upload your latest resume in PDF format and receive AI-powered analysis.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: roleController,
              decoration: const InputDecoration(
                labelText: "Target Role",
                hintText: "Example: Flutter Developer",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: pickResume,
                icon: const Icon(Icons.upload_file),
                label: const Text("Choose PDF"),
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
                    selectedResume!.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: selectedResume == null || loading
                    ? null
                    : analyzeResume,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Analyze Resume",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}