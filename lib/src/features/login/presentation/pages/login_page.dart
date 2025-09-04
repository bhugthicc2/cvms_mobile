import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../../data/repositories/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(LoginUseCase(LoginRepositoryImpl())),
      child: const _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatelessWidget {
  const _LoginPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top blue section with logo
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // White circular notch to mimic design reference
                    Positioned(
                      bottom: -100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Logo positioned to overlap with white section
                    Positioned(
                      bottom: -45,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 135,
                          height: 135,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/jrmsu.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // White section with login form
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Login heading
                    Text(
                      'LOGIN ACCOUNT',
                      style: GoogleFonts.sora(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C3E50),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please login your account to access',
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        color: const Color(0xFF7F8C8D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Login form
                    Consumer<LoginController>(
                      builder: (context, controller, child) {
                        return Column(
                          children: [
                            // Email field
                            _buildInputField(
                              controller: controller.emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 30),

                            // Password field
                            _buildPasswordField(controller),
                            const SizedBox(height: 50),

                            // Keep logged in and Forgot password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: controller.toggleKeepLoggedIn,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.keepLoggedIn
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child:
                                            controller.keepLoggedIn
                                                ? const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 14,
                                                )
                                                : null,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Keep me logged in',
                                      style: GoogleFonts.sora(
                                        fontSize: 12,
                                        color: const Color(0xFF2C3E50),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement forgot password
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: GoogleFonts.sora(
                                      fontSize: 12,
                                      color: const Color(0xFF7F8C8D),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Error message
                            if (controller.errorMessage != null)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  controller.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed:
                                    controller.isLoading
                                        ? null
                                        : () async {
                                          final response =
                                              await controller.login();
                                          if (response != null &&
                                              response.success) {
                                            if (context.mounted) {
                                              Navigator.of(
                                                context,
                                              ).pushReplacement(
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => const HomePage(),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 0,
                                ),
                                child:
                                    controller.isLoading
                                        ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        );
                      },
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF7E81BD), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF95A5A6), fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF7E81BD), width: 1),
      ),
      child: TextField(
        controller: controller.passwordController,
        obscureText: !controller.isPasswordVisible,
        style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(color: Color(0xFF95A5A6), fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: controller.togglePasswordVisibility,
            child: Icon(
              controller.isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: const Color(0xFF95A5A6),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
