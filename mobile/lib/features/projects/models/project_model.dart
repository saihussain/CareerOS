class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String techStack;
  final String? githubUrl;
  final String? liveUrl;
  final String startDate;
  final String status;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.githubUrl,
    this.liveUrl,
    required this.startDate,
    required this.status,
  });

  factory ProjectModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProjectModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      techStack: json["tech_stack"] ?? "",
      githubUrl: json["github_url"],
      liveUrl: json["live_url"],
      startDate: json["start_date"] ?? "",
      status: json["status"] ?? "",
    );
  }
}