import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domain/pages/register_domain_page.dart';
import 'package:domain/pages/cart_page.dart';
import 'package:domain/pages/pricing_page.dart';
import 'package:domain/pages/support_page.dart';
import 'package:domain/pages/my_domains_page.dart';
import 'package:domain/pages/profile_page.dart';
import 'package:domain/pages/onboarding/onboarding_page.dart';
import 'package:domain/pages/auth/login_page.dart';
import 'package:domain/widgets/app_drawer.dart';
import 'package:domain/state/app_state.dart';
import 'package:domain/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AppState
  final appState = AppState();
  await appState.loadThemePreference();

  // Initialize AuthService
  final authService = AuthService();
  await authService.initializeAuth();

  // Check onboarding status
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        ChangeNotifierProvider.value(value: authService),
      ],
      child: DomaniaApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class DomaniaApp extends StatefulWidget {
  final bool hasSeenOnboarding;

  const DomaniaApp({
    super.key,
    required this.hasSeenOnboarding,
  });

  @override
  State<DomaniaApp> createState() => _DomaniaAppState();
}

class _DomaniaAppState extends State<DomaniaApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('hasSeenOnboarding')) {
      await prefs.setBool('hasSeenOnboarding', false);
    }
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final authService = context.watch<AuthService>();

    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Domania App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueAccent),
          titleTextStyle: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueAccent),
          titleTextStyle: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: !widget.hasSeenOnboarding
          ? const OnboardingPage()
          : authService.currentUser == null
              ? const LoginPage()
              : const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  final List<String> _recentSearches = [
    'mycompany.ke',
    'startup.ke',
    'business.ke'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'Domania',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.language,
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Find Your Perfect Domain',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Secure your .KE domain name today',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for domain names...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),

            // Quick Actions Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildQuickActionCard(
                    context,
                    'My Domains',
                    Icons.domain,
                    Colors.blue,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Register New',
                    Icons.add_circle,
                    Colors.green,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Pricing',
                    Icons.attach_money,
                    Colors.orange,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Support',
                    Icons.help,
                    Colors.purple,
                  ),
                ],
              ),
            ),

            // Recent Searches Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Searches',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _recentSearches.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.history),
                          title: Text(_recentSearches[index]),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            // TODO: Implement search history functionality
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 8,
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blueAccent.withOpacity(0.1),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.blueAccent : Colors.grey),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.domain,
                color: _selectedIndex == 1 ? Colors.blueAccent : Colors.grey),
            label: 'My Domains',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart,
                color: _selectedIndex == 2 ? Colors.blueAccent : Colors.grey),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3 ? Colors.blueAccent : Colors.grey),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 1: // My Domains
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyDomainsPage(),
                ),
              ).then((_) => setState(() => _selectedIndex = 0));
              break;
            case 2: // Cart
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              ).then((_) => setState(() => _selectedIndex = 0));
              break;
            case 3: // Profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ).then((_) => setState(() => _selectedIndex = 0));
              break;
          }
        },
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'My Domains':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyDomainsPage(),
                ),
              );
              break;
            case 'Register New':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterDomainPage(
                    domainName: _searchController.text.isNotEmpty
                        ? _searchController.text
                        : null,
                  ),
                ),
              );
              break;
            case 'Pricing':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PricingPage(),
                ),
              );
              break;
            case 'Support':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupportPage(),
                ),
              );
              break;
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
