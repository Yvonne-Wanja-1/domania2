import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Account Settings',
              [
                _buildSettingTile(
                  'Password & Security',
                  Icons.security,
                  onTap: () {
                    // TODO: Implement password & security settings
                  },
                ),
                _buildSettingTile(
                  'Privacy Settings',
                  Icons.privacy_tip,
                  onTap: () {
                    // TODO: Implement privacy settings
                  },
                ),
                _buildSettingTile(
                  'Notification Preferences',
                  Icons.notifications,
                  onTap: () {
                    // TODO: Implement notification settings
                  },
                ),
              ],
            ),
            _buildSection(
              'Domain Settings',
              [
                _buildSettingTile(
                  'Auto-Renewal Settings',
                  Icons.autorenew,
                  onTap: () {
                    // TODO: Implement auto-renewal settings
                  },
                ),
                _buildSettingTile(
                  'Domain Privacy',
                  Icons.shield,
                  onTap: () {
                    // TODO: Implement domain privacy settings
                  },
                ),
                _buildSettingTile(
                  'DNS Management',
                  Icons.dns,
                  onTap: () {
                    // TODO: Implement DNS management
                  },
                ),
              ],
            ),
            _buildSection(
              'Payment Settings',
              [
                _buildSettingTile(
                  'Payment Methods',
                  Icons.payment,
                  onTap: () {
                    // TODO: Implement payment methods
                  },
                ),
                _buildSettingTile(
                  'Billing Information',
                  Icons.receipt,
                  onTap: () {
                    // TODO: Implement billing information
                  },
                ),
                _buildSettingTile(
                  'Auto-Pay Settings',
                  Icons.account_balance,
                  onTap: () {
                    // TODO: Implement auto-pay settings
                  },
                ),
              ],
            ),
            _buildSection(
              'Support',
              [
                _buildSettingTile(
                  'Help Center',
                  Icons.help,
                  onTap: () {
                    // TODO: Implement help center
                  },
                ),
                _buildSettingTile(
                  'Contact Support',
                  Icons.support_agent,
                  onTap: () {
                    // TODO: Implement contact support
                  },
                ),
                _buildSettingTile(
                  'Report an Issue',
                  Icons.bug_report,
                  onTap: () {
                    // TODO: Implement issue reporting
                  },
                ),
              ],
            ),
            _buildSection(
              'App Settings',
              [
                _buildSettingTile(
                  'Language',
                  Icons.language,
                  onTap: () {
                    // TODO: Implement language settings
                  },
                ),
                _buildSettingTile(
                  'Theme',
                  Icons.palette,
                  onTap: () {
                    // TODO: Implement theme settings
                  },
                ),
                _buildSettingTile(
                  'About',
                  Icons.info,
                  onTap: () {
                    // TODO: Implement about page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items.map((item) {
              final index = items.indexOf(item);
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    const Divider(height: 1, thickness: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.blueAccent,
          size: 24,
        ),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    );
  }
}
