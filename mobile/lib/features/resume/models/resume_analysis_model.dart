class ResumeAnalysisModel {
  final Map<String, dynamic> rawData;

  ResumeAnalysisModel({
    required this.rawData,
  });

  factory ResumeAnalysisModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResumeAnalysisModel(
      rawData: json,
    );
  }

  dynamic operator [](String key) => rawData[key];
}