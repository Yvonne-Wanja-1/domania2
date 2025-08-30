import 'package:flutter/material.dart';
import 'categories/domain_management_page.dart';
import 'categories/billing_payments_page.dart';
import 'categories/account_help_page.dart';
import 'categories/technical_support_page.dart';
import '../widgets/app_drawer.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final _searchController = TextEditingController();
  bool _wasHelpful = false;
  bool _hasGivenFeedback = false;

  final List<SupportCategory> _categories = [
    SupportCategory(
      title: 'Domain Management',
      icon: Icons.domain,
    ),
    SupportCategory(
      title: 'Billing & Payments',
      icon: Icons.payment,
    ),
    SupportCategory(
      title: 'Account Help',
      icon: Icons.person,
    ),
    SupportCategory(
      title: 'Technical Support',
      icon: Icons.code,
    ),
  ];

  final List<FAQ> _faqs = [
    FAQ(
      question: 'How do I renew my domain?',
      answer:
          'You can renew your domain through your dashboard under "My Domains." '
          'We also send email reminders before expiration. Early renewal is available '
          'up to 60 days before expiration.',
    ),
    FAQ(
      question: 'What payment methods do you accept?',
      answer:
          'We accept various payment methods including M-Pesa, credit/debit cards, '
          'and PayPal. All transactions are secure and encrypted.',
    ),
    FAQ(
      question: 'How long does domain registration take?',
      answer:
          'Domain registration is usually instant once payment is confirmed. '
          'You can start using your domain within minutes of purchase.',
    ),
    FAQ(
      question: 'Can I transfer my domain to another registrar?',
      answer:
          'Yes, you can transfer your domain after 60 days of registration. '
          'Contact our support team for the authorization code and transfer assistance.',
    ),
  ];

  final List<SupportArticle> _popularArticles = [
    SupportArticle(
      title: 'Setting up DNS Records',
      views: 1234,
      category: 'Technical',
    ),
    SupportArticle(
      title: 'Domain Privacy Protection',
      views: 987,
      category: 'Security',
    ),
    SupportArticle(
      title: 'Bulk Domain Registration',
      views: 756,
      category: 'Management',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Row(
          children: [
            Text(
              'Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.help_outline),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  _buildCategoriesGrid(),
                  const SizedBox(height: 24),
                  _buildPopularArticles(),
                  const SizedBox(height: 24),
                  _buildFAQSection(),
                  const SizedBox(height: 24),
                  _buildContactCard(),
                  const SizedBox(height: 24),
                  if (!_hasGivenFeedback) _buildFeedbackSection(),
                  const SizedBox(height: 24),
                  _buildSupportRequestButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
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
            Icons.support_agent,
            size: 64,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Text(
            'We\'re here to help',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your domains with ease',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for help...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 180,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              final page = switch (category.title) {
                'Domain Management' => const DomainManagementPage(),
                'Billing & Payments' => const BillingPaymentsPage(),
                'Account Help' => const AccountHelpPage(),
                'Technical Support' => const TechnicalSupportPage(),
                _ => null
              };

              if (page != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    size: 52,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopularArticles() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.trending_up, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  'Popular Articles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._popularArticles.map((article) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 24,
                    child: Icon(Icons.article, color: Colors.white, size: 28),
                  ),
                  title: Text(article.title),
                  subtitle:
                      Text('${article.views} views • ${article.category}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigate to article
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.question_answer, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ExpansionPanelList.radio(
              elevation: 0,
              children: _faqs
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

  Widget _buildContactCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.contact_support, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  'Contact Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactOption(
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Talk to our support team',
              onTap: () {
                // TODO: Start live chat
              },
            ),
            const Divider(height: 24),
            _buildContactOption(
              icon: Icons.email,
              title: 'Email Support',
              subtitle: 'support@domania.ke',
              onTap: () {
                // TODO: Open email client
              },
            ),
            const Divider(height: 24),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Phone Support',
              subtitle: '+254 700 000 000',
              onTap: () {
                // TODO: Open phone dialer
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Was this page helpful?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _giveFeedback(true),
                  icon: const Icon(Icons.thumb_up),
                  label: const Text('Yes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => _giveFeedback(false),
                  icon: const Icon(Icons.thumb_down),
                  label: const Text('No'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _giveFeedback(bool helpful) {
    setState(() {
      _wasHelpful = helpful;
      _hasGivenFeedback = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(helpful
            ? 'Thank you for your feedback!'
            : 'We\'ll work on improving our support.'),
        backgroundColor: helpful ? Colors.green : Colors.blue,
      ),
    );
  }

  Widget _buildSupportRequestButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Start support request
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.support),
          SizedBox(width: 8),
          Text(
            'Start a Support Request',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SupportCategory {
  final String title;
  final IconData icon;

  SupportCategory({
    required this.title,
    required this.icon,
  });
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });
}

class SupportArticle {
  final String title;
  final int views;
  final String category;

  SupportArticle({
    required this.title,
    required this.views,
    required this.category,
  });
}
