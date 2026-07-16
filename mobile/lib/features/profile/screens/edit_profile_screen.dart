import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController =
      TextEditingController();

  final TextEditingController mobileController =
      TextEditingController();

  final TextEditingController dobController =
      TextEditingController();

  final TextEditingController aboutController =
      TextEditingController();

  final TextEditingController linkedinController =
      TextEditingController();

  final TextEditingController githubController =
      TextEditingController();

  String gender = "Male";

  bool loading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    aboutController.dispose();
    linkedinController.dispose();
    githubController.dispose();
    super.dispose();
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile saved successfully."),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              TextFormField(
                controller: fullNameController,
                decoration: input("Full Name"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter full name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: input("Mobile Number"),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter mobile number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: dobController,
                decoration: input("Date of Birth"),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: gender,
                decoration: input("Gender"),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),
                  DropdownMenuItem(
                    value: "Other",
                    child: Text("Other"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: aboutController,
                maxLines: 4,
                decoration: input("About Me"),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: linkedinController,
                decoration: input("LinkedIn URL"),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: githubController,
                decoration: input("GitHub URL"),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      loading ? null : saveProfile,
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Save Profile",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}