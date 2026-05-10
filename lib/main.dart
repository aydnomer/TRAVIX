import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase ana paketi
import 'firebase_options.dart'; // Terminalden oluşturduğumuz ayar dosyası

import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() async {
  // Flutter çizim motorunun Firebase ile senkronize çalışması için zorunlu adım
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i projeye özel anahtarlarla başlatıyoruz
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const TravixApp());
}

class TravixApp extends StatelessWidget {
  const TravixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Profesyonel temamız
      home: const HomeScreen(),
    );
  }
}
