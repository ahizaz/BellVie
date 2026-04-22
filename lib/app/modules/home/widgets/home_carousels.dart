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
  static const bool _useApiBanners = true;
  static const Duration _pollInterval = Duration(seconds: 5);
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  Timer? _pollTimer;
  int _index = 0;
  bool _isFetching = false;

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
      _fetchBanners(showLoading: true, showErrors: true);
      _startPolling();
    }

    _startAutoSlide();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      _fetchBanners(showLoading: false, showErrors: false);
    });
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

  Future<void> _fetchBanners({
    required bool showLoading,
    required bool showErrors,
  }) async {
    if (_isFetching) return;
    _isFetching = true;

    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      _isFetching = false;
      if (showErrors) {
        EasyLoading.showError('Please login again.');
      }
      return;
    }

    if (showLoading) {
      EasyLoading.show(status: 'Loading banners...');
    }

    try {
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-one/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          if (showErrors) {
            EasyLoading.showError('Invalid slider response.');
          }
          _isFetching = false;
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          if (showErrors) {
            EasyLoading.showError('Invalid slider data.');
          }
          _isFetching = false;
          return;
        }

        final List<String> urls = results
            .whereType<Map<String, dynamic>>()
            .map((item) => _resolveImageUrl((item['image'] ?? '').toString()))
            .where((url) => url.isNotEmpty)
            .toList();

        if (!mounted) return;

        if (urls.isNotEmpty) {
          final isDifferent = _apiBanners.length != urls.length ||
              _apiBanners.asMap().entries.any((e) => urls[e.key] != e.value);

          if (isDifferent) {
            setState(() {
              _apiBanners = urls;
              _index = 0;
            });

            if (_controller.hasClients) {
              _controller.jumpToPage(0);
            }
          }
        }
        _isFetching = false;
        return;
      }

      if (showErrors) {
        EasyLoading.showError('Banner load failed. Please try again.');
      }
    } catch (_) {
      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      if (showErrors) {
        EasyLoading.showError(
            'Banner load failed. Check internet and try again.');
      }
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pollTimer?.cancel();
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
  static const bool _useApiBanners = true;
  static const Duration _pollInterval = Duration(seconds: 5);
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  Timer? _pollTimer;
  int _index = 0;
  bool _isFetching = false;

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
      _fetchBanners(showLoading: true, showErrors: true);
      _startPolling();
    }

    _startAutoSlide();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      _fetchBanners(showLoading: false, showErrors: false);
    });
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

  Future<void> _fetchBanners({
    required bool showLoading,
    required bool showErrors,
  }) async {
    if (_isFetching) return;
    _isFetching = true;

    final token = AuthService.to.accessToken.value.trim();
    debugPrint(
      'SliderTwo => start fetch, hasToken: ${token.isNotEmpty}, tokenLength: ${token.length}',
    );

    if (token.isEmpty) {
      _isFetching = false;
      if (showErrors) {
        EasyLoading.showError('Please login again.');
      }
      debugPrint('SliderTwo => access token missing');
      return;
    }

    if (showLoading) {
      EasyLoading.show(status: 'Loading banners...');
    }

    try {
      debugPrint(
        'SliderTwo => GET ${AppApiService.baseUrl}/api/v1/slider/slider-two/',
      );
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-two/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('SliderTwo => status: ${response.statusCode}');
      debugPrint('SliderTwo => body: ${response.body}');

      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          if (showErrors) {
            EasyLoading.showError('Invalid slider response.');
          }
          _isFetching = false;
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          if (showErrors) {
            EasyLoading.showError('Invalid slider data.');
          }
          debugPrint(
              'SliderTwo => invalid results type: ${results.runtimeType}');
          _isFetching = false;
          return;
        }

        debugPrint('SliderTwo => results count: ${results.length}');

        final List<String> urls = results
            .whereType<Map<String, dynamic>>()
            .map((item) => _resolveImageUrl((item['image'] ?? '').toString()))
            .where((url) => url.isNotEmpty)
            .toList();

        debugPrint('SliderTwo => parsed image urls count: ${urls.length}');
        if (urls.isNotEmpty) {
          debugPrint('SliderTwo => first image: ${urls.first}');
        }

        if (!mounted) return;

        if (urls.isNotEmpty) {
          final isDifferent = _apiBanners.length != urls.length ||
              _apiBanners.asMap().entries.any((e) => urls[e.key] != e.value);

          if (isDifferent) {
            setState(() {
              _apiBanners = urls;
              _index = 0;
            });

            if (_controller.hasClients) {
              _controller.jumpToPage(0);
            }
          }
        } else {
          if (showErrors) {
            EasyLoading.showError('No slider image found.');
          }
          debugPrint('SliderTwo => no valid image URL in response');
        }
        _isFetching = false;
        return;
      }

      if (showErrors) {
        EasyLoading.showError('Banner load failed. Please try again.');
      }
      debugPrint('SliderTwo => non-success status: ${response.statusCode}');
    } catch (e, st) {
      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('SliderTwo => exception: $e');
      debugPrint('SliderTwo => stacktrace: $st');
      if (showErrors) {
        EasyLoading.showError(
            'Banner load failed. Check internet and try again.');
      }
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pollTimer?.cancel();
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
