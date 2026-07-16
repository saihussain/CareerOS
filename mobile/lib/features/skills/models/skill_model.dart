class SkillModel {
  final int id;
  final String skillName;
  final String proficiency;
  final int yearsOfExperience;

  SkillModel({
    required this.id,
    required this.skillName,
    required this.proficiency,
    required this.yearsOfExperience,
  });

  factory SkillModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SkillModel(
      id: json["id"] ?? 0,
      skillName: json["skill_name"] ?? "",
      proficiency: json["proficiency"] ?? "",
      yearsOfExperience:
          json["years_of_experience"] ?? 0,
    );
  }
}