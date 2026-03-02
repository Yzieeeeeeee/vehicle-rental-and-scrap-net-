import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vigilant/theme/app_theme.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String _selectedType = 'Accident';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Report Incident',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.textPrimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Incident Details',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ).animate().slideX(begin: -0.2, end: 0, duration: 400.ms).fadeIn(),
            const SizedBox(height: 8),
            Text(
              'Provide accurate information to alert nearby users and authorities.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textSecondaryColor,
              ),
            ).animate().slideX(begin: -0.2, end: 0, delay: 100.ms).fadeIn(),
            const SizedBox(height: 30),

            // Incident Type Selection
            Text(
              'Type of Incident',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textPrimaryColor,
              ),
            ).animate().slideX(begin: -0.2, end: 0, delay: 200.ms).fadeIn(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTypeChip('Accident', Icons.car_crash, 0),
                _buildTypeChip('Blockage', Icons.construction, 1),
                _buildTypeChip('Fire', Icons.local_fire_department, 2),
                _buildTypeChip('Suspicious', Icons.visibility, 3),
                _buildTypeChip('Medical', Icons.medical_services, 4),
              ],
            ),
            const SizedBox(height: 30),

            // Description input
            _buildInputField(
              label: 'Description',
              icon: Icons.description_outlined,
              maxLines: 4,
              hint: 'What is happening?',
            ).animate().slideY(begin: 0.2, end: 0, delay: 400.ms).fadeIn(),
            const SizedBox(height: 20),

            // Location input
            _buildInputField(
              label: 'Location',
              icon: Icons.location_on_outlined,
              hint: 'Auto-detecting or enter manually',
              suffixIcon: Icons.my_location,
            ).animate().slideY(begin: 0.2, end: 0, delay: 500.ms).fadeIn(),
            const SizedBox(height: 20),

            // Media Upload
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.05),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: AppTheme.primaryColor.withOpacity(0.6),
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: 1.seconds,
                      ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to upload media (Optional)',
                    style: GoogleFonts.poppins(
                      color: AppTheme.primaryColor.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.2, end: 0, delay: 600.ms).fadeIn(),
            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.dangerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      shadowColor: AppTheme.dangerColor.withOpacity(0.5),
                    ),
                    child: Text(
                      'BROADCAST ALERT',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .animate()
                .scale(
                  delay: 700.ms,
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label, IconData icon, int index) {
    bool isSelected = _selectedType == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = label;
        });
      },
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    if (!isSelected)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    if (isSelected)
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                          icon,
                          size: 20,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textPrimaryColor,
                        )
                        .animate(target: isSelected ? 1 : 0)
                        .scaleXY(begin: 1, end: 1.2, duration: 200.ms),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .slideY(
                begin: 0.5,
                end: 0,
                delay: Duration(milliseconds: 200 + (index * 50)),
              )
              .fadeIn(),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? hint,
    IconData? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: AppTheme.textPrimaryColor),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: AppTheme.textSecondaryColor.withOpacity(0.5),
          ),
          labelStyle: GoogleFonts.poppins(color: AppTheme.textSecondaryColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Icon(icon, color: AppTheme.primaryColor.withOpacity(0.7)),
          ),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: AppTheme.accentColor)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 70,
                  color: AppTheme.successColor,
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
              ),
              const SizedBox(height: 20),
              Text(
                'Alert Broadcasted!',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 10),
              Text(
                'Nearby users and authorities have been notified.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'BACK TO HOME',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).scale(),
            ],
          ),
        ).animate().scale(duration: 300.ms, curve: Curves.easeOutCubic);
      },
    );
  }
}
