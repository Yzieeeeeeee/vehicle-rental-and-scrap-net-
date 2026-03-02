import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigilant/theme/app_theme.dart';
import 'package:vigilant/login/auth_screen.dart';
import 'package:vigilant/utils/page_transitions.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppTheme.textPrimaryColor,
            ),
            onPressed: () {},
          ).animate().fadeIn(delay: 400.ms).rotate(duration: 400.ms),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?u=a042581f4e29026704d',
                            ),
                          ),
                        )
                        .animate()
                        .scale(duration: 500.ms, curve: Curves.easeOutBack)
                        .fadeIn(),
                    const SizedBox(height: 16),
                    Text(
                          'Alex Johnson',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        )
                        .animate()
                        .slideY(begin: 0.5, end: 0, delay: 200.ms)
                        .fadeIn(),
                    const SizedBox(height: 4),
                    Text(
                          'alex.johnson@example.com',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppTheme.textSecondaryColor,
                          ),
                        )
                        .animate()
                        .slideY(begin: 0.5, end: 0, delay: 300.ms)
                        .fadeIn(),
                    const SizedBox(height: 16),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified_user,
                            color: AppTheme.accentColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Verified Citizen',
                            style: GoogleFonts.poppins(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ).animate().scale(delay: 400.ms).fadeIn(),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Stats Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                    'Incident Reports',
                    '12',
                    Icons.report_problem,
                    AppTheme.dangerColor,
                  ).animate().slideX(begin: -0.5, delay: 500.ms).fadeIn(),
                  _buildStatCard(
                    'Resolved Alerts',
                    '8',
                    Icons.check_circle_outline,
                    Colors.teal,
                  ).animate().slideX(begin: 0.5, delay: 500.ms).fadeIn(),
                ],
              ),
              const SizedBox(height: 40),

              // Menu Settings
              _buildMenuSection([
                _buildMenuItem(
                  Icons.person_outline,
                  'Personal Information',
                  () {},
                ),
                _buildMenuItem(
                  Icons.security_outlined,
                  'Emergency Contacts',
                  () {},
                ),
                _buildMenuItem(
                  Icons.location_on_outlined,
                  'Home Location',
                  () {},
                ),
              ]).animate().slideY(begin: 0.2, delay: 600.ms).fadeIn(),

              const SizedBox(height: 20),

              _buildMenuSection([
                _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
                _buildMenuItem(
                  Icons.description_outlined,
                  'Terms & Privacy',
                  () {},
                ),
              ]).animate().slideY(begin: 0.2, delay: 700.ms).fadeIn(),

              const SizedBox(height: 40),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      CustomPageTransitions.slideUp(const AuthScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout, color: AppTheme.dangerColor),
                  label: Text(
                    'LOGOUT',
                    style: GoogleFonts.montserrat(
                      color: AppTheme.dangerColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppTheme.dangerColor.withOpacity(0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ).animate().scale(delay: 800.ms).fadeIn(),
              const SizedBox(height: 80), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 12),
            Text(
              count,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
