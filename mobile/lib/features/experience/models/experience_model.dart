class ExperienceModel {
  final int id;
  final String companyName;
  final String jobTitle;
  final String employmentType;
  final String location;
  final String startDate;
  final String? endDate;
  final bool currentlyWorking;
  final String description;

  ExperienceModel({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.employmentType,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.currentlyWorking,
    required this.description,
  });

  factory ExperienceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ExperienceModel(
      id: json["id"] ?? 0,
      companyName: json["company_name"] ?? "",
      jobTitle: json["job_title"] ?? "",
      employmentType: json["employment_type"] ?? "",
      location: json["location"] ?? "",
      startDate: json["start_date"] ?? "",
      endDate: json["end_date"],
      currentlyWorking:
          json["currently_working"] ?? false,
      description: json["description"] ?? "",
    );
  }
}