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

  List<AchievementModel> achievements =
      [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAchievements();
  }

  Future<void> loadAchievements() async {
    try {
      achievements =
          await repository
              .getAchievements();
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> deleteAchievement(
      int id) async {
    await repository
        .deleteAchievement(id);

    await loadAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Achievements"),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          // Add Achievement Form
        },
        child:
            const Icon(Icons.add),
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
                  child:
                      ListView.builder(
                    padding:
                        const EdgeInsets
                            .all(16),
                    itemCount:
                        achievements
                            .length,
                    itemBuilder:
                        (_, index) {
                      final item =
                          achievements[
                              index];

                      return Card(
                        child: ListTile(
                          title: Text(
                            item.title,
                          ),
                          subtitle: Text(
                            "${item.organization}\n${item.achievementType}",
                          ),
                          isThreeLine:
                              true,
                          trailing:
                              IconButton(
                            icon:
                                const Icon(
                              Icons.delete,
                              color: Colors
                                  .red,
                            ),
                            onPressed:
                                () {
                              deleteAchievement(
                                  item.id);
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