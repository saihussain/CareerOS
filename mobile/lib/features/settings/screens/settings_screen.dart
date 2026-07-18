import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget tile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color? color,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          tile(
            icon: Icons.person,
            title: "Profile",
            onTap: () {},
          ),

          tile(
            icon: Icons.analytics,
            title: "Analytics",
            onTap: () {},
          ),

          tile(
            icon: Icons.description,
            title: "Resume",
            onTap: () {},
          ),

          tile(
            icon: Icons.school,
            title: "Learning",
            onTap: () {},
          ),

          tile(
            icon: Icons.record_voice_over,
            title: "Interview",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          tile(
            icon: Icons.info_outline,
            title: "About",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "CareerOS",
                applicationVersion: "1.0.0",
              );
            },
          ),

          tile(
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () {
              // TODO: Logout
            },
          ),

        ],
      ),
    );
  }
}