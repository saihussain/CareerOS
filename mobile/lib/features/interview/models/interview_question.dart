class InterviewQuestion {
  final String question;

  InterviewQuestion({
    required this.question,
  });

  factory InterviewQuestion.fromJson(
    Map<String, dynamic> json,
  ) {
    return InterviewQuestion(
      question: json["question"] ?? "",
    );
  }
}