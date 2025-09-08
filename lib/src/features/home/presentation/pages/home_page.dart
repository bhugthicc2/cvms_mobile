import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/statistics_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/custom_drawer.dart';
import '../../../login/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Initialize the controller when the home page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<HomeController>(context, listen: false);
      controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const _HomePageView();
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
      drawer: Consumer<HomeController>(
        builder: (context, controller, child) {
          if (controller.user == null) {
            return const SizedBox();
          }
          return CustomDrawer(
            user: controller.user!,
            onProfileTap: () => _showProfile(context),
            onAboutTap: () => _showAbout(context),
            onSettingsTap: () => _showSettings(context),
            onLogoutTap: () => _handleLogout(context),
          );
        },
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3498DB)),
              ),
            );
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage!,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.initialize(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (controller.user == null || controller.statistics == null) {
            return const Center(child: Text('No data available'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with navigation and greeting
                HomeHeader(
                  user: controller.user!,
                  onMenuTap: () => Scaffold.of(context).openDrawer(),
                  onProfileTap: () => _showProfile(context),
                ),

                // Statistics Card with negative margin to overlay on header
                Transform.translate(
                  offset: const Offset(0, -80),
                  child: StatisticsCard(statistics: controller.statistics!),
                ),

                Transform.translate(
                  offset: const Offset(0, -70),
                  child: QuickActionsGrid(
                    quickActions: controller.quickActions,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAbout(BuildContext context) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, '/about');
  }

  void _showSettings(BuildContext context) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, '/settings');
  }

  void _showProfile(BuildContext context) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, '/profile');
  }

  void _handleLogout(BuildContext context) async {
    Navigator.pop(context); // Close menu

    final controller = Provider.of<HomeController>(context, listen: false);
    await controller.logout();

    // Sign out from Firebase Auth (only if Firebase is initialized)
    if (Firebase.apps.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        print('💥 Firebase Auth signOut error: $e');
      }
    }

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }
}
