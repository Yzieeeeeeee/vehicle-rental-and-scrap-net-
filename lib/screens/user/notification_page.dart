import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({super.key});

  final List<Map<String, dynamic>> alerts = const [
    {
      'title': 'Severe Weather Warning',
      'description':
          'Heavy rainfall and potential waterlogging expected. Authorities advise staying indoors.',
      'location': 'Alappuzha District',
      'time': '10 mins ago',
      'severity': 'High',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Road Closure',
      'description':
          'Main junction blocked due to emergency maintenance work. Please use alternate routes.',
      'location': 'Mannancherry',
      'time': '1 hour ago',
      'severity': 'Medium',
      'icon': Icons.construction,
    },
    {
      'title': 'Scheduled Power Outage',
      'description':
          'KSEB power maintenance scheduled from 10:00 AM to 2:00 PM tomorrow.',
      'location': 'Ponnad',
      'time': '3 hours ago',
      'severity': 'Low',
      'icon': Icons.electric_bolt,
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'High':
        return AppTheme.dangerColor;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppTheme.textPrimaryColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: AppTheme.primaryColor),
            onPressed: () {},
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            final severityColor = _getSeverityColor(alert['severity']);

            return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: severityColor.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    alert['icon'],
                                    color: severityColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        alert['title'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        alert['time'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: AppTheme.textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: severityColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    alert['severity'].toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              alert['description'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppTheme.textSecondaryColor,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: severityColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    alert['location'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                ],
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
                  begin: 0.3,
                  end: 0,
                  delay: Duration(milliseconds: 200 + index * 100),
                )
                .fadeIn();
          },
        ),
      ),
    );
  }
}
