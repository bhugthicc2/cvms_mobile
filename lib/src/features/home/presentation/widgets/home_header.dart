import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/user_model.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback onMenuTap;
  final VoidCallback onProfileTap;

  const HomeHeader({
    super.key,
    required this.user,
    required this.onMenuTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 25, 84, 244), // Blue color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Navigation bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onMenuTap,
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Text(
                    'Home',
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: ClipOval(
                        child:
                            user.profileImage != null
                                ? Image.network(
                                  user.profileImage!,
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  'assets/images/Ellipse 1.png',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Greeting section
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning,',
                      style: GoogleFonts.sora(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.fullName,
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
}
