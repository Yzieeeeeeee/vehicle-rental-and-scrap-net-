import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/screens/user/user_dashboard.dart';
import 'package:vigilant/screens/user/report_incident.dart';
import 'package:vigilant/screens/user/user_profile_page.dart';
import 'package:vigilant/screens/shared/incident_map_screen.dart';
import 'package:vigilant/screens/shared/incident_news_screen.dart';
import 'package:vigilant/theme/app_theme.dart';

class UserNavigationPage extends StatefulWidget {
  const UserNavigationPage({super.key});

  @override
  State<UserNavigationPage> createState() => _UserNavigationPageState();
}

class _UserNavigationPageState extends State<UserNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserDashboard(),
    const IncidentNewsScreen(),
    const ReportIncidentScreen(),
    const IncidentMapScreen(isAdmin: false),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: IndexedStack(index: _currentIndex, children: _pages),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child:
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.white.withOpacity(0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                          Icons.home_outlined,
                          Icons.home,
                          'Home',
                          0,
                        ),
                        _buildNavItem(
                          Icons.article_outlined,
                          Icons.article,
                          'News',
                          1,
                        ),
                        _buildNavItem(
                          Icons.add_circle_outline,
                          Icons.add_circle,
                          'Report',
                          2,
                        ),
                        _buildNavItem(Icons.map_outlined, Icons.map, 'Map', 3),
                        _buildNavItem(
                          CupertinoIcons.person,
                          CupertinoIcons.person_solid,
                          'Profile',
                          4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().slideY(
              begin: 1.5,
              end: 0,
              duration: 1000.ms,
              curve: Curves.easeOutCubic,
            ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData outline,
    IconData solid,
    String label,
    int index,
  ) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        width: isSelected ? 100 : 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                  isSelected ? solid : outline,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  size: 26,
                )
                .animate(target: isSelected ? 1 : 0)
                .scaleXY(begin: 0.9, end: 1.1, duration: 200.ms),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideX(begin: 0.2, end: 0, duration: 300.ms),
            ],
          ],
        ),
      ),
    );
  }
}
