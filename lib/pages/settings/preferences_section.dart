import 'package:flutter/material.dart';

class PreferencesSection extends StatefulWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  @override
  _PreferencesSectionState createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  bool _isDarkMode = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _selectedLanguage = 'English';
  String _selectedTimeZone = 'UTC';
  bool _autoRenewDomains = true;
  bool _whoisPrivacy = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Preferences',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _buildAppearanceSection(),
        _buildNotificationSection(),
        _buildLocalizationSection(),
        _buildDomainSection(),
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Email Notifications'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocalizationSection() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Localization',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: ['English', 'Spanish', 'French', 'German']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Time Zone'),
            trailing: DropdownButton<String>(
              value: _selectedTimeZone,
              items: ['UTC', 'UTC+1', 'UTC+2', 'UTC+3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedTimeZone = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomainSection() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Domain Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Auto-renew Domains'),
            value: _autoRenewDomains,
            onChanged: (bool value) {
              setState(() {
                _autoRenewDomains = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('WHOIS Privacy Protection'),
            value: _whoisPrivacy,
            onChanged: (bool value) {
              setState(() {
                _whoisPrivacy = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
