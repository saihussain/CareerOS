import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../repositories/project_repository.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() =>
      _ProjectsScreenState();
}

class _ProjectsScreenState
    extends State<ProjectsScreen> {
  final ProjectRepository repository =
      ProjectRepository();

  List<ProjectModel> projects = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProjects();
  }

  Future<void> loadProjects() async {
    setState(() {
      loading = true;
    });

    try {
      projects =
          await repository.getProjects();
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

  Future<void> deleteProject(
    int id,
  ) async {
    await repository.deleteProject(id);

    await loadProjects();
  }

  void showProjectDialog({
    ProjectModel? project,
  }) {
    final title =
        TextEditingController(
      text: project?.title ?? "",
    );

    final description =
        TextEditingController(
      text: project?.description ?? "",
    );

    final techStack =
        TextEditingController(
      text: project?.techStack ?? "",
    );

    final github =
        TextEditingController(
      text: project?.githubUrl ?? "",
    );

    final live =
        TextEditingController(
      text: project?.liveUrl ?? "",
    );

    final startDate =
        TextEditingController(
      text: project?.startDate ?? "",
    );

    String status =
        project?.status ?? "Planning";

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: Text(
                project == null
                    ? "Add Project"
                    : "Edit Project",
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller: title,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Title",
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

                    TextField(
                      controller:
                          techStack,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Tech Stack",
                      ),
                    ),

                    TextField(
                      controller:
                          github,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "GitHub URL",
                      ),
                    ),

                    TextField(
                      controller:
                          live,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Live URL",
                      ),
                    ),

                    TextField(
                      controller:
                          startDate,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Start Date",
                      ),
                    ),

                    DropdownButtonFormField<
                        String>(
                      value: status,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Status",
                      ),
                      items: const [

                        DropdownMenuItem(
                          value:
                              "Planning",
                          child: Text(
                              "Planning"),
                        ),

                        DropdownMenuItem(
                          value:
                              "In Progress",
                          child: Text(
                              "In Progress"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Completed",
                          child: Text(
                              "Completed"),
                        ),

                        DropdownMenuItem(
                          value:
                              "On Hold",
                          child:
                              Text("On Hold"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          status = value!;
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

                    if (project ==
                        null) {

                      await repository
                          .addProject(
                        title: title.text,
                        description:
                            description
                                .text,
                        techStack:
                            techStack.text,
                        githubUrl:
                            github.text
                                    .isEmpty
                                ? null
                                : github.text,
                        liveUrl:
                            live.text
                                    .isEmpty
                                ? null
                                : live.text,
                        startDate:
                            startDate.text,
                        status: status,
                      );

                    } else {

                      await repository
                          .updateProject(
                        id: project.id,
                        title: title.text,
                        description:
                            description
                                .text,
                        techStack:
                            techStack.text,
                        githubUrl:
                            github.text
                                    .isEmpty
                                ? null
                                : github.text,
                        liveUrl:
                            live.text
                                    .isEmpty
                                ? null
                                : live.text,
                        startDate:
                            startDate.text,
                        status: status,
                      );

                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);

                    loadProjects();
                  },
                  child: Text(
                    project == null
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
    Widget projectCard(
    ProjectModel project,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        title: Text(
          project.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${project.techStack}\n${project.status}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              showProjectDialog(
                project: project,
              );
            }

            if (value == "delete") {
              deleteProject(
                project.id,
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
          "Projects",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          showProjectDialog();
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
          : projects.isEmpty
              ? const Center(
                  child: Text(
                    "No Projects Added",
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      loadProjects,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            16),
                    itemCount:
                        projects.length,
                    itemBuilder:
                        (context, index) {
                      return projectCard(
                        projects[index],
                      );
                    },
                  ),
                ),
    );
  }
}