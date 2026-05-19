import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // İsim çakışmasını önleyen güncel kontrol motoru
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imageUrls = widget.destination['imageUrls'] ?? [];
    final String title = widget.destination['title'] ?? 'Bilinmeyen Yer';
    final String city = widget.destination['city'] ?? 'Bilinmeyen Şehir';
    final String description =
        widget.destination['description'] ?? 'Tarihçe bilgisi bulunamadı.';

    // Yeni tasarım dilimizdeki ana yeşil tonu
    const Color primaryGreen = Color(0xFF32795B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. ÜST KISIM: KAYAN RESİM GALERİSİ (CAROUSEL)
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: primaryGreen,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: imageUrls.isNotEmpty
                  ? Stack(
                      children: [
                        // Otomatik ve manuel kayan resim motoru
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 450,
                            autoPlay: true,
                            viewportFraction: 1.0,
                            autoPlayInterval: const Duration(seconds: 5),
                            enlargeCenterPage: false,
                          ),
                          items: imageUrls.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                );
                              },
                            );
                          }).toList(),
                        ),

                        // SOL OK BUTONU (Manuel Geçiş)
                        if (imageUrls.length > 1)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: InkWell(
                                onTap: () => _carouselController.previousPage(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // SAĞ OK BUTONU (Manuel Geçiş)
                        if (imageUrls.length > 1)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: InkWell(
                                onTap: () => _carouselController.nextPage(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const Center(
                      child: Icon(
                        Icons.landscape,
                        size: 100,
                        color: Colors.white24,
                      ),
                    ),
            ),
          ),

          // 2. ALT KISIM: MEKAN ADI, ŞEHİR VE DETAYLI TARİHÇE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: primaryGreen,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                city,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Favorilere Ekleme Butonu (Premium UX)
                      CircleAvatar(
                        backgroundColor: const Color(0xFFE8F5E9),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: primaryGreen,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Tarihçe ve Hakkında',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Alt kısımdaki kaydırma rahatlığı için ekstra boşluk
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
