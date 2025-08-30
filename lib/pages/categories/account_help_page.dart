import 'package:flutter/material.dart';

class AccountHelpPage extends StatelessWidget {
  const AccountHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Account Help',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.person),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.password, color: Colors.blue),
                title: const Text('Password Reset'),
                subtitle: const Text('Change your account password'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to password reset
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.blue),
                title: const Text('Security Settings'),
                subtitle: const Text('Manage account security'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to security settings
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.blue),
                title: const Text('Profile Settings'),
                subtitle: const Text('Update account information'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to profile settings
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: const Text('Notification Preferences'),
                subtitle: const Text('Manage email and alerts'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
