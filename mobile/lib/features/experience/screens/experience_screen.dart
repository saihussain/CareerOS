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
    setState(() {
      loading = true;
    });

    try {
      experiences =
          await repository.getExperiences();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
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
    int id,
  ) async {
    await repository.deleteExperience(id);

    await loadExperiences();
  }

  void showExperienceDialog({
    ExperienceModel? experience,
  }) {
    final company =
        TextEditingController(
      text: experience?.companyName ?? "",
    );

    final title =
        TextEditingController(
      text: experience?.jobTitle ?? "",
    );

    final employment =
        TextEditingController(
      text:
          experience?.employmentType ??
              "",
    );

    final location =
        TextEditingController(
      text: experience?.location ?? "",
    );

    final start =
        TextEditingController(
      text: experience?.startDate ?? "",
    );

    final end =
        TextEditingController(
      text: experience?.endDate ?? "",
    );

    final description =
        TextEditingController(
      text:
          experience?.description ?? "",
    );

    bool currentlyWorking =
        experience?.currentlyWorking ??
            false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: Text(
                experience == null
                    ? "Add Experience"
                    : "Edit Experience",
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
                      controller: start,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Start Date",
                      ),
                    ),

                    TextField(
                      controller: end,
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
                      value:
                          currentlyWorking,
                      title: const Text(
                        "Currently Working",
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          currentlyWorking =
                              value ??
                                  false;
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

                    if (experience ==
                        null) {

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
                        endDate:
                            end.text.isEmpty
                                ? null
                                : end.text,
                        currentlyWorking:
                            currentlyWorking,
                        description:
                            description
                                .text,
                      );

                    } else {

                      await repository
                          .updateExperience(
                        id: experience.id,
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
                        endDate:
                            end.text.isEmpty
                                ? null
                                : end.text,
                        currentlyWorking:
                            currentlyWorking,
                        description:
                            description
                                .text,
                      );

                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);

                    loadExperiences();
                  },
                  child: Text(
                    experience == null
                        ? "Save"
                        : "Update",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
    Widget experienceCard(
    ExperienceModel experience,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        title: Text(
          experience.jobTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${experience.companyName}\n"
          "${experience.employmentType}\n"
          "${experience.startDate} - "
          "${experience.currentlyWorking ? "Present" : (experience.endDate ?? "")}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              showExperienceDialog(
                experience: experience,
              );
            }

            if (value == "delete") {
              deleteExperience(
                experience.id,
              );
            }
          },
          itemBuilder: (_) => const [

            PopupMenuItem(
              value: "edit",
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 10),
                  Text("Edit"),
                ],
              ),
            ),

            PopupMenuItem(
              value: "delete",
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text("Delete"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Experience",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          showExperienceDialog();
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : experiences.isEmpty
              ? const Center(
                  child: Text(
                    "No experience added.",
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
                        (context, index) {
                      return experienceCard(
                        experiences[index],
                      );
                    },
                  ),
                ),
    );
  }
}