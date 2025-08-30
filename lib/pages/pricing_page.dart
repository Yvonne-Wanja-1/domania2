import 'package:flutter/material.dart';
import 'register_domain_page.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final List<PricingPlan> _plans = [
    PricingPlan(
      type: '.KE',
      price: 999.0,
      description: 'Perfect for businesses and personal brands in Kenya',
      features: ['Free WHOIS Privacy', 'DNS Management', 'Email Forwarding'],
      isPopular: true,
    ),
    PricingPlan(
      type: '.CO.KE',
      price: 1299.0,
      description: 'Ideal for companies and commercial enterprises',
      features: ['Free WHOIS Privacy', 'DNS Management', 'Email Forwarding'],
    ),
    PricingPlan(
      type: '.OR.KE',
      price: 899.0,
      description: 'Best for organizations and non-profits',
      features: ['Free WHOIS Privacy', 'DNS Management'],
    ),
  ];

  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'Can I renew my domain later?',
      answer:
          'Yes! You can renew your domain name at any time before it expires. We\'ll send you reminder emails when your domain is approaching expiration.',
    ),
    FAQItem(
      question: 'Is there a refund policy?',
      answer:
          'Domain registrations are non-refundable. However, if you experience any technical issues, our support team is here to help.',
    ),
    FAQItem(
      question: 'What payment methods are accepted?',
      answer:
          'We accept various payment methods including M-Pesa, credit/debit cards, and PayPal for your convenience.',
    ),
    FAQItem(
      question: 'How long does registration take?',
      answer:
          'Domain registration is usually instant. Once payment is confirmed, your domain will be active within minutes.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pricing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Domain Registration Info',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  content: const SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Domain Registration Process:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('1. Choose your preferred domain extension'),
                        Text('2. Check domain availability'),
                        Text('3. Complete registration form'),
                        Text('4. Make payment'),
                        Text('5. Verify your contact information'),
                        SizedBox(height: 16),
                        Text(
                          'Requirements:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('• Valid email address'),
                        Text('• Contact information'),
                        Text('• Payment method'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterDomainPage(),
                          ),
                        );
                      },
                      child: const Text('Start Registration'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ..._plans.map((plan) => _buildPricingCard(plan)),
                  const SizedBox(height: 24),
                  _buildComparisonTable(),
                  const SizedBox(height: 24),
                  _buildFAQSection(),
                  const SizedBox(height: 24),
                  _buildContinueButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.shade100,
            Colors.blueAccent.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.domain,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            'Choose Your Perfect Domain',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select the right plan for your needs',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(PricingPlan plan) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: plan.isPopular
              ? const BorderSide(color: Colors.blueAccent, width: 2)
              : BorderSide.none,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plan.isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                plan.type,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'KES ${plan.price.toStringAsFixed(2)}/year',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                plan.description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              ...plan.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(feature),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterDomainPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Feature Comparison',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Feature')),
                  DataColumn(label: Text('.KE')),
                  DataColumn(label: Text('.CO.KE')),
                  DataColumn(label: Text('.OR.KE')),
                ],
                rows: [
                  _buildFeatureRow('WHOIS Privacy', true, true, true),
                  _buildFeatureRow('DNS Management', true, true, true),
                  _buildFeatureRow('Email Forwarding', true, true, false),
                  _buildFeatureRow('Priority Support', true, false, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildFeatureRow(String feature, bool ke, bool coKe, bool orKe) {
    Widget checkmark(bool available) {
      return Icon(
        available ? Icons.check_circle : Icons.remove_circle,
        color: available ? Colors.green : Colors.red,
        size: 20,
      );
    }

    return DataRow(
      cells: [
        DataCell(Text(feature)),
        DataCell(checkmark(ke)),
        DataCell(checkmark(coKe)),
        DataCell(checkmark(orKe)),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ExpansionPanelList.radio(
              elevation: 0,
              children: _faqItems
                  .map(
                    (faq) => ExpansionPanelRadio(
                      value: faq.question,
                      headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(
                          faq.question,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(faq.answer),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RegisterDomainPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Continue to Registration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PricingPlan {
  final String type;
  final double price;
  final String description;
  final List<String> features;
  final bool isPopular;

  PricingPlan({
    required this.type,
    required this.price,
    required this.description,
    required this.features,
    this.isPopular = false,
  });
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
