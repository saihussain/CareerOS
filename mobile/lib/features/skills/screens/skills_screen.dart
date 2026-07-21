import 'package:flutter/material.dart';

import '../models/skill_model.dart';
import '../repositories/skill_repository.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() =>
      _SkillsScreenState();
}

class _SkillsScreenState
    extends State<SkillsScreen> {
  final SkillRepository repository =
      SkillRepository();

  List<SkillModel> skills = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    setState(() {
      loading = true;
    });

    try {
      skills = await repository.getSkills();
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

  Future<void> deleteSkill(
    int id,
  ) async {
    await repository.deleteSkill(id);

    await loadSkills();
  }

  void showSkillDialog({
    SkillModel? skill,
  }) {
    final skillController =
        TextEditingController(
      text: skill?.skillName ?? "",
    );

    final yearsController =
        TextEditingController(
      text: skill?.yearsOfExperience
              .toString() ??
          "",
    );

    String proficiency =
        skill?.proficiency ??
            "Beginner";

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: Text(
                skill == null
                    ? "Add Skill"
                    : "Edit Skill",
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller:
                          skillController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Skill Name",
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    DropdownButtonFormField<
                        String>(
                      initialValue: proficiency,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Proficiency",
                      ),
                      items: const [

                        DropdownMenuItem(
                          value:
                              "Beginner",
                          child: Text(
                              "Beginner"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Intermediate",
                          child: Text(
                              "Intermediate"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Advanced",
                          child: Text(
                              "Advanced"),
                        ),

                        DropdownMenuItem(
                          value: "Expert",
                          child:
                              Text("Expert"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          proficiency =
                              value!;
                        });
                      },
                    ),

                    const SizedBox(
                        height: 15),

                    TextField(
                      controller:
                          yearsController,
                      keyboardType:
                          TextInputType
                              .number,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Years of Experience",
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

                    if (skill == null) {

                      await repository
                          .addSkill(
                        skillName:
                            skillController
                                .text,
                        proficiency:
                            proficiency,
                        yearsOfExperience:
                            int.tryParse(
                                  yearsController
                                      .text,
                                ) ??
                                0,
                      );

                    } else {

                      await repository
                          .updateSkill(
                        id: skill.id,
                        skillName:
                            skillController
                                .text,
                        proficiency:
                            proficiency,
                        yearsOfExperience:
                            int.tryParse(
                                  yearsController
                                      .text,
                                ) ??
                                0,
                      );

                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);

                    loadSkills();
                  },
                  child: Text(
                    skill == null
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

  Widget skillCard(
    SkillModel skill,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            skill.skillName.isNotEmpty
                ? skill.skillName[0].toUpperCase()
                : "?",
          ),
        ),
        title: Text(
          skill.skillName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${skill.proficiency} • ${skill.yearsOfExperience} year(s)",
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              showSkillDialog(
                skill: skill,
              );
            }

            if (value == "delete") {
              deleteSkill(
                skill.id,
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
          "Skills",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          showSkillDialog();
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
          : skills.isEmpty
              ? const Center(
                  child: Text(
                    "No Skills Added",
                  ),
                )
              : RefreshIndicator(
                  onRefresh:
                      loadSkills,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                            16),
                    itemCount:
                        skills.length,
                    itemBuilder:
                        (context, index) {
                      return skillCard(
                        skills[index],
                      );
                    },
                  ),
                ),
    );
  }
}