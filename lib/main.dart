import 'package:flutter/material.dart';
import 'package:vigilant/login/auth_screen.dart';
import 'package:vigilant/theme/app_theme.dart';

void main() {
  runApp(const VigilantApp());
}

class VigilantApp extends StatelessWidget {
  const VigilantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vigilant: Community Safety & SOS',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}
