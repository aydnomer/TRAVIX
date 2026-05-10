import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildResponsiveAppBar(context),
      floatingActionButton: _buildCustomerSupportButton(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLayout(context);
          }
          return _buildMobileLayout(context);
        },
      ),
    );
  }

  // --- Üst Menü (AppBar) - Dil Seçeneği Eklendi ---
  PreferredSizeWidget _buildResponsiveAppBar(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 800;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          const Icon(Icons.explore, color: Colors.blueAccent, size: 30),
          const SizedBox(width: 10),
          const Text(
            'Travix',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ],
      ),
      actions: isWeb
          ? [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Hakkımızda',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Hizmet Bölgeleri',
                  style: TextStyle(color: Colors.black87),
                ),
              ),

              // İsteğin: Dil Seçeneği (Web)
              PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.black87),
                onSelected: (String value) {
                  // Dil değiştirme mantığı buraya gelecek
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'tr',
                    child: Text('Türkçe'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ]
          : [
              // İsteğin: Dil Seçeneği (Mobil)
              PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.black87),
                onSelected: (String value) {
                  // Dil değiştirme mantığı
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'tr',
                    child: Text('Türkçe'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                ],
              ),
            ],
    );
  }

  // --- Web Tasarımı (Baskın Yazılar, Belirgin Discover Başlığı) ---
  Widget _buildWebLayout(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/images/turkiye_haritasi_bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1300),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // İsteğin: Belirgin Tok Discover Turkey Başlığı
                        const Text(
                          'DISCOVER TURKEY\nWITH TRAVIX',
                          style: TextStyle(
                            fontSize: 56, // Devasa ve tok başlık
                            fontWeight: FontWeight.w900,
                            height: 1.0, // Daha sıkı satır aralığı
                            color: Colors.black, // Tam siyah, baskın
                            letterSpacing: -2.0,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ), // Okunurluk için
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Yeni Nesil Akıllı Turizm Deneyimi',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Travix ile dünya senin etrafında dönüyor. Keşfetmeye hazır mısın?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 45),
                        _buildInfoItem(
                          Icons.auto_awesome,
                          'Yapay Zeka Destekli',
                          'Tarihi mekanları senin için analiz eder.',
                        ),
                        const SizedBox(height: 25),
                        _buildInfoItem(
                          Icons.qr_code_scanner,
                          'QR Rehber',
                          'Tek bir tarama ile tüm hikaye cebinde.',
                        ),
                        const SizedBox(height: 25),
                        _buildInfoItem(
                          Icons.translate,
                          'Sınırsız Dil',
                          'Dünyayı kendi dilinde özgürce keşfet.',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 4, child: Center(child: _buildLoginPanel())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Mobil Tasarımı (Belirgin Discover Başlığı) ---
  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/turkiye_haritasi_bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // İsteğin: Mobilde de Belirgin Discover Başlığı
              const Text(
                'DISCOVER TURKEY\nWITH TRAVIX',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36, // Mobilde sığacak şekilde büyük
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  color: Colors.black,
                  shadows: [Shadow(color: Colors.white, blurRadius: 8)],
                ),
              ),
              const SizedBox(height: 40),
              _buildLoginPanel(),
            ],
          ),
        ),
      ],
    );
  }

  // --- Giriş Paneli (Google Simgesi Düzenlendi) ---
  Widget _buildLoginPanel() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Giriş Yap / Üye Ol',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              hintText: 'E-posta veya Telefon',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Şifre',
              prefixIcon: const Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Giriş Yap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('veya', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 20),

          // İsteğin: Google Simgeli Buton
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.g_mobiledata,
              color: Colors.red,
              size: 32,
            ), // G Simgesi
            label: const Text(
              'Google ile Devam Et',
              style: TextStyle(color: Colors.black87),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.sms, color: Colors.green),
            label: const Text(
              'SMS ile Doğrula',
              style: TextStyle(color: Colors.black87),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Yardımcı Widgetlar ---
  Widget _buildInfoItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 28),
        ),
        const SizedBox(width: 15),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerSupportButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 10),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.support_agent, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'CUSTOMER REPRESENTATIVE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
