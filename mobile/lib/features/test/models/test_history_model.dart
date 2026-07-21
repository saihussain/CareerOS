class TestHistoryModel {
  final String category;
  final int stage;
  final int totalQuestions;
  final int correct;
  final int wrong;
  final int unanswered;
  final int percentage;
  final int duration;
  final int timeTaken;
  final String feedback;
  final DateTime completedAt;

  TestHistoryModel({
    required this.category,
    required this.stage,
    required this.totalQuestions,
    required this.correct,
    required this.wrong,
    required this.unanswered,
    required this.percentage,
    required this.duration,
    required this.timeTaken,
    required this.feedback,
    required this.completedAt,
  });

  factory TestHistoryModel.fromJson(
      Map<String, dynamic> json) {
    return TestHistoryModel(
      category: json["category"],
      stage: json["stage"],
      totalQuestions: json["totalQuestions"],
      correct: json["correct"],
      wrong: json["wrong"],
      unanswered: json["unanswered"],
      percentage: json["percentage"],
      duration: json["duration"],
      timeTaken: json["timeTaken"],
      feedback: json["feedback"],
      completedAt:
          DateTime.parse(json["completedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "stage": stage,
      "totalQuestions": totalQuestions,
      "correct": correct,
      "wrong": wrong,
      "unanswered": unanswered,
      "percentage": percentage,
      "duration": duration,
      "timeTaken": timeTaken,
      "feedback": feedback,
      "completedAt":
          completedAt.toIso8601String(),
    };
  }
}