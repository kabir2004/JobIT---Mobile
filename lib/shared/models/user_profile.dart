class UserProfile {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? jobTitle;
  final List<String> skills;
  final String? experienceLevel;
  final String? preferredLocation;
  final String? salaryExpectation;
  final List<String> preferredIndustries;
  final String? workStyle;
  final String? githubUrl;
  final String? linkedinUrl;
  final String? resumeUrl;
  final String? coverLetterUrl;
  final String? profilePictureUrl;
  final String? school;
  final String? major;
  final bool isProfileComplete;

  UserProfile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.jobTitle,
    this.skills = const [],
    this.experienceLevel,
    this.preferredLocation,
    this.salaryExpectation,
    this.preferredIndustries = const [],
    this.workStyle,
    this.githubUrl,
    this.linkedinUrl,
    this.resumeUrl,
    this.coverLetterUrl,
    this.profilePictureUrl,
    this.school,
    this.major,
    this.isProfileComplete = false,
  });

  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? jobTitle,
    List<String>? skills,
    String? experienceLevel,
    String? preferredLocation,
    String? salaryExpectation,
    List<String>? preferredIndustries,
    String? workStyle,
    String? githubUrl,
    String? linkedinUrl,
    String? resumeUrl,
    String? coverLetterUrl,
    String? profilePictureUrl,
    String? school,
    String? major,
    bool? isProfileComplete,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      jobTitle: jobTitle ?? this.jobTitle,
      skills: skills ?? this.skills,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      preferredLocation: preferredLocation ?? this.preferredLocation,
      salaryExpectation: salaryExpectation ?? this.salaryExpectation,
      preferredIndustries: preferredIndustries ?? this.preferredIndustries,
      workStyle: workStyle ?? this.workStyle,
      githubUrl: githubUrl ?? this.githubUrl,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      coverLetterUrl: coverLetterUrl ?? this.coverLetterUrl,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      school: school ?? this.school,
      major: major ?? this.major,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'jobTitle': jobTitle,
      'skills': skills,
      'experienceLevel': experienceLevel,
      'preferredLocation': preferredLocation,
      'salaryExpectation': salaryExpectation,
      'preferredIndustries': preferredIndustries,
      'workStyle': workStyle,
      'githubUrl': githubUrl,
      'linkedinUrl': linkedinUrl,
      'resumeUrl': resumeUrl,
      'coverLetterUrl': coverLetterUrl,
      'profilePictureUrl': profilePictureUrl,
      'school': school,
      'major': major,
      'isProfileComplete': isProfileComplete,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      jobTitle: json['jobTitle'],
      skills: List<String>.from(json['skills'] ?? []),
      experienceLevel: json['experienceLevel'],
      preferredLocation: json['preferredLocation'],
      salaryExpectation: json['salaryExpectation'],
      preferredIndustries: List<String>.from(json['preferredIndustries'] ?? []),
      workStyle: json['workStyle'],
      githubUrl: json['githubUrl'],
      linkedinUrl: json['linkedinUrl'],
      resumeUrl: json['resumeUrl'],
      coverLetterUrl: json['coverLetterUrl'],
      profilePictureUrl: json['profilePictureUrl'],
      school: json['school'],
      major: json['major'],
      isProfileComplete: json['isProfileComplete'] ?? false,
    );
  }
} 