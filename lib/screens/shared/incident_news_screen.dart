import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';

class IncidentNewsScreen extends StatelessWidget {
  const IncidentNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> newsList = [
      {
        "title": "Severe Accident on Bypass",
        "description":
            "A multi-vehicle collision has occurred on the NH bypass. Traffic is highly congested. Avoid the route if possible.",
        "time": "10 mins ago",
        "category": "Traffic",
        "imageUrl": "https://picsum.photos/seed/accident/400/200",
      },
      {
        "title": "Local Fire at Downtown Market",
        "description":
            "Fire-fighters are currently putting out a large fire near the central market. Please maintain distance.",
        "time": "45 mins ago",
        "category": "Fire",
        "imageUrl": "https://picsum.photos/seed/fire/400/200",
      },
      {
        "title": "Flooding warning issued",
        "description":
            "Heavy rain predictions. Low lying areas are advised to prepare for potential flooding tonight.",
        "time": "2 hours ago",
        "category": "Weather",
        "imageUrl": "https://picsum.photos/seed/flood/400/200",
      },
      {
        "title": "Suspicious Package Found",
        "description":
            "Police have cordoned off the East sector train station due to an unidentified package. Bomb squad in route.",
        "time": "3 hours ago",
        "category": "Security",
        "imageUrl": "https://picsum.photos/seed/security/400/200",
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Incident News',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 100,
        ),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return _buildNewsCard(news, index);
        },
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> news, int index) {
    return Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  news["imageUrl"],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            news["category"],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          news["time"],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      news["title"],
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news["description"],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Read More",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: 100 * index))
        .fadeIn();
  }
}
