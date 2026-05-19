import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // FİREBASE EKLENDİ
import 'firebase_options.dart'; // FİREBASE AYARLARI EKLENDİ
import 'screens/login_screen.dart';

// main fonksiyonuna 'async' ekledik çünkü Firebase'in uyanmasını bekleyeceğiz
void main() async {
  // 1. Flutter'ın arayüz çizim motorunu hazırla
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase motorunu ateşle (Kırmızı ekranın çözümü burası!)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Her şey hazır olunca uygulamayı başlat
  runApp(const TravixApp());
}

class TravixApp extends StatelessWidget {
  const TravixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travix - Akıllı Turizm Rehberi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F2C59)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
