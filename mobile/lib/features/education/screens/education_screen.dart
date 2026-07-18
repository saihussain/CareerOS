import 'package:flutter/material.dart';

import '../models/education_model.dart';
import '../repositories/education_repository.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() =>
      _EducationScreenState();
}

class _EducationScreenState
    extends State<EducationScreen> {
  final EducationRepository repository =
      EducationRepository();

  List<EducationModel> educations = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadEducations();
  }

  Future<void> loadEducations() async {
    setState(() {
      loading = true;
    });

    try {
      educations =
          await repository.getEducations();
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

  Future<void> deleteEducation(
      int id) async {
    await repository.deleteEducation(id);

    await loadEducations();
  }

  void showEducationDialog({
    EducationModel? education,
  }) {
    final institution =
        TextEditingController(
      text: education?.institutionName ?? "",
    );

    final degree =
        TextEditingController(
      text: education?.degree ?? "",
    );

    final field =
        TextEditingController(
      text: education?.fieldOfStudy ?? "",
    );

    final startYear =
        TextEditingController(
      text:
          education?.startYear.toString() ??
              "",
    );

    final endYear =
        TextEditingController(
      text: education?.endYear
              ?.toString() ??
          "",
    );

    final cgpa =
        TextEditingController(
      text:
          education?.cgpa?.toString() ??
              "",
    );

    bool currentlyStudying =
        education?.currentlyStudying ??
            false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: Text(
                education == null
                    ? "Add Education"
                    : "Edit Education",
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller:
                          institution,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Institution",
                      ),
                    ),

                    TextField(
                      controller: degree,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Degree",
                      ),
                    ),

                    TextField(
                      controller: field,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Field of Study",
                      ),
                    ),

                    TextField(
                      controller:
                          startYear,
                      keyboardType:
                          TextInputType
                              .number,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Start Year",
                      ),
                    ),

                    TextField(
                      controller: endYear,
                      keyboardType:
                          TextInputType
                              .number,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "End Year",
                      ),
                    ),

                    TextField(
                      controller: cgpa,
                      keyboardType:
                          const TextInputType
                              .numberWithOptions(
                        decimal: true,
                      ),
                      decoration:
                          const InputDecoration(
                        labelText:
                            "CGPA",
                      ),
                    ),

                    CheckboxListTile(
                      value:
                          currentlyStudying,
                      title: const Text(
                        "Currently Studying",
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          currentlyStudying =
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

                    if (education ==
                        null) {

                      await repository
                          .addEducation(
                        institutionName:
                            institution
                                .text,
                        degree:
                            degree.text,
                        fieldOfStudy:
                            field.text,
                        startYear:
                            int.parse(
                                startYear
                                    .text),
                        endYear:
                            endYear
                                    .text
                                    .isEmpty
                                ? null
                                : int.parse(
                                    endYear
                                        .text),
                        cgpa: cgpa
                                .text
                                .isEmpty
                            ? null
                            : double.parse(
                                cgpa.text),
                        currentlyStudying:
                            currentlyStudying,
                      );

                    } else {

                      await repository
                          .updateEducation(
                        id: education.id,
                        institutionName:
                            institution
                                .text,
                        degree:
                            degree.text,
                        fieldOfStudy:
                            field.text,
                        startYear:
                            int.parse(
                                startYear
                                    .text),
                        endYear:
                            endYear
                                    .text
                                    .isEmpty
                                ? null
                                : int.parse(
                                    endYear
                                        .text),
                        cgpa: cgpa
                                .text
                                .isEmpty
                            ? null
                            : double.parse(
                                cgpa.text),
                        currentlyStudying:
                            currentlyStudying,
                      );

                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);

                    loadEducations();
                  },
                  child: Text(
                    education == null
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
    Widget educationCard(
    EducationModel education,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        title: Text(
          education.degree,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${education.institutionName}\n"
          "${education.fieldOfStudy}\n"
          "${education.startYear} - "
          "${education.currentlyStudying ? "Present" : (education.endYear ?? "")}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              showEducationDialog(
                education: education,
              );
            }

            if (value == "delete") {
              deleteEducation(
                education.id,
              );
            }
          },
          itemBuilder: (context) => const [

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
          "Education",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          showEducationDialog();
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
          : educations.isEmpty
              ? const Center(
                  child: Text(
                    "No education added.",
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      loadEducations,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            16),
                    itemCount:
                        educations.length,
                    itemBuilder:
                        (context, index) {
                      return educationCard(
                        educations[index],
                      );
                    },
                  ),
                ),
    );
  }
}