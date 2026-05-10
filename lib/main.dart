import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Giriş ekranının yolunu buraya ekledik

void main() {
  runApp(const TravixApp());
}

class TravixApp extends StatelessWidget {
  const TravixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travix - Akıllı Turizm Rehberi',
      debugShowCheckedModeBanner:
          false, // O çirkin kırmızı debug bandını kaldırır
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true, // Modern, şık tasarım modu
      ),
      // Uygulama açılır açılmaz senin o haritalı LoginScreen ekranın gelecek
      home: const LoginScreen(),
    );
  }
}
