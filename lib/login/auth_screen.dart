import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';
import 'package:vigilant/utils/page_transitions.dart';

import '../screens/user/navigation_page.dart';
import '../screens/admin/admin_navigation_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _navigateToDashboard(bool isAdmin) {
    if (isAdmin) {
      Navigator.of(context).pushReplacement(
        CustomPageTransitions.slideLeft(const AdminNavigationPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        CustomPageTransitions.slideUp(const UserNavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Header Section
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.accentColor.withOpacity(0.15),
                                ),
                                child: const Icon(
                                  Icons.shield_moon,
                                  size: 70,
                                  color: AppTheme.accentColor,
                                ),
                              ).animate().scale(
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                                delay: 200.ms,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                    'VIGILANT',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 4,
                                    ),
                                  )
                                  .animate()
                                  .slideY(begin: 0.5, end: 0, duration: 600.ms)
                                  .fadeIn(),
                              const SizedBox(height: 10),
                              Text(
                                    isLogin
                                        ? 'Welcome Back'
                                        : 'Join the Community',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  )
                                  .animate(key: ValueKey(isLogin))
                                  .fadeIn(duration: 400.ms)
                                  .slideY(begin: -0.2, end: 0),
                            ],
                          ),
                        ),
                      ),

                      // Auth Form Section
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: const BoxDecoration(
                            color: AppTheme.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (!isLogin) ...[
                                _buildTextField(
                                      label: 'Full Name',
                                      icon: Icons.person_outline,
                                    )
                                    .animate()
                                    .slideX(
                                      begin: 0.2,
                                      duration: 400.ms,
                                      delay: 100.ms,
                                    )
                                    .fadeIn(),
                                const SizedBox(height: 20),
                              ],
                              _buildTextField(
                                    label: 'Email Address',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                  )
                                  .animate()
                                  .slideX(
                                    begin: 0.2,
                                    duration: 400.ms,
                                    delay: 200.ms,
                                  )
                                  .fadeIn(),
                              const SizedBox(height: 20),
                              _buildTextField(
                                    label: 'Password',
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                  )
                                  .animate()
                                  .slideX(
                                    begin: 0.2,
                                    duration: 400.ms,
                                    delay: 300.ms,
                                  )
                                  .fadeIn(),
                              const SizedBox(height: 40),

                              GestureDetector(
                                    onTap: () => _navigateToDashboard(false),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.primaryColor,
                                            AppTheme.accentColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.primaryColor
                                                .withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          isLogin ? 'LOG IN' : 'SIGN UP',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .slideY(begin: 0.5, end: 0, delay: 500.ms)
                                  .fadeIn(),
                              const SizedBox(height: 20),

                              // Admin entry
                              if (isLogin)
                                OutlinedButton(
                                      onPressed: () =>
                                          _navigateToDashboard(true),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppTheme.primaryColor,
                                        side: const BorderSide(
                                          color: AppTheme.primaryColor,
                                          width: 2,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'LOG IN AS ADMIN',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    )
                                    .animate()
                                    .slideY(begin: 0.5, end: 0, delay: 600.ms)
                                    .fadeIn(),
                              const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isLogin
                                        ? "Don't have an account? "
                                        : "Already have an account? ",
                                    style: GoogleFonts.poppins(
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: toggleAuthMode,
                                    child: Text(
                                      isLogin ? 'Sign Up' : 'Log In',
                                      style: GoogleFonts.poppins(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(delay: 700.ms),
                              const SizedBox(height: 20),
                            ],
                          ).animate(key: ValueKey(isLogin)).fade(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          color: AppTheme.textPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: Icon(icon, color: AppTheme.primaryColor.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}
