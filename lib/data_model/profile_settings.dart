class ProfileSettings {
  final String? name;
  final int? availableCoins;

  ProfileSettings({this.name, this.availableCoins});

  factory ProfileSettings.fromJson(Map<String, dynamic> json) {
    return ProfileSettings(
        name: json['name'], availableCoins: json['availableCoins']);
  }

  ProfileSettings copyWith({String? name, int? availableCoins}) {
    return ProfileSettings(
        name: name ?? this.name,
        availableCoins: availableCoins ?? this.availableCoins);
  }
}
