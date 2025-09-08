import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/user_model.dart';

class CustomDrawer extends StatelessWidget {
  final UserModel user;
  final VoidCallback onProfileTap;
  final VoidCallback onAboutTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const CustomDrawer({
    super.key,
    required this.user,
    required this.onProfileTap,
    required this.onAboutTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          // Header section with JRMSU branding - full width
          Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A), // Deep sapphire blue base
            ),
            child: Stack(
              children: [
                // Background image overlay with statue and building - expanded to fill all sides
                Positioned(
                  left: -20,
                  right: -20,
                  top: -10,
                  bottom: -10,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/splash bg.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                // Content
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        // Main content - Logo and text centered
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // JRMSU Logo - Simple rectangular design
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: const Color(
                                  0xFF1E3A8A,
                                ), // Dark blue background
                              ),
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/jrmsu.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            // JRMSU - K text - Large and bold white
                            Text(
                              'JRMSU - K',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sora(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // CLOUD-BASED VEHICLE MONITORING SYSTEM text - single line
                            Text(
                              'CLOUD-BASED VEHICLE MONITORING SYSTEM',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sora(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Menu items section
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile menu item
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: onProfileTap,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFE5E7EB),
                    thickness: 0.5,
                  ),
                  // About menu item
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: 'About',
                    onTap: onAboutTap,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFE5E7EB),
                    thickness: 0.5,
                  ),
                  // Settings menu item
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: onSettingsTap,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFE5E7EB),
                    thickness: 0.5,
                  ),
                  // Logout menu item
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: onLogoutTap,
                    isLogout: true,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFE5E7EB),
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Colors.black87,
          size: 24,
        ),
        title: Text(
          title,
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
            letterSpacing: 0.1,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isLogout ? Colors.red : Colors.grey.shade600,
          size: 16,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        minVerticalPadding: 0,
        dense: false,
      ),
    );
  }
}

class ArchitecturalPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.05)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5;

    // Draw subtle architectural patterns
    final path = Path();

    // Draw building silhouettes in the upper portion
    for (int i = 0; i < 5; i++) {
      final x = (size.width * 0.1) + (i * size.width * 0.2);
      final y = size.height * 0.1;
      final buildingHeight = size.height * 0.3;

      path.moveTo(x, y);
      path.lineTo(x + 20, y);
      path.lineTo(x + 20, y + buildingHeight);
      path.lineTo(x + 15, y + buildingHeight);
      path.lineTo(x + 15, y + buildingHeight - 10);
      path.lineTo(x + 10, y + buildingHeight - 10);
      path.lineTo(x + 10, y + buildingHeight);
      path.lineTo(x + 5, y + buildingHeight);
      path.lineTo(x + 5, y + buildingHeight - 15);
      path.lineTo(x, y + buildingHeight - 15);
      path.close();
    }

    // Draw additional patterns in the right portion
    for (int i = 0; i < 3; i++) {
      final x = size.width * 0.7 + (i * size.width * 0.1);
      final y = size.height * 0.2;
      final buildingHeight = size.height * 0.4;

      path.moveTo(x, y);
      path.lineTo(x + 15, y);
      path.lineTo(x + 15, y + buildingHeight);
      path.lineTo(x + 10, y + buildingHeight);
      path.lineTo(x + 10, y + buildingHeight - 20);
      path.lineTo(x + 5, y + buildingHeight - 20);
      path.lineTo(x + 5, y + buildingHeight);
      path.lineTo(x, y + buildingHeight);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
