class InterviewResult {
  final bool completed;
  final int score;
  final String feedback;
  final String? nextQuestion;

  InterviewResult({
    required this.completed,
    required this.score,
    required this.feedback,
    this.nextQuestion,
  });

  factory InterviewResult.fromJson(
    Map<String, dynamic> json,
  ) {
    final data = json["data"] ?? {};

    return InterviewResult(
      completed: json["completed"] ?? false,
      score: data["score"] ?? 0,
      feedback: data["feedback"] ??
          data["evaluation"]?["feedback"] ??
          "",
      nextQuestion: data["next_question"],
    );
  }
}