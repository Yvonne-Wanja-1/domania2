import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';
  static const String _emailNotificationsKey = 'email_notifications';
  static const String _pushNotificationsKey = 'push_notifications';
  static const String _autoRenewalKey = 'auto_renewal';
  static const String _domainPrivacyKey = 'domain_privacy';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  // Theme preferences
  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(_themeKey, isDark);
  }

  bool getDarkMode() {
    return _prefs.getBool(_themeKey) ?? false;
  }

  // Language preferences
  Future<void> setLanguage(String language) async {
    await _prefs.setString(_languageKey, language);
  }

  String getLanguage() {
    return _prefs.getString(_languageKey) ?? 'en';
  }

  // Notification preferences
  Future<void> setEmailNotifications(bool enabled) async {
    await _prefs.setBool(_emailNotificationsKey, enabled);
  }

  bool getEmailNotifications() {
    return _prefs.getBool(_emailNotificationsKey) ?? true;
  }

  Future<void> setPushNotifications(bool enabled) async {
    await _prefs.setBool(_pushNotificationsKey, enabled);
  }

  bool getPushNotifications() {
    return _prefs.getBool(_pushNotificationsKey) ?? true;
  }

  // Domain preferences
  Future<void> setAutoRenewal(bool enabled) async {
    await _prefs.setBool(_autoRenewalKey, enabled);
  }

  bool getAutoRenewal() {
    return _prefs.getBool(_autoRenewalKey) ?? true;
  }

  Future<void> setDomainPrivacy(bool enabled) async {
    await _prefs.setBool(_domainPrivacyKey, enabled);
  }

  bool getDomainPrivacy() {
    return _prefs.getBool(_domainPrivacyKey) ?? true;
  }
}
