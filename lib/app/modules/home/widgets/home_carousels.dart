import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  static const bool _useApiBanners = false;
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  int _index = 0;

  static const _fallbackBanners = <String>[
    'assets/images/banners/bannar_update_1.png',
    'assets/images/banners/bannar_update_2.png',
    'assets/images/banners/Third.png',
  ];

  List<String> _apiBanners = <String>[];

  List<String> get _banners =>
      _apiBanners.isNotEmpty ? _apiBanners : _fallbackBanners;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (_useApiBanners) {
      _fetchBanners();
    }

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final total = _banners.length;
      if (total <= 1) return;

      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return '${AppApiService.baseUrl}$value';
  }

  Future<void> _fetchBanners() async {
    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      EasyLoading.showError('Please login again.');
      return;
    }

    EasyLoading.show(status: 'Loading banners...');

    try {
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-one/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          EasyLoading.showError('Invalid slider response.');
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          EasyLoading.showError('Invalid slider data.');
          return;
        }

        final List<String> urls = results
            .whereType<Map<String, dynamic>>()
            .map((item) => _resolveImageUrl((item['image'] ?? '').toString()))
            .where((url) => url.isNotEmpty)
            .toList();

        if (!mounted) return;

        if (urls.isNotEmpty) {
          setState(() {
            _apiBanners = urls;
            _index = 0;
          });

          if (_controller.hasClients) {
            _controller.jumpToPage(0);
          }
        }
        return;
      }

      EasyLoading.showError('Banner load failed. Please try again.');
    } catch (_) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      EasyLoading.showError(
          'Banner load failed. Check internet and try again.');
    }
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
                final source = _banners[i];
                final isNetwork = source.startsWith('http://') ||
                    source.startsWith('https://');

                if (isNetwork) {
                  return Image.network(
                    source,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    cacheWidth: bannerWidthPx,
                    cacheHeight: bannerHeightPx,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        _fallbackBanners[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        cacheWidth: bannerWidthPx,
                        cacheHeight: bannerHeightPx,
                      );
                    },
                  );
                }

                return Image.asset(
                  source,
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
  static const bool _useApiBanners = false;
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  int _index = 0;

  static const _fallbackBanners = <String>[
    'assets/images/banners/promo1.png',
    'assets/images/banners/promo2.png',
    'assets/images/banners/promo3.png',
  ];

  List<String> _apiBanners = <String>[];

  List<String> get _banners =>
      _apiBanners.isNotEmpty ? _apiBanners : _fallbackBanners;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (_useApiBanners) {
      _fetchBanners();
    }

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final total = _banners.length;
      if (total <= 1) return;

      final next = (_index + 1) % total;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }

  Future<void> _fetchBanners() async {
    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      EasyLoading.showError('Please login again.');
      return;
    }

    EasyLoading.show(status: 'Loading banners...');

    try {
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-two/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          EasyLoading.showError('Invalid slider response.');
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          EasyLoading.showError('Invalid slider data.');
          return;
        }

        final List<String> urls = results
            .whereType<Map<String, dynamic>>()
            .map((item) => _resolveImageUrl((item['image'] ?? '').toString()))
            .where((url) => url.isNotEmpty)
            .toList();

        if (!mounted) return;

        if (urls.isNotEmpty) {
          setState(() {
            _apiBanners = urls;
            _index = 0;
          });

          if (_controller.hasClients) {
            _controller.jumpToPage(0);
          }

          _startAutoSlide();
        }
        return;
      }

      EasyLoading.showError('Banner load failed. Please try again.');
    } catch (_) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      EasyLoading.showError(
          'Banner load failed. Check internet and try again.');
    }
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
                final source = _banners[i];
                final isNetwork = source.startsWith('http://') ||
                    source.startsWith('https://');

                if (isNetwork) {
                  return Image.network(
                    source,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    cacheWidth: bannerWidthPx,
                    cacheHeight: bannerHeightPx,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        _fallbackBanners[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        cacheWidth: bannerWidthPx,
                        cacheHeight: bannerHeightPx,
                      );
                    },
                  );
                }

                return Image.asset(
                  source,
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
