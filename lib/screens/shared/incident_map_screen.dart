import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigilant/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IncidentMapScreen extends StatefulWidget {
  final bool isAdmin;
  const IncidentMapScreen({super.key, this.isAdmin = false});

  @override
  State<IncidentMapScreen> createState() => _IncidentMapScreenState();
}

class _IncidentMapScreenState extends State<IncidentMapScreen> {
  // Dummy Alappuzha/Kerala center
  final LatLng _MapCenter = const LatLng(9.4981, 76.3388);

  final List<Map<String, dynamic>> _incidentPoints = [
    {
      "location": const LatLng(9.5000, 76.3400),
      "title": "Severe Accident",
      "type": "Emergency",
      "description":
          "Multi-vehicle collision reported on the bypass. Rescue teams are on site. Expect traffic delays.",
      "color": AppTheme.dangerColor,
      "icon": Icons.car_crash,
      "time": "10 mins ago",
    },
    {
      "location": const LatLng(9.4890, 76.3299),
      "title": "Road Blockage",
      "type": "Incident",
      "description":
          "Fallen tree blocking both lanes of the state highway due to recent storm.",
      "color": Colors.orange,
      "icon": Icons.construction,
      "time": "45 mins ago",
    },
    {
      "location": const LatLng(9.5050, 76.3450),
      "title": "Suspicious Activity",
      "type": "Alert",
      "description":
          "Group of unidentified individuals seen trespassing near the restricted reservoir area.",
      "color": Colors.indigoAccent,
      "icon": Icons.visibility,
      "time": "1 hour ago",
    },
    {
      "location": const LatLng(9.4920, 76.3320),
      "title": "Fire Emergency",
      "type": "Emergency",
      "description":
          "Smoke visible from the abandoned warehouse. Fire department has been alerted and dispatched.",
      "color": AppTheme.dangerColor,
      "icon": Icons.local_fire_department,
      "time": "just now",
    },
  ];

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    if (!widget.isAdmin) return;
    _showAddIncidentDialog(point);
  }

  void _showAddIncidentDialog(LatLng point) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
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
                      'Add New Incident',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    )
                    .animate()
                    .slideX(begin: -0.2, end: 0, duration: 300.ms)
                    .fadeIn(),
                const SizedBox(height: 8),
                Text(
                  'Location: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}',
                  style: GoogleFonts.poppins(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('Incident Title', Icons.title),
                const SizedBox(height: 16),
                _buildTextField('Description', Icons.description, maxLines: 3),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _incidentPoints.add({
                          "location": point,
                          "title": "Admin Created Incident",
                          "type": "Alert",
                          "description":
                              "Manually added incident by Administrator.",
                          "color": AppTheme.accentColor,
                          "icon": Icons.warning_amber_rounded,
                          "time": "just now",
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Incident added to the live map.',
                          ),
                          backgroundColor: AppTheme.successColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'POST INCIDENT',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: AppTheme.textPrimaryColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: AppTheme.textSecondaryColor),
          prefixIcon: maxLines == 1
              ? Icon(icon, color: AppTheme.primaryColor.withOpacity(0.7))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Flutter Map implementation using OSM
          FlutterMap(
            options: MapOptions(
              initialCenter: _MapCenter,
              initialZoom: 14.0,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.vigilant.app',
              ),
              MarkerLayer(
                markers: _incidentPoints.map((point) {
                  return Marker(
                    width: 50.0,
                    height: 50.0,
                    point: point["location"] as LatLng,
                    child: GestureDetector(
                      onTap: () {
                        _showIncidentDetails(point);
                      },
                      child:
                          Container(
                                decoration: BoxDecoration(
                                  color: point["color"],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (point["color"] as Color)
                                          .withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  point["icon"],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              )
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .scale(
                                begin: const Offset(1, 1),
                                end: const Offset(1.2, 1.2),
                                duration: 800.ms,
                                curve: Curves.easeInOut,
                              ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 24,
                right: 24,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                              'Live Map',
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                            .animate()
                            .slideY(begin: -0.5, end: 0, duration: 400.ms)
                            .fadeIn(),
                        const SizedBox(height: 4),
                        Text(
                              widget.isAdmin
                                  ? 'Tap anywhere on the map to add an incident.'
                                  : 'Nearby Incidents & Alerts',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: widget.isAdmin
                                    ? AppTheme.accentColor
                                    : Colors.white.withOpacity(0.8),
                                fontWeight: widget.isAdmin
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            )
                            .animate()
                            .slideY(begin: -0.5, end: 0, delay: 100.ms)
                            .fadeIn(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: AppTheme.primaryColor,
                    ),
                  ).animate().scale(delay: 200.ms).fadeIn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showIncidentDetails(Map<String, dynamic> point) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (point["color"] as Color).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(point["icon"], color: point["color"], size: 32),
                  ).animate().scale(
                    curve: Curves.easeOutBack,
                    duration: 400.ms,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                              point["title"],
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimaryColor,
                              ),
                            )
                            .animate()
                            .slideY(begin: 0.2, end: 0, delay: 100.ms)
                            .fadeIn(),
                        const SizedBox(height: 4),
                        Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: point["color"],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    point["type"].toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  point["time"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            )
                            .animate()
                            .slideY(begin: 0.2, end: 0, delay: 200.ms)
                            .fadeIn(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Incident Report',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  point["description"] ?? "No detailed description available.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.textSecondaryColor,
                    height: 1.5,
                  ),
                ),
              ).animate().slideY(begin: 0.1, delay: 400.ms).fadeIn(),
              const SizedBox(height: 24),
              if (widget.isAdmin)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _incidentPoints.remove(point);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Incident resolved & removed.')),
                      );
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: AppTheme.successColor,
                    ),
                    label: Text(
                      'MARK AS RESOLVED',
                      style: GoogleFonts.poppins(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppTheme.successColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ).animate().scale(delay: 500.ms),
              const SizedBox(height: 30), // Padding for nav bar
            ],
          ),
        );
      },
    );
  }
}
