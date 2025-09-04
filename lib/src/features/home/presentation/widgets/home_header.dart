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
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xFF3498DB), // Blue color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
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
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child:
                          user.profileImage != null
                              ? ClipOval(
                                child: Image.network(
                                  user.profileImage!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : const Icon(
                                Icons.person,
                                color: Color(0xFF3498DB),
                                size: 24,
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Greeting section
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning,',
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.fullName,
                      style: GoogleFonts.sora(
                        fontSize: 24,
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
