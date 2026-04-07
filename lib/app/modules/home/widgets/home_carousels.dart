import 'dart:async';
import 'package:flutter/material.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  static const _banners = <String>[
    'assets/images/banners/bannar_update_1.png',
    'assets/images/banners/bannar_update_2.png',
    'assets/images/banners/Third.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final bannerWidthPx =
        (MediaQuery.sizeOf(context).width * dpr).round().clamp(1, 4096);
    final bannerHeightPx = (165 * dpr).round().clamp(1, 4096);
    return Column(
      children: [
        SizedBox(
          height: 165,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                return Image.asset(
                  _banners[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  cacheWidth: bannerWidthPx,
                  cacheHeight: bannerHeightPx,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 16 : 7,
              height: 7,
              decoration: BoxDecoration(
                color:
                    active ? const Color(0xFF6B6B6B) : const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key});

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  static const _banners = <String>[
    'assets/images/banners/promo1.png',
    'assets/images/banners/promo2.png',
    'assets/images/banners/promo3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final bannerWidthPx =
        (MediaQuery.sizeOf(context).width * dpr).round().clamp(1, 4096);
    final bannerHeightPx = (150 * dpr).round().clamp(1, 4096);
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                return Image.asset(
                  _banners[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  cacheWidth: bannerWidthPx,
                  cacheHeight: bannerHeightPx,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 16 : 7,
              height: 7,
              decoration: BoxDecoration(
                color:
                    active ? const Color(0xFF6B6B6B) : const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
