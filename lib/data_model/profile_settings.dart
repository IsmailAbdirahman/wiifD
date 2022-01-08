class ProfileSettings {
  String? name;

  ProfileSettings({this.name});

  factory ProfileSettings.fromJson(Map<String, dynamic> json) {
    return ProfileSettings(name: json['name']);





  }
}


