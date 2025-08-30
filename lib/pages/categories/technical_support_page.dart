import 'package:flutter/material.dart';

class TechnicalSupportPage extends StatelessWidget {
  const TechnicalSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Technical Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.code),
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
                leading: const Icon(Icons.dns, color: Colors.blue),
                title: const Text('DNS Configuration'),
                subtitle: const Text('DNS setup and troubleshooting'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to DNS configuration
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.web, color: Colors.blue),
                title: const Text('Website Setup'),
                subtitle: const Text('Configure website hosting'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to website setup
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text('Email Configuration'),
                subtitle: const Text('Set up domain email'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to email setup
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.blue),
                title: const Text('SSL Certificates'),
                subtitle: const Text('Manage SSL/TLS certificates'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to SSL management
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
