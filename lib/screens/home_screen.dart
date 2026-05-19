import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // === DİL DESTEĞİ İÇİN AYARLAR ===
  final List<Map<String, String>> _languages = [
    {'code': 'tr', 'name': 'Türkçe', 'flag': '🇹🇷'},
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
  ];
  
  String _selectedLanguageCode = 'tr'; // Varsayılan dil Türkçe

  void _handleLogout(BuildContext context) async {
    await AuthService().signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Oturumu Kapat', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Vazgeç')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _handleLogout(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive (Duyarlı) Ekran Kontrolü
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 800;

    // === YENİ VE UYUMLU RENK PALETİ ===
    const Color primaryBlue = Color(0xFF007BFF); // İkonlar ve butonlar için ana mavi
    const Color lightBlueBg = Color(0xFFE3F2FD); // Üst menü (AppBar) için ferah açık mavi
    const Color bgGray = Color(0xFFF5F7FA); // Genel arkaplan grisi

    return Scaffold(
      backgroundColor: bgGray,
      
      // ==========================================
      // 1. ÜST MENÜ (APPBAR) - AÇIK MAVİ VE DİL SEÇENEĞİ
      // ==========================================
      appBar: AppBar(
        backgroundColor: lightBlueBg, // O yeşil renk kalktı, açık mavi geldi!
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            const Icon(Icons.travel_explore, color: primaryBlue, size: 36),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Travix', // Tek X amiral gemisi
                  style: TextStyle(color: Color(0xFF1E293B), fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
                Text('Türkiye Rehberi', style: TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ],
        ),
        actions: [
          if (isWeb) ...[
            TextButton(onPressed: () {}, child: const Text('Ana Sayfa', style: TextStyle(color: Colors.black87))),
            TextButton(onPressed: () {}, child: const Text('Şehirler', style: TextStyle(color: Colors.black87))),
            TextButton(onPressed: () {}, child: const Text('QR Tara', style: TextStyle(color: Colors.black87))),
            const SizedBox(width: 20),
          ],
          
          // DİL SEÇİCİ (Dropdown)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: _selectedLanguageCode,
              icon: const Icon(Icons.language, color: primaryBlue),
              underline: Container(), 
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguageCode = newValue;
                  });
                }
              },
              items: _languages.map<DropdownMenuItem<String>>((Map<String, String> lang) {
                return DropdownMenuItem<String>(
                  value: lang['code'],
                  child: Row(
                    children: [
                      Text(lang['flag']!, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(lang['name']!, style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => _showLogoutDialog(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: primaryBlue),
              ),
            ),
          ),
        ],
      ),

      // ==========================================
      // 2. ANA İÇERİK VE DOĞRU RESİM ALANI
      // ==========================================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // --- BÜYÜK KARŞILAMA ALANI (HERO SECTION) ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? screenWidth * 0.15 : 24.0, 
                vertical: isWeb ? 120.0 : 80.0, // Resim sıkışmasın diye genişletildi
              ),
              decoration: BoxDecoration(
                color: lightBlueBg, // Resim yüklenene kadar arkada duracak renk
                borderRadius: isWeb 
                    ? const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                    : const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                
                // === İŞTE DOĞRU RESİM BURADA ===
                image: const DecorationImage(
                  image: AssetImage('assets/images/kesfet_plaj_arkaplan.png'), 
                  fit: BoxFit.cover, // Resmin alana tam sığmasını sağlar
                  colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken), // Üstündeki beyaz yazılar okunsun diye hafif karartma
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nereyi keşfetmek\nistersiniz?',
                    style: TextStyle(
                      fontSize: isWeb ? 56 : 38,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      shadows: const [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 5))],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '81 il, binlerce mekan parmaklarınızın ucunda',
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 5, offset: Offset(0, 2))]
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // ARAMA ÇUBUĞU
                  Container(
                    width: isWeb ? 600 : double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Şehir veya mekan ara...',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: primaryBlue),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- FİREBASE KARTLARI ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? screenWidth * 0.1 : 24.0,
                vertical: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Öne Çıkan Mekanlar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('destinations').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: primaryBlue));
                      final destinations = snapshot.data!.docs;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: isWeb ? 0.8 : 1.1,
                        ),
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          var doc = destinations[index].data() as Map<String, dynamic>;
                          String title = doc['title'] ?? 'Bilinmeyen Yer';
                          String city = doc['city'] ?? 'Şehir';
                          List<dynamic> imageUrls = doc['imageUrls'] ?? [];
                          String vitrinResmi = imageUrls.isNotEmpty ? imageUrls[0] : '';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(destination: doc)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                        image: vitrinResmi.isNotEmpty
                                            ? DecorationImage(image: NetworkImage(vitrinResmi), fit: BoxFit.cover)
                                            : const DecorationImage(image: AssetImage('assets/images/placeholder.png'), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on, color: primaryBlue, size: 16),
                                              const SizedBox(width: 4),
                                              Text(city, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ==========================================
      // 3. SABİT DESTEK BUTONU
      // ==========================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Müşteri hizmetlerine bağlanılıyor...');
        },
        backgroundColor: primaryBlue,
        elevation: 6,
        child: const Icon(Icons.support_agent, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}