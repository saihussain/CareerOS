import 'package:flutter/material.dart';

import '../models/achievement_model.dart';
import '../repositories/achievement_repository.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() =>
      _AchievementsScreenState();
}

class _AchievementsScreenState
    extends State<AchievementsScreen> {
  final AchievementRepository repository =
      AchievementRepository();

  List<AchievementModel> achievements = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAchievements();
  }

  Future<void> loadAchievements() async {
    setState(() {
      loading = true;
    });

    try {
      achievements =
          await repository.getAchievements();
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

  Future<void> deleteAchievement(
    int id,
  ) async {
    await repository.deleteAchievement(id);

    await loadAchievements();
  }

  void showAchievementDialog({
    AchievementModel? achievement,
  }) {
    final title = TextEditingController(
      text: achievement?.title ?? "",
    );

    final organization =
        TextEditingController(
      text: achievement?.organization ?? "",
    );

    final description =
        TextEditingController(
      text: achievement?.description ?? "",
    );

    final date = TextEditingController(
      text:
          achievement?.achievementDate ??
              "",
    );

    String achievementType =
        achievement?.achievementType ??
            "Competition";

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: Text(
                achievement == null
                    ? "Add Achievement"
                    : "Edit Achievement",
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller: title,
                      decoration:
                          const InputDecoration(
                        labelText: "Title",
                      ),
                    ),

                    TextField(
                      controller:
                          organization,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Organization",
                      ),
                    ),

                    DropdownButtonFormField<
                        String>(
                      value: achievementType,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Achievement Type",
                      ),
                      items: const [

                        DropdownMenuItem(
                          value:
                              "Competition",
                          child: Text(
                              "Competition"),
                        ),

                        DropdownMenuItem(
                          value: "Award",
                          child:
                              Text("Award"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Recognition",
                          child: Text(
                              "Recognition"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Scholarship",
                          child: Text(
                              "Scholarship"),
                        ),

                        DropdownMenuItem(
                          value: "Other",
                          child:
                              Text("Other"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          achievementType =
                              value!;
                        });
                      },
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
                      controller: date,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Achievement Date",
                      ),
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

                    if (achievement ==
                        null) {

                      await repository
                          .addAchievement(
                        title: title.text,
                        organization:
                            organization
                                .text,
                        achievementType:
                            achievementType,
                        description:
                            description
                                .text,
                        achievementDate:
                            date.text
                                    .isEmpty
                                ? null
                                : date.text,
                      );

                    } else {

                      await repository
                          .updateAchievement(
                        id: achievement.id,
                        title: title.text,
                        organization:
                            organization
                                .text,
                        achievementType:
                            achievementType,
                        description:
                            description
                                .text,
                        achievementDate:
                            date.text
                                    .isEmpty
                                ? null
                                : date.text,
                      );

                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);

                    loadAchievements();
                  },
                  child: Text(
                    achievement == null
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

  Widget achievementCard(
    AchievementModel achievement,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        title: Text(
          achievement.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${achievement.organization}\n"
          "${achievement.achievementType}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              showAchievementDialog(
                achievement: achievement,
              );
            }

            if (value == "delete") {
              deleteAchievement(
                achievement.id,
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
          "Achievements",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          showAchievementDialog();
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
          : achievements.isEmpty
              ? const Center(
                  child: Text(
                    "No Achievements Added",
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      loadAchievements,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            16),
                    itemCount:
                        achievements.length,
                    itemBuilder:
                        (context, index) {
                      return achievementCard(
                        achievements[index],
                      );
                    },
                  ),
                ),
    );
  }
}