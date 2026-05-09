import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TravixApp());
}

class TravixApp extends StatelessWidget {
  const TravixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // İşte profesyonel temamızı buraya bağladık!
      home: const HomeScreen(),
    );
  }
}
