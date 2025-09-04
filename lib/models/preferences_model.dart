class PreferencesModel {
  bool isDarkMode;
  bool emailNotifications;
  bool pushNotifications;
  String language;
  String timeZone;
  bool autoRenewDomains;
  bool whoisPrivacy;

  PreferencesModel({
    this.isDarkMode = false,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.language = 'English',
    this.timeZone = 'UTC',
    this.autoRenewDomains = true,
    this.whoisPrivacy = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'language': language,
      'timeZone': timeZone,
      'autoRenewDomains': autoRenewDomains,
      'whoisPrivacy': whoisPrivacy,
    };
  }

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      isDarkMode: json['isDarkMode'] ?? false,
      emailNotifications: json['emailNotifications'] ?? true,
      pushNotifications: json['pushNotifications'] ?? true,
      language: json['language'] ?? 'English',
      timeZone: json['timeZone'] ?? 'UTC',
      autoRenewDomains: json['autoRenewDomains'] ?? true,
      whoisPrivacy: json['whoisPrivacy'] ?? true,
    );
  }
}
