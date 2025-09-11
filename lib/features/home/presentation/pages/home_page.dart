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
    // Attach context for navigation from controller quick action handlers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<HomeController>(context, listen: false);
      controller.attachContext(context);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
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
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.error,
                    ),
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
    final scaffoldState = Scaffold.maybeOf(context);
    if (scaffoldState?.isDrawerOpen == true) {
      Navigator.pop(context); // Close drawer if open
    }
    Navigator.pushNamed(context, '/about');
  }

  void _showSettings(BuildContext context) {
    final scaffoldState = Scaffold.maybeOf(context);
    if (scaffoldState?.isDrawerOpen == true) {
      Navigator.pop(context); // Close drawer if open
    }
    Navigator.pushNamed(context, '/settings');
  }

  void _showProfile(BuildContext context) {
    final scaffoldState = Scaffold.maybeOf(context);
    if (scaffoldState?.isDrawerOpen == true) {
      Navigator.pop(context); // Close drawer if open
    }
    Navigator.pushNamed(context, '/profile');
  }

  void _handleLogout(BuildContext context) async {
    final scaffoldState = Scaffold.maybeOf(context);
    if (scaffoldState?.isDrawerOpen == true) {
      Navigator.pop(context); // Close menu if open
    }

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
