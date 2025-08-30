import 'package:flutter/material.dart';

class BillingPaymentsPage extends StatelessWidget {
  const BillingPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Billing & Payments',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.payment),
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
                leading: const Icon(Icons.receipt_long, color: Colors.blue),
                title: const Text('Payment History'),
                subtitle: const Text('View past transactions'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to payment history
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blue),
                title: const Text('Payment Methods'),
                subtitle: const Text('Manage payment options'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to payment methods
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.blue),
                title: const Text('Billing Information'),
                subtitle: const Text('Update billing details'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to billing info
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.description, color: Colors.blue),
                title: const Text('Invoices'),
                subtitle: const Text('Download invoices and receipts'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: Navigate to invoices
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
