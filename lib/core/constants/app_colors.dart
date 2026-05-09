import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Bu sınıfın yanlışlıkla başka yerde üretilmesini (instance alınmasını) engeller

  static const Color primaryColor = Color(
    0xFF1E3A8A,
  ); // Koyu Lacivert (Güven ve profesyonellik)
  static const Color accentColor = Color(
    0xFFF97316,
  ); // Turuncu (Enerji ve keşif ruhu)
  static const Color backgroundColor = Color(
    0xFFF3F4F6,
  ); // Çok açık gri (Göz yormayan arka plan)
  static const Color textColor = Color(
    0xFF1F2937,
  ); // Koyu gri (Okunabilirlik için)
}
