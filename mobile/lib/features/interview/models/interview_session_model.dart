class InterviewSessionModel {
  final int sessionId;
  final String question;

  InterviewSessionModel({
    required this.sessionId,
    required this.question,
  });

  factory InterviewSessionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InterviewSessionModel(
      sessionId: json["session_id"],
      question: json["question"],
    );
  }
}