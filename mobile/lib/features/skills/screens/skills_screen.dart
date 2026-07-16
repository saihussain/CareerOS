import 'package:flutter/material.dart';

import '../models/skill_model.dart';
import '../repositories/skill_repository.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final SkillRepository repository = SkillRepository();

  List<SkillModel> skills = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    try {
      skills = await repository.getSkills();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
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

  Future<void> deleteSkill(int id) async {
    await repository.deleteSkill(id);

    await loadSkills();
  }

  void addSkillDialog() {
    final skillController = TextEditingController();

    final yearsController = TextEditingController();

    String proficiency = "Beginner";

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialog) {
            return AlertDialog(
              title: const Text("Add Skill"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: skillController,
                      decoration: const InputDecoration(
                        labelText: "Skill Name",
                      ),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: proficiency,
                      decoration: const InputDecoration(
                        labelText: "Proficiency",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Beginner",
                          child: Text("Beginner"),
                        ),
                        DropdownMenuItem(
                          value: "Intermediate",
                          child: Text("Intermediate"),
                        ),
                        DropdownMenuItem(
                          value: "Advanced",
                          child: Text("Advanced"),
                        ),
                        DropdownMenuItem(
                          value: "Expert",
                          child: Text("Expert"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialog(() {
                          proficiency = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: yearsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Years of Experience",
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () async {
                    await repository.addSkill(
                      skillName: skillController.text,
                      proficiency: proficiency,
                      yearsOfExperience:
                          int.tryParse(
                                yearsController.text,
                              ) ??
                              0,
                    );

                    if (!mounted) return;

                    Navigator.pop(context);

                    loadSkills();
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget skillCard(SkillModel skill) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            skill.skillName.isNotEmpty
                ? skill.skillName[0].toUpperCase()
                : "?",
          ),
        ),
        title: Text(skill.skillName),
        subtitle: Text(
          "${skill.proficiency} • ${skill.yearsOfExperience} year(s)",
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            deleteSkill(skill.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSkillDialog,
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : skills.isEmpty
              ? const Center(
                  child: Text("No Skills Added"),
                )
              : RefreshIndicator(
                  onRefresh: loadSkills,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: skills.length,
                    itemBuilder: (_, index) {
                      return skillCard(
                        skills[index],
                      );
                    },
                  ),
                ),
    );
  }
}