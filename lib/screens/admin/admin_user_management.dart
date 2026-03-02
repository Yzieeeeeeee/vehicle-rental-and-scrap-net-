import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() =>
      _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  final List<Map<String, dynamic>> _users = [
    {
      "name": "Alice M",
      "email": "alice.m@example.com",
      "reports": 4,
      "status": "Active",
      "avatar": "https://i.pravatar.cc/150?u=a042581f429026704d",
    },
    {
      "name": "Bob K",
      "email": "bob.k@example.com",
      "reports": 1,
      "status": "Suspended",
      "avatar": "https://i.pravatar.cc/150?u=1042581f429026704d",
    },
    {
      "name": "Charlie T",
      "email": "charlie.t@example.com",
      "reports": 12,
      "status": "Active",
      "avatar": "https://i.pravatar.cc/150?u=2042581f429026704d",
    },
    {
      "name": "Diana S",
      "email": "diana.s@example.com",
      "reports": 0,
      "status": "Active",
      "avatar": "https://i.pravatar.cc/150?u=3042581f429026704d",
    },
    {
      "name": "Ethan Hunt",
      "email": "ethan.h@example.com",
      "reports": 8,
      "status": "Banned",
      "avatar": "https://i.pravatar.cc/150?u=4042581f429026704d",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Manage Users',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textPrimaryColor),
            onPressed: () {},
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Directory',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ).animate().slideX(begin: -0.2, end: 0, duration: 400.ms).fadeIn(),
            const SizedBox(height: 8),
            Text(
              'Monitor and enforce actions on registered platform users.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textSecondaryColor,
              ),
            ).animate().slideX(begin: -0.2, end: 0, delay: 100.ms).fadeIn(),
            const SizedBox(height: 30),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return _buildUserCard(_users[index], index);
              },
            ),
            const SizedBox(height: 100), // padding for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user, int index) {
    Color statusColor = AppTheme.successColor;
    if (user['status'] == "Suspended") statusColor = Colors.orange;
    if (user['status'] == "Banned") statusColor = AppTheme.dangerColor;

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
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(user["avatar"]),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user["name"],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user["email"],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.report,
                                size: 14,
                                color: AppTheme.primaryColor.withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Reports: ${user['reports']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
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
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user["status"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
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
          delay: Duration(milliseconds: 300 + (index * 150)),
        )
        .fadeIn();
  }
}
