import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CareerOS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.verified,
              color: Colors.green,
              size: 70,
            ),

            const SizedBox(height: 20),

            const Text(
              "Login Successful",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              email,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

          ],
        ),
      ),
    );
  }
}