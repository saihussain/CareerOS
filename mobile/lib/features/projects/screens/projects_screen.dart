import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../repositories/project_repository.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectRepository repository = ProjectRepository();

  List<ProjectModel> projects = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProjects();
  }

  Future<void> loadProjects() async {
    try {
      projects = await repository.getProjects();
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> deleteProject(int id) async {
    await repository.deleteProject(id);
    await loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Project dialog (same pattern as Education/Experience/Skills)
        },
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : projects.isEmpty
              ? const Center(
                  child: Text("No Projects Added"),
                )
              : RefreshIndicator(
                  onRefresh: loadProjects,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: projects.length,
                    itemBuilder: (_, index) {
                      final project = projects[index];

                      return Card(
                        child: ListTile(
                          title: Text(project.title),
                          subtitle: Text(
                            "${project.techStack}\n${project.status}",
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              deleteProject(project.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}