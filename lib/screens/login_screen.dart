import 'package:flutter/material.dart';
// Yeni yazdığımız servisi sayfaya dahil ediyoruz
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- PREMIUM RENK PALETİ ---
  final Color primaryDark = const Color(0xFF0F2C59);
  final Color accentGold = const Color(0xFFDAC0A3);
  final Color bgLight = const Color(0xFFF9F9F9);
  final Color textDark = const Color(0xFF1E1E1E);

  // --- MOTOR VE KONTROLCÜLER (YENİ EKLENEN KISIM) ---
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hafıza sızıntılarını önlemek için sayfadan çıkınca kontrolcüleri temizliyoruz
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 850;

    return Scaffold(
      backgroundColor: bgLight,
      floatingActionButtonLocation: isWeb
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildCustomerSupportButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, isWeb),
            _buildFeaturesSection(isWeb),
            _buildHowItWorksSection(isWeb),
            _buildTestimonialsSection(isWeb),
            _buildAIChatSection(isWeb),
            _buildFooterSection(isWeb),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 1. HERO BÖLÜMÜ
  // ==========================================
  Widget _buildHeroSection(BuildContext context, bool isWeb) {
    return Container(
      height: isWeb ? MediaQuery.of(context).size.height : null,
      constraints: isWeb ? const BoxConstraints(minHeight: 700) : null,
      decoration: BoxDecoration(
        color: primaryDark,
        image: DecorationImage(
          image: const AssetImage('assets/images/turkiye_haritasi_bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            primaryDark.withOpacity(0.3),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildTopBar(isWeb),
          if (isWeb)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TÜRKİYE\'Yİ\nAKILLICA KEŞFET',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '81 şehir, 2.400+ tarihi mekan, QR destekli rehberlik\nve yapay zeka ile kişiselleştirilmiş gezi deneyimi.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              _buildStatItem('81', 'Şehir'),
                              const SizedBox(width: 40),
                              _buildStatItem('2.4K+', 'Mekan'),
                              const SizedBox(width: 40),
                              _buildStatItem('6', 'Dil'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: _buildLoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            _buildMobileHeroContent(),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool isWeb) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.explore, color: accentGold, size: 36),
              const SizedBox(width: 12),
              const Text(
                'Travix',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              if (isWeb) ...[
                const SizedBox(width: 40),
                _navLink('Özellikler', Colors.white),
                _navLink('Nasıl Çalışır?', Colors.white),
                _navLink('Hakkımızda', Colors.white),
                const SizedBox(width: 20),
                _buildLangSelector(Colors.white),
              ],
            ],
          ),
          if (isWeb)
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Kayıt Ol'),
                ),
              ],
            )
          else
            const Icon(Icons.menu, color: Colors.white, size: 32),
        ],
      ),
    );
  }

  Widget _buildMobileHeroContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Türkiye\'yi\nAkıllıca Keşfet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '81 şehir, 2.400+ tarihi mekan ve yapay zeka ile kişiselleştirilmiş gezi deneyimi.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: _buildLoginForm(),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ==========================================
  // 2. ÖZELLİKLER BÖLÜMÜ
  // ==========================================
  Widget _buildFeaturesSection(bool isWeb) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 80 : 24, vertical: 80),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Neden Travix?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Turizmi yeniden tanımlayan özellikler',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureCard(
                Icons.qr_code_scanner,
                'Akıllı QR Rehber',
                'Her tarihi mekanda QR kodu okutun, anında detaylı tarihçe ve bilgiye ulaşın.',
                isWeb,
              ),
              _buildFeatureCard(
                Icons.map_outlined,
                'GPS Tabanlı Sıralama',
                'Bulunduğunuz konuma göre en yakın mekanlar otomatik olarak üste listelenir.',
                isWeb,
              ),
              _buildFeatureCard(
                Icons.language,
                '6 Dil Desteği',
                'TR, EN, DE, AR, FR, RU dillerinde otomatik içerik çevirisi ile dil engeli kalkar.',
                isWeb,
              ),
              _buildFeatureCard(
                Icons.smart_toy_outlined,
                'Yapay Zeka Asistanı',
                'Kişisel gezi planı oluşturun, öneriler alın ve sorularınızı AI\'a sorun.',
                isWeb,
              ),
              _buildFeatureCard(
                Icons.devices,
                'Web & Mobil',
                'Tek hesapla web tarayıcısı ve mobil uygulama üzerinden kesintisiz erişim.',
                isWeb,
              ),
              _buildFeatureCard(
                Icons.favorite_border,
                'Favori & Planlama',
                'Beğendiğiniz mekanları favorileyin, kişisel gezi rotanızı oluşturun.',
                isWeb,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String desc,
    bool isWeb,
  ) {
    return Container(
      width: isWeb ? 350 : double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryDark, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 3. NASIL ÇALIŞIR BÖLÜMÜ
  // ==========================================
  Widget _buildHowItWorksSection(bool isWeb) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 80 : 24, vertical: 80),
      color: bgLight,
      child: Column(
        children: [
          Text(
            'Nasıl Çalışır?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '3 adımda keşfetmeye başla',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 60),
          isWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStep(
                      1,
                      'Kayıt Ol',
                      'E-posta, Google veya telefonla hemen hesap oluştur.',
                      isWeb,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    _buildStep(
                      2,
                      'Şehir Seç',
                      '81 il arasından seçim yap veya mekanları bul.',
                      isWeb,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    _buildStep(
                      3,
                      'QR Okut & Keşfet',
                      'Mekandaki QR kodu okut ve kendi dilinde oku.',
                      isWeb,
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildStep(
                      1,
                      'Kayıt Ol',
                      'E-posta, Google veya telefonla hemen hesap oluştur.',
                      isWeb,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Icon(Icons.arrow_downward, color: Colors.grey),
                    ),
                    _buildStep(
                      2,
                      'Şehir Seç',
                      '81 il arasından seçim yap veya mekanları bul.',
                      isWeb,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Icon(Icons.arrow_downward, color: Colors.grey),
                    ),
                    _buildStep(
                      3,
                      'QR Okut & Keşfet',
                      'Mekandaki QR kodu okut ve kendi dilinde oku.',
                      isWeb,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, String desc, bool isWeb) {
    Widget stepContent = Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: primaryDark, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          desc,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    return isWeb ? Expanded(child: stepContent) : stepContent;
  }

  // ==========================================
  // 4. MÜŞTERİ YORUMLARI BÖLÜMÜ
  // ==========================================
  Widget _buildTestimonialsSection(bool isWeb) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 80 : 24, vertical: 80),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Kullanıcılar Ne Diyor?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildTestimonialCard(
                '"İstanbul\'u gezerken QR sistemi inanılmaz işe yaradı. Her mekanın hikayesini anında öğrendim."',
                'Ayşe Y.',
                'İstanbul',
                primaryDark,
                isWeb,
              ),
              _buildTestimonialCard(
                '"Almanca dil desteği mükemmel. Türkiye\'yi gezerken hiç dil sorunu yaşamadım."',
                'Hans M.',
                'Berlin, Almanya',
                Colors.green.shade800,
                isWeb,
              ),
              _buildTestimonialCard(
                '"GPS sıralaması sayesinde Kapadokya\'da en yakın mekanları önce gezdim. Harika bir uygulama!"',
                'Mehmet K.',
                'Ankara',
                accentGold.withOpacity(0.8),
                isWeb,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
    String quote,
    String name,
    String location,
    Color color,
    bool isWeb,
  ) {
    return Container(
      width: isWeb ? 350 : double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, color: Colors.orange, size: 20),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            quote,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 24,
                child: Text(
                  name.substring(0, 2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. YAPAY ZEKA ASİSTANI BÖLÜMÜ
  // ==========================================
  Widget _buildAIChatSection(bool isWeb) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 80 : 24, vertical: 80),
      color: bgLight,
      child: Center(
        child: Container(
          width: isWeb ? 800 : double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: primaryDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.smart_toy, color: Color(0xFF0F2C59)),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Travix Yapay Zeka Asistanı',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Çevrimiçi — size yardımcı olmaya hazır',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildChatBubble(
                      'Merhaba! Ben Travix AI asistanınım. Türkiye\'deki gezi planınızda size yardımcı olabilirim. Ne keşfetmek istersiniz?',
                      true,
                    ),
                    const SizedBox(height: 16),
                    _buildChatBubble(
                      'İstanbul\'da 2 günlük bir rota oluşturabilir misin?',
                      false,
                    ),
                    const SizedBox(height: 16),
                    _buildChatBubble(
                      'Tabii! İstanbul için 2 günlük önerim: 1. gün Tarihi Yarımada (Ayasofya, Topkapı, Kapalıçarşı), 2. gün Boğaz turu ve Beşiktaş. Detaylı rota oluşturayım mı?',
                      true,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildChatChip('Evet, rota oluştur'),
                        _buildChatChip('Müzeler'),
                        if (isWeb) _buildChatChip('Restoranlar'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isBot) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isBot ? bgLight : primaryDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isBot ? 0 : 16),
            bottomRight: Radius.circular(isBot ? 16 : 0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isBot ? textDark : Colors.white,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildChatChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textDark,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ==========================================
  // 6. FOOTER (Alt Bilgi Bölümü)
  // ==========================================
  Widget _buildFooterSection(bool isWeb) {
    return Container(
      width: double.infinity,
      color: primaryDark,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 80 : 24,
              vertical: 60,
            ),
            child: isWeb
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildFooterBrandInfo()),
                      Expanded(
                        child: _buildFooterLinks('Ürün', [
                          'Özellikler',
                          'Nasıl Çalışır?',
                          'Fiyatlandırma',
                          'Güncellemeler',
                        ]),
                      ),
                      Expanded(
                        child: _buildFooterLinks('Şirket', [
                          'Hakkımızda',
                          'Blog',
                          'Kariyer',
                          'İletişim',
                        ]),
                      ),
                      Expanded(
                        child: _buildFooterLinks('Destek', [
                          'Yardım Merkezi',
                          'Gizlilik Politikası',
                          'Kullanım Şartları',
                          'KVKK',
                        ]),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterBrandInfo(),
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildFooterLinks('Ürün', [
                              'Özellikler',
                              'Nasıl Çalışır?',
                              'Fiyatlandırma',
                            ]),
                          ),
                          Expanded(
                            child: _buildFooterLinks('Şirket', [
                              'Hakkımızda',
                              'Blog',
                              'İletişim',
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _buildFooterLinks('Destek', [
                        'Yardım Merkezi',
                        'Gizlilik Politikası',
                        'KVKK',
                      ]),
                    ],
                  ),
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 80 : 24,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2026 Travix. Tüm hakları saklıdır.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
                if (isWeb)
                  Row(
                    children: [
                      _buildFooterBadge('SSL Güvenli'),
                      const SizedBox(width: 10),
                      _buildFooterBadge('KVKK Uyumlu'),
                      const SizedBox(width: 10),
                      _buildFooterBadge('v1.0.0'),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.explore, color: accentGold, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Travix',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Türkiye\'nin akıllı turizm platformu. 81 şehir, binlerce mekan, yapay zeka destekli rehberlik.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.business),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // ==========================================
  // GİRİŞ FORMU (MOTOR BAĞLANTISI YAPILDI)
  // ==========================================
  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Giriş Yap',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryDark,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // KONTROLCÜLER EKLENDİ
        _buildTextField(
          Icons.mail_outline,
          'E-posta adresi',
          false,
          _emailController,
        ),
        const SizedBox(height: 16),
        _buildTextField(Icons.lock_outline, 'Şifre', true, _passwordController),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Şifremi Unuttum?',
            style: TextStyle(
              color: accentGold,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // BUTON ARTIK GERÇEK BİR İŞLEM YAPIYOR
        ElevatedButton(
          onPressed: () async {
            // E-posta ve şifre kutularındaki yazıyı alıp Firebase'e yolluyoruz
            final email = _emailController.text.trim();
            final password = _passwordController.text.trim();

            if (email.isNotEmpty && password.isNotEmpty) {
              final user = await _authService.signInWithEmail(email, password);
              if (user != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Başarıyla Giriş Yapıldı! 🎉'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Giriş başarısız. Bilgilerinizi kontrol edin.',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDark,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Giriş Yap',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'veya',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildSocialBtn(Icons.g_mobiledata, 'Google', Colors.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialBtn(Icons.apple, 'Apple', Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Hesabınız Yok mu? ',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              children: [
                TextSpan(
                  text: 'Hemen Üye Ol.',
                  style: TextStyle(
                    color: primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Fonksiyona controller parametresi eklendi
  Widget _buildTextField(
    IconData icon,
    String hint,
    bool isPassword,
    TextEditingController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller, // Yazılanları hafızaya alan kısım
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          prefixIcon: Icon(icon, color: primaryDark.withOpacity(0.7)),
          suffixIcon: isPassword
              ? Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey.shade400,
                  size: 20,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSocialBtn(IconData icon, String label, Color iconColor) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: iconColor, size: 24),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _navLink(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLangSelector(Color color) {
    return Row(
      children: [
        Icon(Icons.language, color: color, size: 20),
        const SizedBox(width: 6),
        Text(
          'TR',
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(Icons.keyboard_arrow_down, color: color, size: 20),
      ],
    );
  }

  Widget _buildStatItem(String val, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          val,
          style: TextStyle(
            color: accentGold,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _buildCustomerSupportButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: primaryDark,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: accentGold.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: primaryDark.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.support_agent, color: accentGold, size: 28),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Representative',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                'Temsilciyle Sohbet',
                style: TextStyle(color: accentGold, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
