import 'package:flutter/material.dart';

import '../../analytics/screens/analytics_screen.dart';
import '../../interview/screens/interview_setup_screen.dart';
import '../../test/screens/test_setup_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../resume/screens/resume_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "CareerOS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Welcome Back 👋",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 6),

            Text(
              widget.email,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff2563EB),
                    Color(0xff4F46E5),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Career Goal",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "AI Engineer",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),

                  SizedBox(height: 22),

                  Text(
                    "Career Readiness",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: 0.82,
                    minHeight: 8,
                    backgroundColor: Colors.white24,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "82% Ready for Placements",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.check_circle_outline,
                  color: Colors.orange,
                ),
                title: Text("Complete Resume"),
                subtitle: Text("Generate your ATS Resume"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                title: Text("Complete Profile"),
                subtitle: Text("Keep profile 100% complete"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.check_circle_outline,
                  color: Colors.red,
                ),
                title: Text("Take Aptitude Test"),
                subtitle: Text("Improve placement readiness"),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recommended Skills",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(label: Text("Flutter")),
                Chip(label: Text("Dart")),
                Chip(label: Text("REST API")),
                Chip(label: Text("Git")),
                Chip(label: Text("Firebase")),
                Chip(label: Text("SQL")),
                Chip(label: Text("Python")),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Recommended Courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 15),
                        Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xffE3F2FD),
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.blue,
                  ),
                ),
                title: Text("Flutter Complete Bootcamp"),
                subtitle: Text("Recommended based on your career goal"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xffE8F5E9),
                  child: Icon(
                    Icons.school,
                    color: Colors.green,
                  ),
                ),
                title: Text("Git & GitHub"),
                subtitle: Text("Essential for every software engineer"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xffFFF3E0),
                  child: Icon(
                    Icons.code,
                    color: Colors.orange,
                  ),
                ),
                title: Text("Data Structures & Algorithms"),
                subtitle: Text("Highly recommended for placements"),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Resume Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                ),
                title: const Text("Resume Generator"),
                subtitle: const Text(
                  "Generate your professional ATS resume.",
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResumeScreen(),
                      ),
                    );
                  },
                  child: const Text("Open"),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Keep Learning 🚀",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Complete today's tasks to improve your placement readiness.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });

          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (_) => const ResumeScreen(),
                ),
              );
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AnalyticsScreen(),
                ),
              );
              break;

            case 3:
              Navigator.push(
                context,
                  MaterialPageRoute(
                    builder: (_) => const InterviewSetupScreen(),
                  ),
              );
              break;

            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TestSetupScreen(),
                ),
              );
              break;
          }
        },
        
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: "Resume",
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: "Analytics",
          ),
          NavigationDestination(
            icon: Icon(Icons.record_voice_over_outlined),
            selectedIcon: Icon(Icons.record_voice_over),
            label: "Interview",
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: "Test",
          ),
        ],
      ),
    );
  }
}