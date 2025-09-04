import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/home_controller.dart';
import '../../data/repositories/home_repository.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/get_statistics_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../widgets/home_header.dart';
import '../widgets/statistics_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../../../login/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => HomeController(
            GetUserUseCase(HomeRepositoryImpl()),
            GetStatisticsUseCase(HomeRepositoryImpl()),
            LogoutUseCase(HomeRepositoryImpl()),
          )..initialize(),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
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
                  onMenuTap: () => _showMenu(context),
                  onProfileTap: () => _showProfile(context),
                ),

                // Statistics Card
                StatisticsCard(statistics: controller.statistics!),

                const SizedBox(height: 20),

                // Quick Actions Grid
                QuickActionsGrid(quickActions: controller.quickActions),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help & Support'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to help
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => _handleLogout(context),
                ),
              ],
            ),
          ),
    );
  }

  void _showProfile(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Profile'),
            content: Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.user == null) return const SizedBox();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFF3498DB),
                      child:
                          controller.user!.profileImage != null
                              ? ClipOval(
                                child: Image.network(
                                  controller.user!.profileImage!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.user!.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(controller.user!.email),
                    const SizedBox(height: 8),
                    Text('Role: ${controller.user!.role}'),
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _handleLogout(BuildContext context) async {
    Navigator.pop(context); // Close menu

    final controller = Provider.of<HomeController>(context, listen: false);
    await controller.logout();

    // Sign out from Firebase Auth
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }
}
