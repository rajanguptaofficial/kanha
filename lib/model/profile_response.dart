class ProfileResponseModel {
  final int responseStatus;
  final String responseMessage;
  final List<Profile> profiles;

  ProfileResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.profiles,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      responseStatus: json['responseStatus'],
      responseMessage: json['responseMessage'],
      profiles: (json['responseData']['table'] as List)
          .map((profile) => Profile.fromJson(profile))
          .toList(),
    );
  }
}

class Profile {
  final String profileName;
  final String companyName;
  final String plantName;
  final String cntName;

  Profile({
    required this.profileName,
    required this.companyName,
    required this.plantName,
    required this.cntName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileName: json['profileName'],
      companyName: json['companyName'],
      plantName: json['plantname'],
      cntName: json['cntName'],
    );
  }
}
