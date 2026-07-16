class EducationModel {
  final int id;
  final String institutionName;
  final String degree;
  final String fieldOfStudy;
  final int startYear;
  final int? endYear;
  final double? cgpa;
  final bool currentlyStudying;

  EducationModel({
    required this.id,
    required this.institutionName,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    this.endYear,
    this.cgpa,
    required this.currentlyStudying,
  });

  factory EducationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return EducationModel(
      id: json["id"] ?? 0,
      institutionName: json["institution_name"] ?? "",
      degree: json["degree"] ?? "",
      fieldOfStudy: json["field_of_study"] ?? "",
      startYear: json["start_year"] ?? 0,
      endYear: json["end_year"],
      cgpa: json["cgpa"] == null
          ? null
          : double.tryParse(json["cgpa"].toString()),
      currentlyStudying:
          json["currently_studying"] ?? false,
    );
  }
}