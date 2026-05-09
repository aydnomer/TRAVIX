import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travix Turizm Rehberi'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Travix Akıllı Turizm Platformuna Hoş Geldiniz!\nÇok yakında buralar tarihi mekanlarla dolacak.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
