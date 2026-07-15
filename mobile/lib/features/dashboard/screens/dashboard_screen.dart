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
        child: Text(
          "Welcome\n$email",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}