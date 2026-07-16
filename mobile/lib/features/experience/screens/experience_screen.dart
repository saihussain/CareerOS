import 'package:flutter/material.dart';

import '../models/experience_model.dart';
import '../repositories/experience_repository.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() =>
      _ExperienceScreenState();
}

class _ExperienceScreenState
    extends State<ExperienceScreen> {
  final ExperienceRepository repository =
      ExperienceRepository();

  List<ExperienceModel> experiences = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadExperiences();
  }

  Future<void> loadExperiences() async {
    try {
      experiences =
          await repository.getExperiences();
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

  Future<void> deleteExperience(
      int id) async {
    await repository.deleteExperience(id);

    await loadExperiences();
  }

  void addExperienceDialog() {
    final company =
        TextEditingController();

    final title =
        TextEditingController();

    final employment =
        TextEditingController();

    final location =
        TextEditingController();

    final start =
        TextEditingController();

    final end =
        TextEditingController();

    final description =
        TextEditingController();

    bool current = false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialog) {
            return AlertDialog(
              title: const Text(
                "Add Experience",
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller: company,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Company Name",
                      ),
                    ),

                    TextField(
                      controller: title,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Job Title",
                      ),
                    ),

                    TextField(
                      controller:
                          employment,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Employment Type",
                      ),
                    ),

                    TextField(
                      controller:
                          location,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Location",
                      ),
                    ),

                    TextField(
                      controller:
                          start,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Start Date",
                      ),
                    ),

                    TextField(
                      controller:
                          end,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "End Date",
                      ),
                    ),

                    TextField(
                      controller:
                          description,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Description",
                      ),
                    ),

                    CheckboxListTile(
                      value: current,
                      title: const Text(
                        "Currently Working",
                      ),
                      onChanged: (v) {
                        setDialog(() {
                          current =
                              v ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context);
                  },
                  child:
                      const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () async {
                    await repository
                        .addExperience(
                      companyName:
                          company.text,
                      jobTitle:
                          title.text,
                      employmentType:
                          employment.text,
                      location:
                          location.text,
                      startDate:
                          start.text,
                      endDate: end
                              .text
                              .isEmpty
                          ? null
                          : end.text,
                      currentlyWorking:
                          current,
                      description:
                          description.text,
                    );

                    if (!mounted)
                      return;

                    Navigator.pop(
                        context);

                    loadExperiences();
                  },
                  child:
                      const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget experienceCard(
      ExperienceModel item) {
    return Card(
      child: ListTile(
        title: Text(item.jobTitle),
        subtitle: Text(
          "${item.companyName}\n${item.startDate} - ${item.currentlyWorking ? "Present" : item.endDate ?? ""}",
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            deleteExperience(item.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Experience")),
      floatingActionButton:
          FloatingActionButton(
        onPressed: addExperienceDialog,
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : experiences.isEmpty
              ? const Center(
                  child: Text(
                    "No Experience Added",
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      loadExperiences,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            16),
                    itemCount:
                        experiences.length,
                    itemBuilder:
                        (_, index) =>
                            experienceCard(
                      experiences[index],
                    ),
                  ),
                ),
    );
  }
}