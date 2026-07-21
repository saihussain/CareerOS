class QuestionModel {
  final int id;
  final String topic;
  final String difficulty;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  int? selectedAnswer;

  QuestionModel({
    required this.id,
    required this.topic,
    required this.difficulty,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.selectedAnswer,
  });

  factory QuestionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return QuestionModel(
      id: json["id"],
      topic: json["topic"],
      difficulty: json["difficulty"],
      question: json["question"],
      options: List<String>.from(
        json["options"],
      ),
      correctAnswer: json["correct_answer"],
      explanation: json["explanation"],
      selectedAnswer: json["selected_answer"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "topic": topic,
      "difficulty": difficulty,
      "question": question,
      "options": options,
      "correct_answer": correctAnswer,
      "explanation": explanation,
      "selected_answer": selectedAnswer,
    };
  }
}