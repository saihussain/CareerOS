class TestModel {
  final String category;
  final int stage;
  final int totalQuestions;
  final int duration;

  TestModel({
    required this.category,
    required this.stage,
    required this.totalQuestions,
    required this.duration,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      category: json["category"],
      stage: json["stage"],
      totalQuestions: json["total_questions"],
      duration: json["duration"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "stage": stage,
      "total_questions": totalQuestions,
      "duration": duration,
    };
  }
}