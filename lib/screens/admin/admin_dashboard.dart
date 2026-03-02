import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';
import 'package:vigilant/login/auth_screen.dart';
import 'package:vigilant/utils/page_transitions.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  void _logout() {
    Navigator.of(
      context,
    ).pushReplacement(CustomPageTransitions.slideUp(const AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Admin Portal',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.admin_panel_settings,
          color: AppTheme.primaryColor,
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.dangerColor),
            onPressed: _logout,
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    'System Overview',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  )
                  .animate()
                  .slideX(begin: -0.2, end: 0, duration: 400.ms)
                  .fadeIn(),
              const SizedBox(height: 20),

              // Admin Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(
                    'Active Alerts',
                    '12',
                    AppTheme.dangerColor,
                    Icons.warning_amber_rounded,
                  ).animate().slideX(begin: -0.5, delay: 200.ms).fadeIn(),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    'Total Users',
                    '1,402',
                    AppTheme.primaryColor,
                    Icons.group_outlined,
                  ).animate().slideX(begin: 0.5, delay: 200.ms).fadeIn(),
                ],
              ),
              const SizedBox(height: 40),

              Text(
                'Recent Incidents Reports',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimaryColor,
                ),
              ).animate().slideX(begin: -0.2, delay: 400.ms).fadeIn(),
              const SizedBox(height: 15),

              // Admin Incident List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildAdminIncidentCard(index);
                },
              ),
              const SizedBox(height: 80), // bottom nav padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 1.seconds,
                ),
            const SizedBox(height: 20),
            Text(
              count,
              style: GoogleFonts.montserrat(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminIncidentCard(int index) {
    List<Map<String, dynamic>> incidents = [
      {
        "title": "Fire at 7th Ave",
        "status": "Critical",
        "reporter": "User14A",
        "color": AppTheme.dangerColor,
      },
      {
        "title": "Highway Blockage",
        "status": "Moderate",
        "reporter": "User89Z",
        "color": Colors.orange,
      },
      {
        "title": "Suspicious Activity",
        "status": "Low",
        "reporter": "Anonymous",
        "color": Colors.indigoAccent,
      },
      {
        "title": "Medical Emergency",
        "status": "Critical",
        "reporter": "User22P",
        "color": AppTheme.dangerColor,
      },
      {
        "title": "Car Accident",
        "status": "High",
        "reporter": "User55X",
        "color": AppTheme.accentColor,
      },
    ];

    var incident = incidents[index];

    return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 50,
                      decoration: BoxDecoration(
                        color: incident["color"],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            incident["title"],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 14,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Reporter: ${incident['reporter']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppTheme.textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: incident["color"].withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        incident["status"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: incident["color"],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .slideY(
          begin: 0.5,
          end: 0,
          delay: Duration(milliseconds: 500 + (index * 150)),
        )
        .fadeIn();
  }
}
