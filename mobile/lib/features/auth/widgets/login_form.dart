import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password) onLogin;
  final bool loading;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.loading,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: passwordController,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: widget.loading
                ? null
                : () async {
                    await widget.onLogin(
                      emailController.text.trim(),
                      passwordController.text,
                    );
                  },
            child: widget.loading
                ? const CircularProgressIndicator()
                : const Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        ),

      ],
    );
  }
}