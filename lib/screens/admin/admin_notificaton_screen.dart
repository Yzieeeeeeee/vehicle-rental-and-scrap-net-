import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigilant/theme/app_theme.dart';

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────
enum NotificationType { emergency, incident, sos, system, broadcast }

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String location;
  final NotificationType type;
  final bool isRead;
  final bool isUrgent;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.location,
    required this.type,
    this.isRead = false,
    this.isUrgent = false,
  });
}

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({super.key});

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _pulseController;

  final List<String> _tabs = ['All', 'Emergency', 'Incident', 'SOS', 'System'];

  final List<NotificationItem> _notifications = const [
    NotificationItem(
      id: '1',
      title: 'Critical Road Accident',
      subtitle: 'Multiple vehicles involved on NH66. Rescue requested.',
      time: '2 min ago',
      location: 'NH66, Alappuzha Bypass',
      type: NotificationType.emergency,
      isUrgent: true,
    ),
    NotificationItem(
      id: '2',
      title: 'SOS Triggered — Anjali M.',
      subtitle: 'Location shared with trusted contacts. Awaiting response.',
      time: '8 min ago',
      location: 'Mullackal, Alappuzha',
      type: NotificationType.sos,
      isUrgent: true,
    ),
    NotificationItem(
      id: '3',
      title: 'Flash Flood Warning',
      subtitle:
          'Heavy rainfall reported near Kuttanad region. 12 users reporting waterlogging.',
      time: '15 min ago',
      location: 'Kuttanad, Kerala',
      type: NotificationType.incident,
      isUrgent: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Suspicious Activity Report',
      subtitle:
          'Unverified report submitted by user Ravi K. Requires admin review before publishing.',
      time: '32 min ago',
      location: 'KSRTC Bus Stand',
      type: NotificationType.incident,
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'Emergency Broadcast Sent',
      subtitle: 'Admin broadcast "Heavy rain alert" delivered to 1,248 users.',
      time: '1 hr ago',
      location: 'Alappuzha District',
      type: NotificationType.broadcast,
      isRead: true,
    ),
    NotificationItem(
      id: '6',
      title: 'New User Registration Spike',
      subtitle: '47 new users registered in the last hour. System normal.',
      time: '1 hr ago',
      location: 'System',
      type: NotificationType.system,
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  List<NotificationItem> get _filteredNotifications {
    if (_selectedTab == 0) return _notifications;
    final types = [
      null,
      NotificationType.emergency,
      NotificationType.incident,
      NotificationType.sos,
      NotificationType.system,
    ];
    final type = types[_selectedTab];
    return _notifications.where((n) => n.type == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Command Center',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) => Container(
              margin: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(
                  0.1 + (_pulseController.value * 0.1),
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.successColor.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.successColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'SYSTEM LIVE',
                    style: GoogleFonts.poppins(
                      color: AppTheme.successColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStatsRow()
                .animate()
                .slideX(begin: 0.2, duration: 400.ms)
                .fadeIn(),
            const SizedBox(height: 10),
            _buildTabBar()
                .animate()
                .slideX(begin: -0.2, delay: 200.ms)
                .fadeIn(),
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
      floatingActionButton: _buildBroadcastFAB().animate().scale(
        delay: 600.ms,
        curve: Curves.easeOutBack,
      ),
    );
  }

  // ── STATS ROW ──
  Widget _buildStatsRow() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _statCard('Urgent', '3', AppTheme.dangerColor, Icons.warning_rounded),
          const SizedBox(width: 12),
          _statCard('SOS Active', '1', Colors.orange, Icons.sos_rounded),
          const SizedBox(width: 12),
          _statCard('Review', '5', Colors.indigoAccent, Icons.pending_rounded),
          const SizedBox(width: 12),
          _statCard(
            'Resolved',
            '24',
            AppTheme.successColor,
            Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, Color color, IconData icon) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.montserrat(
              color: AppTheme.textPrimaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── TAB BAR ──
  Widget _buildTabBar() {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 5,
                        ),
                      ],
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : Colors.grey.shade200,
                ),
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: GoogleFonts.poppins(
                    color: isSelected
                        ? Colors.white
                        : AppTheme.textSecondaryColor,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── NOTIFICATION LIST ──
  Widget _buildNotificationList() {
    final items = _filteredNotifications;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monitor_heart_outlined,
              color: Colors.grey.shade400,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'No active alerts',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ).animate().fadeIn();
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _NotificationCard(
              item: items[index],
              onTap: () => _showNotificationDetail(items[index]),
            )
            .animate()
            .slideY(
              begin: 0.3,
              end: 0,
              delay: Duration(milliseconds: 300 + (index * 100)),
            )
            .fadeIn();
      },
    );
  }

  // ── BROADCAST FAB ──
  Widget _buildBroadcastFAB() {
    return GestureDetector(
      onTap: () => _showBroadcastDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryColor, AppTheme.accentColor],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.campaign_rounded, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              'BROADCAST',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetail(NotificationItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _NotificationDetailSheet(item: item),
    );
  }

  void _showBroadcastDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _BroadcastSheet(),
    );
  }
}

// ─────────────────────────────────────────────
// NOTIFICATION CARD
// ─────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const _NotificationCard({required this.item, required this.onTap});

  Color get _typeColor {
    switch (item.type) {
      case NotificationType.emergency:
        return AppTheme.dangerColor;
      case NotificationType.sos:
        return Colors.orange;
      case NotificationType.incident:
        return Colors.indigoAccent;
      case NotificationType.broadcast:
        return AppTheme.primaryColor;
      case NotificationType.system:
        return AppTheme.successColor;
    }
  }

  IconData get _typeIcon {
    switch (item.type) {
      case NotificationType.emergency:
        return Icons.local_fire_department_rounded;
      case NotificationType.sos:
        return Icons.sos_rounded;
      case NotificationType.incident:
        return Icons.report_problem_rounded;
      case NotificationType.broadcast:
        return Icons.campaign_rounded;
      case NotificationType.system:
        return Icons.settings_suggest_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: item.isRead ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: item.isUrgent
                ? _typeColor.withOpacity(0.5)
                : Colors.grey.shade200,
            width: item.isUrgent ? 2 : 1,
          ),
          boxShadow: item.isUrgent
              ? [
                  BoxShadow(
                    color: _typeColor.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _typeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_typeIcon, color: _typeColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _typeColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.type.name.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Text(
                          item.time,
                          style: GoogleFonts.poppins(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: GoogleFonts.montserrat(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: item.isRead
                            ? FontWeight.w600
                            : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.poppins(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 13,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: _typeColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.location,
                          style: GoogleFonts.poppins(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
}

// ─────────────────────────────────────────────
// DETAIL & BROADCAST SHEETS
// ─────────────────────────────────────────────
class _NotificationDetailSheet extends StatelessWidget {
  final NotificationItem item;
  const _NotificationDetailSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'Alert Details',
                style: GoogleFonts.montserrat(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (item.isUrgent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.dangerColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'URGENT',
                    style: GoogleFonts.poppins(
                      color: AppTheme.dangerColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                )..animate()
                    .scale(
                  duration: 1.seconds,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                )
                    .then()
                    .scale(
                  duration: 1.seconds,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.montserrat(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.subtitle,
                  style: GoogleFonts.poppins(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.location,
                      style: GoogleFonts.poppins(
                        color: AppTheme.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppTheme.primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.time,
                      style: GoogleFonts.poppins(
                        color: AppTheme.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'DISMISS',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Units have been dispatched.'),
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 10,
                    shadowColor: AppTheme.primaryColor.withOpacity(0.5),
                  ),
                  child: Text(
                    'DISPATCH TEAM',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _BroadcastSheet extends StatefulWidget {
  const _BroadcastSheet();

  @override
  State<_BroadcastSheet> createState() => _BroadcastSheetState();
}

class _BroadcastSheetState extends State<_BroadcastSheet> {
  int _selectedSeverity = 1;
  final List<String> _severities = ['Info', 'Warning', 'Critical'];
  final List<Color> _colors = [
    AppTheme.successColor,
    Colors.orange,
    AppTheme.dangerColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Send Emergency Broadcast',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: List.generate(3, (i) {
                final isSelected = _selectedSeverity == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedSeverity = i),
                    child: Container(
                      margin: EdgeInsets.only(right: i < 2 ? 10 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? _colors[i] : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? _colors[i] : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _severities[i],
                          style: GoogleFonts.poppins(
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textSecondaryColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 4,
              style: GoogleFonts.poppins(color: AppTheme.textPrimaryColor),
              decoration: InputDecoration(
                hintText: 'Type broadcast message to all users...',
                hintStyle: GoogleFonts.poppins(
                  color: AppTheme.textSecondaryColor,
                ),
                filled: true,
                fillColor: AppTheme.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Broadcast sent to all devices.'),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: Text(
                  'SEND BROADCAST',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
