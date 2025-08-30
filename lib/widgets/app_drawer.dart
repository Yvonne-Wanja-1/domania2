import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Main Features
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to dashboard
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.domain,
                  title: 'My Domains',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to domains
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.add_circle_outline,
                  title: 'Register Domain',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to domain registration
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.transfer_within_a_station,
                  title: 'Transfer Domain',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to domain transfer
                  },
                ),
                const Divider(),

                // Shopping & Billing
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'Cart',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to cart
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.receipt_long,
                  title: 'Billing & Invoices',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to billing
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.payments_outlined,
                  title: 'Payment Methods',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to payment methods
                  },
                ),
                const Divider(),

                // Tools & Services
                _buildDrawerItem(
                  context,
                  icon: Icons.dns_outlined,
                  title: 'DNS Management',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to DNS management
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.email_outlined,
                  title: 'Email Services',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to email services
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.security,
                  title: 'SSL Certificates',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to SSL management
                  },
                ),
                const Divider(),

                // Support & Settings
                _buildDrawerItem(
                  context,
                  icon: Icons.support_agent,
                  title: 'Support',
                  onTap: () {
                    Navigator.pop(context);
                    // Already on support page
                  },
                  isSelected: true,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.history,
                  title: 'Activity Log',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to activity log
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to settings
                  },
                ),
                const Divider(),

                // Account
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to profile
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.verified_user_outlined,
                  title: 'Security',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to security settings
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to notifications
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement logout logic
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
          _buildDrawerFooter(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: null,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade200,
            child: Icon(
              Icons.person,
              size: 32,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'john.doe@example.com',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
    Color? textColor,
  }) {
    final theme = Theme.of(context);
    final color = textColor ?? theme.textTheme.bodyLarge?.color;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blueAccent : color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blueAccent : color,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
      onTap: onTap,
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Version',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '1.0.0',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
