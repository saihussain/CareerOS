class ResumeModel {
  final Map<String, dynamic> header;
  final String summary;

  final List<dynamic> education;
  final List<dynamic> experience;
  final List<dynamic> skills;
  final List<dynamic> projects;
  final List<dynamic> learning;
  final List<dynamic> achievements;

  final Map<String, dynamic> analysis;

  ResumeModel({
    required this.header,
    required this.summary,
    required this.education,
    required this.experience,
    required this.skills,
    required this.projects,
    required this.learning,
    required this.achievements,
    required this.analysis,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    final resume = json["resume"] ?? {};

    return ResumeModel(
      header: Map<String, dynamic>.from(
        resume["header"] ?? {},
      ),

      summary: resume["summary"]?.toString() ?? "",

      education: List<dynamic>.from(
        resume["education"] ?? [],
      ),

      experience: List<dynamic>.from(
        resume["experience"] ?? [],
      ),

      skills: List<dynamic>.from(
        resume["skills"] ?? [],
      ),

      projects: List<dynamic>.from(
        resume["projects"] ?? [],
      ),

      learning: List<dynamic>.from(
        resume["learning"] ?? [],
      ),

      achievements: List<dynamic>.from(
        resume["achievements"] ?? [],
      ),

      analysis: Map<String, dynamic>.from(
        json["analysis"] ?? {},
      ),
    );
  }
}