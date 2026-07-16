class AchievementModel {
  final int id;
  final String title;
  final String organization;
  final String achievementType;
  final String description;
  final String? achievementDate;

  AchievementModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.achievementType,
    required this.description,
    this.achievementDate,
  });

  factory AchievementModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AchievementModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      organization: json["organization"] ?? "",
      achievementType:
          json["achievement_type"] ?? "",
      description:
          json["description"] ?? "",
      achievementDate:
          json["achievement_date"],
    );
  }
}