import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PromoBannerItem {
  final String title;
  final String subtitle;
  final String badge;
  final String imagePath;
  final Color startColor;
  final Color endColor;

  const PromoBannerItem({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.imagePath,
    required this.startColor,
    required this.endColor,
  });
}

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key});

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<PromoBannerItem> _banners = const [
    PromoBannerItem(
      title: 'SUMMER DROP 2026',
      subtitle: 'Up to 25% OFF on New Arrivals',
      badge: 'LIMITED TIME',
      imagePath: 'lib/images/3.png',
      startColor: Color(0xFF1E1B4B),
      endColor: Color(0xFF4338CA),
    ),
    PromoBannerItem(
      title: 'ELITE AIR RUNNER',
      subtitle: 'Use code ELEGANCE10 for 10% off',
      badge: 'HOT DEAL',
      imagePath: 'lib/images/5.png',
      startColor: Color(0xFF831843),
      endColor: Color(0xFFBE185D),
    ),
    PromoBannerItem(
      title: 'STREET WEAR COLLECTION',
      subtitle: 'Comfort meets cutting-edge silhouette',
      badge: 'TRENDING',
      imagePath: 'lib/images/2.png',
      startColor: Color(0xFF0F172A),
      endColor: Color(0xFF334155),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [banner.startColor, banner.endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppShadows.cardMd,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Text Column
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 120, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              banner.badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner.subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Floating Shoe Image
                    Positioned(
                      right: 10,
                      top: 10,
                      bottom: 10,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: AppImage(
                          imagePath: banner.imagePath,
                          width: 140,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.secondary
                    : AppColors.textMutedLight.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
