import 'package:flutter/material.dart';

class MyDomainsPage extends StatefulWidget {
  const MyDomainsPage({super.key});

  @override
  State<MyDomainsPage> createState() => _MyDomainsPageState();
}

class _MyDomainsPageState extends State<MyDomainsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
    _initializeDomains();
  }

  void _initializeDomains() {
    print('Initializing domains...');
    // Make sure we have domains in different categories
    for (var domain in _allDomains) {
      print('Domain: ${domain.name}, Status: ${domain.status}');
    }
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final List<String> _filters = ['All', 'Active', 'Expiring Soon', 'Previous'];

  // Example domains - in a real app, this would come from a service
  final List<DomainItem> _allDomains = [
    // Active Domains
    DomainItem(
      name: 'shopify.ke',
      status: DomainStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 180)),
      renewalPrice: 999.0,
      autoRenew: true,
    ),
    DomainItem(
      name: 'techworld.co.ke',
      status: DomainStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 240)),
      renewalPrice: 1299.0,
      autoRenew: true,
    ),
    DomainItem(
      name: 'fashionista.ke',
      status: DomainStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 300)),
      renewalPrice: 999.0,
      autoRenew: true,
    ),
    // Expiring Soon Domains
    DomainItem(
      name: 'mystore.ke',
      status: DomainStatus.expiringSoon,
      expiryDate: DateTime.now().add(const Duration(days: 15)),
      renewalPrice: 999.0,
      autoRenew: false,
    ),
    DomainItem(
      name: 'foodhub.co.ke',
      status: DomainStatus.expiringSoon,
      expiryDate: DateTime.now().add(const Duration(days: 20)),
      renewalPrice: 1299.0,
      autoRenew: false,
    ),
    DomainItem(
      name: 'travelblog.ke',
      status: DomainStatus.expiringSoon,
      expiryDate: DateTime.now().add(const Duration(days: 25)),
      renewalPrice: 999.0,
      autoRenew: false,
    ),
    // More Active Domains
    DomainItem(
      name: 'digitech.ke',
      status: DomainStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 150)),
      renewalPrice: 999.0,
      autoRenew: true,
    ),
    DomainItem(
      name: 'smartsolutions.co.ke',
      status: DomainStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 200)),
      renewalPrice: 1299.0,
      autoRenew: true,
    ),
    // More Expiring Soon
    DomainItem(
      name: 'beautyspa.ke',
      status: DomainStatus.expiringSoon,
      expiryDate: DateTime.now().add(const Duration(days: 28)),
      renewalPrice: 999.0,
      autoRenew: false,
    ),
    DomainItem(
      name: 'gamershub.co.ke',
      status: DomainStatus.expiringSoon,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      renewalPrice: 1299.0,
      autoRenew: false,
    ),
  ];

  int get _totalDomains => _allDomains.length;
  int get _expiringDomains => _allDomains
      .where((domain) => domain.status == DomainStatus.expiringSoon)
      .length;

  List<DomainItem> get _filteredDomains {
    var domains = _searchController.text.isEmpty
        ? _allDomains
        : _allDomains
            .where((domain) => domain.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();

    switch (_selectedFilter) {
      case 'All':
        return domains;
      case 'Active':
        return domains
            .where((domain) => domain.status == DomainStatus.active)
            .toList();
      case 'Expiring Soon':
        return domains
            .where((domain) => domain.status == DomainStatus.expiringSoon)
            .toList();
      case 'Previous':
        return domains
            .where((domain) =>
                domain.status == DomainStatus.previous ||
                domain.expiryDate.isBefore(DateTime.now()))
            .toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Domains',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildWelcomeBanner(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSearchBar(),
                        const SizedBox(height: 16),
                        _buildFilterChips(),
                        const SizedBox(height: 16),
                        Text(
                          '$_selectedFilter Domains (${_filteredDomains.length})',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  if (_filteredDomains.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: _buildEmptyState(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      child: Column(
                        children: _filteredDomains
                            .map((domain) => _buildDomainCard(domain))
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSummaryWidget(),
                  _buildRegisterButton(),
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
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 32.0,
        bottom: 40.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.shade100,
            Colors.blueAccent.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.domain_verification,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Manage your domains with ease',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'All your domains in one place',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search domains...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: FilterChip(
                  selected: isSelected,
                  label: Text(filter),
                  onSelected: (selected) {
                    setState(() => _selectedFilter = filter);
                  },
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blueAccent.withOpacity(0.15),
                  checkmarkColor: Colors.blueAccent,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.blueAccent : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color:
                          isSelected ? Colors.blueAccent : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  elevation: isSelected ? 2 : 0,
                  pressElevation: 0,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDomainCard(DomainItem domain) {
    final daysUntilExpiry = domain.expiryDate.difference(DateTime.now()).inDays;
    final isExpiring = daysUntilExpiry <= 30 && daysUntilExpiry > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isExpiring
              ? const BorderSide(color: Colors.orange, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () {
            // TODO: Navigate to domain details
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.language,
                            color: Colors.blueAccent,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                domain.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  _buildStatusBadge(domain.status),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Expires ${_formatExpiryDate(domain.expiryDate)}',
                                      style: TextStyle(
                                        color: isExpiring
                                            ? Colors.orange
                                            : Colors.grey.shade600,
                                        fontWeight: isExpiring
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'KES ${domain.renewalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'per year',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.autorenew,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Auto-renew',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Switch.adaptive(
                          value: domain.autoRenew,
                          onChanged: (value) {
                            setState(() => domain.autoRenew = value);
                          },
                          activeColor: Colors.blueAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'Manage',
                            Icons.settings,
                            onPressed: () {
                              // TODO: Navigate to domain management
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            'Renew',
                            Icons.refresh,
                            onPressed: () {
                              // TODO: Navigate to renewal
                            },
                            isPrimary: isExpiring,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(DomainStatus status) {
    Color color;
    String text;

    switch (status) {
      case DomainStatus.active:
        color = Colors.green;
        text = 'Active';
        break;
      case DomainStatus.expiringSoon:
        color = Colors.orange;
        text = 'Expiring Soon';
        break;
      case DomainStatus.inactive:
        color = Colors.red;
        text = 'Inactive';
        break;
      case DomainStatus.previous:
        color = Colors.grey;
        text = 'Previous';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status == DomainStatus.active
                ? Icons.check_circle
                : status == DomainStatus.expiringSoon
                    ? Icons.warning
                    : Icons.error,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon,
      {required VoidCallback onPressed, bool isPrimary = false}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blueAccent : Colors.grey.shade100,
        foregroundColor: isPrimary ? Colors.white : Colors.blueAccent,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSummaryWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildSummaryItem(
              'Total Domains',
              _totalDomains.toString(),
              Icons.domain,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade200.withOpacity(0),
                  Colors.grey.shade300,
                  Colors.grey.shade200.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: _buildSummaryItem(
              'Expiring Soon',
              _expiringDomains.toString(),
              Icons.warning,
              color: Colors.orange,
              showAlert: _expiringDomains > 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon, {
    Color color = Colors.blueAccent,
    bool showAlert = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            if (showAlert)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Navigate to domain registration
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
            Icon(Icons.add),
            SizedBox(width: 8),
            Text(
              'Register New Domain',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedFilter == 'Available'
                ? Icons.search_off
                : Icons.domain_disabled,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter == 'Available'
                ? 'No available domains found'
                : 'No domains found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isNotEmpty
                ? 'Try a different search term'
                : _selectedFilter == 'Available'
                    ? 'Try searching for a different domain name'
                    : 'Register your first domain now',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  String _formatExpiryDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference <= 30) {
      return 'in $difference days';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

enum DomainStatus {
  active,
  expiringSoon,
  inactive,
  previous,
}

class DomainItem {
  final String name;
  DomainStatus status;
  final DateTime expiryDate;
  final double renewalPrice;
  bool autoRenew;

  DomainItem({
    required this.name,
    required this.status,
    required this.expiryDate,
    required this.renewalPrice,
    required this.autoRenew,
  });
}

class AvailableDomain {
  final String name;
  final double price;
  final String category;
  final bool isPopular;

  AvailableDomain({
    required this.name,
    required this.price,
    required this.category,
    this.isPopular = false,
  });
}
