import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../models/resume_model.dart';
import '../repositories/resume_generator_repository.dart';

class ResumePreviewScreen extends StatefulWidget {
  const ResumePreviewScreen({
    super.key,
    required this.resume,
  });

  final ResumeModel resume;

  @override
  State<ResumePreviewScreen> createState() =>
      _ResumePreviewScreenState();
}

class _ResumePreviewScreenState extends State<ResumePreviewScreen> {
  bool downloading = false;

  final ResumeGeneratorRepository repository =
      ResumeGeneratorRepository();

  Future<void> downloadResume() async {
    try {
      setState(() {
        downloading = true;
      });

      final response = await repository.downloadResume();

      final directory =
          await getApplicationDocumentsDirectory();

      final file = File(
        '${directory.path}/CareerOS_Resume.pdf',
      );

      await file.writeAsBytes(
        response.data!,
        flush: true,
      );

      await OpenFilex.open(file.path);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Resume saved to:\n${file.path}',
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
          downloading = false;
        });
      }
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 12,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bulletList(List list, String field) {
    if (list.isEmpty) {
      return const Text(
        "No information available.",
      );
    }

    return Column(
      children: list.map((item) {
        return Card(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item[field]?.toString() ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resume = widget.resume;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resume Preview",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    resume.header["name"] ?? "",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    resume.header["email"] ?? "",
                  ),
                  Text(
                    resume.header["phone"] ?? "",
                  ),
                  Text(
                    resume.header["location"] ?? "",
                  ),
                  const SizedBox(height: 8),
                  Text(
                    resume.header["linkedin"] ?? "",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    resume.header["github"] ?? "",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            sectionTitle(
              "Professional Summary",
            ),

            Text(
              resume.summary,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            sectionTitle(
              "Education",
            ),

            bulletList(
              resume.education,
              "institution",
            ),

            sectionTitle(
              "Experience",
            ),

            bulletList(
              resume.experience,
              "company",
            ),

            sectionTitle(
              "Skills",
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: resume.skills
                  .map(
                    (skill) => Chip(
                      label: Text(
                        skill["name"].toString(),
                      ),
                    ),
                  )
                  .toList(),
            ),

            sectionTitle(
              "Projects",
            ),

            bulletList(
              resume.projects,
              "title",
            ),

            sectionTitle(
              "Learning",
            ),

            bulletList(
              resume.learning,
              "title",
            ),

            sectionTitle(
              "Achievements",
            ),

            bulletList(
              resume.achievements,
              "title",
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed:
                    downloading ? null : downloadResume,
                icon: const Icon(
                  Icons.download,
                ),
                label: downloading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Download PDF",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}