import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';
import 'package:vigilant/screens/user/report_incident.dart';
import 'package:vigilant/utils/page_transitions.dart';
import 'package:vigilant/screens/user/notification_page.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  void _navigateToReport() {
    Navigator.of(
      context,
    ).push(CustomPageTransitions.fadeScale(const ReportIncidentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: AppTheme.textPrimaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CustomPageTransitions.slideUp(
                      const UserNotificationScreen(),
                    ),
                  );
                },
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shake(hz: 2, duration: 1.seconds, curve: Curves.easeInOut),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: AppTheme.textPrimaryColor,
            ),
            onPressed: () {},
          ),
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
                'Hello, Alex',
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ).animate().slideX(begin: -0.2, duration: 400.ms).fadeIn(),
              const SizedBox(height: 5),
              Text(
                'Stay alert and keep the community safe.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ).animate().slideX(begin: -0.2, delay: 100.ms).fadeIn(),
              const SizedBox(height: 40),

              // SOS BUTTON SECTION
              Center(
                    child:
                        GestureDetector(
                              onTap: () {
                                // Trigger immediate panic sequence
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.dangerColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.dangerColor.withOpacity(
                                        0.4,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.warning_amber_rounded,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'S.O.S',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .scale(
                              begin: const Offset(1, 1),
                              end: const Offset(1.08, 1.08),
                              duration: 2.seconds,
                              curve: Curves.easeInOut,
                            )
                            .shimmer(
                              duration: 2.seconds,
                              color: Colors.white.withOpacity(0.2),
                            ),
                  )
                  .animate()
                  .scale(
                    delay: 200.ms,
                    curve: Curves.easeOutBack,
                    duration: 600.ms,
                  )
                  .fadeIn(),
              const SizedBox(height: 50),

              // Report Button
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton.icon(
                  onPressed: _navigateToReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.white,
                    elevation: 10,
                    shadowColor: AppTheme.accentColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.report_problem_outlined, size: 28),
                  label: Text(
                    'REPORT INCIDENT',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ).animate().slideY(begin: 0.2, delay: 400.ms).fadeIn(),

              const SizedBox(height: 40),
              Text(
                'Nearby Alerts',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimaryColor,
                ),
              ).animate().slideX(begin: -0.2, delay: 500.ms).fadeIn(),
              const SizedBox(height: 15),

              // Recent Alerts List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildAlertCard(index);
                },
              ),
              const SizedBox(height: 80), // For bottom nav padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard(int index) {
    List<Map<String, dynamic>> dummyAlerts = [
      {
        "title": "Road Blockage",
        "location": "5th Avenue, Corner St.",
        "time": "5 mins ago",
        "color": Colors.orange,
        "icon": Icons.construction,
      },
      {
        "title": "Severe Accident",
        "location": "Highway 101 Southbound",
        "time": "12 mins ago",
        "color": AppTheme.dangerColor,
        "icon": Icons.car_crash,
      },
      {
        "title": "Suspicious Activity",
        "location": "Central Park West",
        "time": "25 mins ago",
        "color": Colors.indigoAccent,
        "icon": Icons.visibility,
      },
    ];

    var alert = dummyAlerts[index];

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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: alert["color"].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        alert["icon"],
                        color: alert["color"],
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert["title"],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  alert["location"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            alert["time"],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: alert["color"],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
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
          delay: Duration(milliseconds: 600 + (index * 150)),
        )
        .fadeIn();
  }
}
