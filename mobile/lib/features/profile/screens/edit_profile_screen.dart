import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repositories/profile_repository.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final ProfileRepository repository = ProfileRepository();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController githubController = TextEditingController();

  bool loading = false;
  String gender = "Male";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      setState(() {
        loading = true;
      });

      final profile = await repository.getProfile();

      fullNameController.text = profile.fullName;
      mobileController.text = profile.mobileNumber;
      dobController.text = profile.dateOfBirth;
      aboutController.text = profile.aboutMe;
      linkedinController.text = profile.linkedinUrl;
      githubController.text = profile.githubUrl;

      if (profile.gender.isNotEmpty) {
        gender = profile.gender;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
Future<void> pickDate() async {
  DateTime initialDate = DateTime.now();

  if (dobController.text.isNotEmpty) {
    try {
      initialDate = DateTime.parse(dobController.text);
    } catch (_) {}
  }

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );

  if (picked != null) {
    dobController.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}
  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        loading = true;
      });

      await repository.updateProfile(
        fullName: fullNameController.text.trim(),
        mobileNumber: mobileController.text.trim(),
        dateOfBirth: dobController.text.trim(),
        gender: gender,
        aboutMe: aboutController.text.trim(),
        linkedinUrl: linkedinController.text.trim(),
        githubUrl: githubController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully."),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

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

 InputDecoration input(String label, {String? hint}) {
   return InputDecoration(
    labelText: label,
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: input("Full Name"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
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
                        if (value == null || value.trim().isEmpty) {
                          return "Enter mobile number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: dobController,
                      readOnly: true,
                       decoration: input(
                          "Date of Birth",
                            hint: "Select your date of birth",
                       ).copyWith(
                       suffixIcon: const Icon(Icons.calendar_today),
                       ),
                       onTap: pickDate,
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
                        onPressed: loading ? null : saveProfile,
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Save Profile",
                                style: TextStyle(fontSize: 18),
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