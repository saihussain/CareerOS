class ProfileModel {
  final int id;
  final String fullName;
  final String mobileNumber;
  final String dateOfBirth;
  final String gender;
  final String aboutMe;
  final String linkedinUrl;
  final String githubUrl;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.aboutMe,
    required this.linkedinUrl,
    required this.githubUrl,
  });

  factory ProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProfileModel(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      mobileNumber: json["mobile_number"] ?? "",
      dateOfBirth: json["date_of_birth"] ?? "",
      gender: json["gender"] ?? "",
      aboutMe: json["about_me"] ?? "",
      linkedinUrl: json["linkedin_url"] ?? "",
      githubUrl: json["github_url"] ?? "",
    );
  }
}