class AnalyticsModel {
  final int profileCompletion;
  final int resumeScore;
  final int interviewScore;
  final int learningProgress;
  final int careerReadiness;

  AnalyticsModel({
    required this.profileCompletion,
    required this.resumeScore,
    required this.interviewScore,
    required this.learningProgress,
    required this.careerReadiness,
  });

  factory AnalyticsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AnalyticsModel(
      profileCompletion:
          json["profile_completion"] ?? 0,
      resumeScore:
          json["resume_score"] ?? 0,
      interviewScore:
          json["interview_score"] ?? 0,
      learningProgress:
          json["learning_progress"] ?? 0,
      careerReadiness:
          json["career_readiness"] ?? 0,
    );
  }
}