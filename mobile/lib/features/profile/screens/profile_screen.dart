import 'package:flutter/material.dart';

import '../../../core/storage/secure_storage.dart';
import '../../auth/repositories/auth_repository.dart';
import '../../auth/screens/login_screen.dart';

import 'edit_profile_screen.dart';
import '../../education/screens/education_screen.dart';
import '../../experience/screens/experience_screen.dart';
import '../../skills/screens/skills_screen.dart';
import '../../projects/screens/projects_screen.dart';
import '../../achievements/screens/achievements_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget menuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 55,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Sai Hussain",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Flutter Developer",
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Profile Completion",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 15),

                    LinearProgressIndicator(
                      value: 0.80,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "80%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            menuCard(
              context: context,
              icon: Icons.edit,
              title: "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
            ),

            menuCard(
              context: context,
              icon: Icons.school,
              title: "Education",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EducationScreen(),
                  ),
                );
              },
            ),

            menuCard(
              context: context,
              icon: Icons.work,
              title: "Experience",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ExperienceScreen(),
                  ),
                );
              },
            ),
                        menuCard(
              context: context,
              icon: Icons.code,
              title: "Skills",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SkillsScreen(),
                  ),
                );
              },
            ),

            menuCard(
              context: context,
              icon: Icons.folder,
              title: "Projects",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProjectsScreen(),
                  ),
                );
              },
            ),

            menuCard(
              context: context,
              icon: Icons.emoji_events,
              title: "Achievements",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AchievementsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Logout",
                ),
                onPressed: () async {
                  try {
                    await AuthRepository().logout();

                    await SecureStorage().clear();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString().replaceFirst(
                            "Exception: ",
                            "",
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}