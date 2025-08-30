import 'package:flutter/material.dart';

class DomainManagementPage extends StatelessWidget {
  const DomainManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Domain Management',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.domain),
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
                leading: const Icon(Icons.refresh, color: Colors.blue),
                title: const Text('Domain Renewal'),
                subtitle: const Text('Manage your domain renewals'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to domain renewal
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.dns, color: Colors.blue),
                title: const Text('DNS Management'),
                subtitle: const Text('Configure DNS settings'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to DNS management
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.transfer_within_a_station,
                    color: Colors.blue),
                title: const Text('Domain Transfer'),
                subtitle: const Text('Transfer domains in or out'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to domain transfer
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.blue),
                title: const Text('Domain Privacy'),
                subtitle: const Text('Manage WHOIS privacy settings'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
