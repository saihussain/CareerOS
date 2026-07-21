class ResultModel {
  final int score;
  final int total;
  final int percentage;
  final int correct;
  final int wrong;
  final int unanswered;
  final String feedback;

  ResultModel({
    required this.score,
    required this.total,
    required this.percentage,
    required this.correct,
    required this.wrong,
    required this.unanswered,
    required this.feedback,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      score: json["score"],
      total: json["total"],
      percentage: json["percentage"],
      correct: json["correct"],
      wrong: json["wrong"],
      unanswered: json["unanswered"],
      feedback: json["feedback"],
    );
  }
}