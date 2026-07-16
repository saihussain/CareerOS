class LearningModel {
  final List<String> skills;
  final List<String> courses;
  final List<String> projects;
  final List<String> certifications;

  LearningModel({
    required this.skills,
    required this.courses,
    required this.projects,
    required this.certifications,
  });

  factory LearningModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LearningModel(
      skills: List<String>.from(
        json["skills_to_learn"] ?? [],
      ),
      courses: List<String>.from(
        json["courses"] ?? [],
      ),
      projects: List<String>.from(
        json["projects"] ?? [],
      ),
      certifications: List<String>.from(
        json["certifications"] ?? [],
      ),
    );
  }
}