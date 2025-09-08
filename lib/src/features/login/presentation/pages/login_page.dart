import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../../data/repositories/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../forgot_password/presentation/pages/forgot_password_page.dart';

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
                  color: Color.fromARGB(255, 25, 84, 244),
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
                        return Stack(
                          children: [
                            Column(
                              children: [
                                // Email field
                                _buildInputField(
                                  controller: controller.emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  isLoading: controller.isLoading,
                                ),
                                const SizedBox(height: 30),

                                // Password field
                                _buildPasswordField(controller),
                                const SizedBox(height: 50),

                                // Keep logged in and Forgot password
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              borderRadius:
                                                  BorderRadius.circular(4),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) =>
                                                    const ForgotPasswordPage(),
                                          ),
                                        );
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
                                                  // Show success notification
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            response.message ??
                                                                'Login successful!',
                                                            style:
                                                                const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                      duration: const Duration(
                                                        seconds: 2,
                                                      ),
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                    ),
                                                  );

                                                  Navigator.of(
                                                    context,
                                                  ).pushReplacement(
                                                    MaterialPageRoute(
                                                      builder:
                                                          (_) =>
                                                              const HomePage(),
                                                    ),
                                                  );
                                                }
                                              } else if (response != null &&
                                                  !response.success) {
                                                // Show error popup notification
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.error,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              response.message ??
                                                                  'Invalid credentials',
                                                              style: const TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      duration: const Duration(
                                                        seconds: 3,
                                                      ),
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      action: SnackBarAction(
                                                        label: 'Dismiss',
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).hideCurrentSnackBar();
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        25,
                                        84,
                                        244,
                                      ),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      elevation: 0,
                                    ),
                                    child:
                                        controller.isLoading
                                            ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  'Logging in...',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                  ),
                                                ),
                                              ],
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
                            ),
                            // Loading overlay
                            if (controller.isLoading)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(
                                            strokeWidth: 3,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.blue,
                                                ),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Please wait...',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF2C3E50),
                                            ),
                                          ),
                                        ],
                                      ),
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
    bool isLoading = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isLoading ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isLoading ? Colors.grey.shade300 : const Color(0xFF7E81BD),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: !isLoading,
        style: TextStyle(
          fontSize: 16,
          color: isLoading ? Colors.grey.shade600 : const Color(0xFF2C3E50),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isLoading ? Colors.grey.shade400 : const Color(0xFF95A5A6),
            fontSize: 16,
          ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: controller.isLoading ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color:
              controller.isLoading
                  ? Colors.grey.shade300
                  : const Color(0xFF7E81BD),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller.passwordController,
        obscureText: !controller.isPasswordVisible,
        enabled: !controller.isLoading,
        style: TextStyle(
          fontSize: 16,
          color:
              controller.isLoading
                  ? Colors.grey.shade600
                  : const Color(0xFF2C3E50),
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            color:
                controller.isLoading
                    ? Colors.grey.shade400
                    : const Color(0xFF95A5A6),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          suffixIcon: GestureDetector(
            onTap:
                controller.isLoading
                    ? null
                    : controller.togglePasswordVisibility,
            child: Icon(
              controller.isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color:
                  controller.isLoading
                      ? Colors.grey.shade400
                      : const Color(0xFF95A5A6),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
