import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

// background parser for banners — top-level and sendable to `compute`
List<dynamic> _extractBannerResults(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) return const [];
    final results = decoded['results'];
    if (results is List) return results;
    return const [];
  } catch (_) {
    return const [];
  }
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  // When false, the carousel will use the bundled local banner images
  // so the first slider is available immediately on app start.
  static const bool _useApiBanners = false;
  static const List<String> _localBanners = <String>[
    'assets/images/banners/banner1.png',
    'assets/images/banners/bannar_update_1.png',
    'assets/images/banners/bannar_update_2.png',
  ];
  static const Duration _pollInterval = Duration(seconds: 4);
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  Timer? _pollTimer;
  int _index = 0;
  bool _isFetching = false;
  bool _isInitialLoading = true;
  bool _hasError = false;
  List<String> _apiBanners = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (_useApiBanners) {
      _fetchBanners(showLoading: true, showErrors: true);
      _startPolling();
    } else {
      // Use local bundled banners so UI shows immediately.
      _apiBanners = List<String>.from(_localBanners);
      _isInitialLoading = false;
      _hasError = false;
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
      final total = _apiBanners.length;
      if (total <= 1) return;

      final next = (_index + 1) % _apiBanners.length;
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
    if (showLoading && mounted) {
      setState(() {
        _isInitialLoading = true;
        _hasError = false;
      });
    }

    try {
      debugPrint(
        'SliderOne => GET ${AppApiService.baseUrl}/api/v1/slider/slider-one/',
      );
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-one/',
      );

      debugPrint('SliderOne => status: ${response.statusCode}');
      debugPrint('SliderOne => body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final results = await compute(_extractBannerResults, response.body);
        if (results is! List || results.isEmpty) {
          if (showErrors && mounted) {
            setState(() {
              _isInitialLoading = false;
              _hasError = true;
            });
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
              _isInitialLoading = false;
              _hasError = false;
            });

            if (_controller.hasClients) {
              _controller.jumpToPage(0);
            }
          } else if (_isInitialLoading) {
            setState(() {
              _isInitialLoading = false;
              _hasError = false;
            });
          }
        } else if (showErrors && mounted) {
          setState(() {
            _isInitialLoading = false;
            _hasError = true;
          });
        }
        _isFetching = false;
        return;
      }
      if (showErrors && mounted) {
        setState(() {
          _isInitialLoading = false;
          _hasError = true;
        });
      }
    } catch (e, st) {
      debugPrint('SliderOne => exception: $e');
      debugPrint('SliderOne => stacktrace: $st');
      if (showErrors && mounted) {
        setState(() {
          _isInitialLoading = false;
          _hasError = true;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

// NOTE: _extractBannerResults moved to top-level below to be
// sendable to `compute()` without capturing `this`.

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
    final hasBanners = _apiBanners.isNotEmpty;
    return Column(
      children: [
        SizedBox(
          height: 165,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isInitialLoading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : hasBanners
                      ? PageView.builder(
                          key: const ValueKey('slider-one'),
                          controller: _controller,
                          itemCount: _apiBanners.length,
                          onPageChanged: (i) => setState(() => _index = i),
                          itemBuilder: (_, i) {
                            final source = _apiBanners[i];
                            final isNetwork = source.startsWith('http://') ||
                                source.startsWith('https://');

                            if (isNetwork) {
                              return Image.network(
                                source,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                cacheWidth: bannerWidthPx,
                                cacheHeight: bannerHeightPx,
                                frameBuilder: (context, child, frame, _) {
                                  final visible = frame != null;
                                  return AnimatedOpacity(
                                    duration: const Duration(milliseconds: 250),
                                    opacity: visible ? 1 : 0,
                                    child: child,
                                  );
                                },
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) {
                                  return const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.black38,
                                    ),
                                  );
                                },
                              );
                            }

                            // Treat as local asset
                            return Image.asset(
                              source,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              frameBuilder: (context, child, frame, _) {
                                final visible = frame != null;
                                return AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  opacity: visible ? 1 : 0,
                                  child: child,
                                );
                              },
                              errorBuilder: (_, __, ___) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.black38,
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          key: const ValueKey('slider-one-empty'),
                          child: Text(
                            _hasError
                                ? 'Banners unavailable'
                                : 'No banners found',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (hasBanners)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_apiBanners.length, (i) {
              final active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 16 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF6B6B6B)
                      : const Color(0xFFBDBDBD),
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
  static const Duration _pollInterval = Duration(seconds: 4);
  late final PageController _controller;
  final AppApiService _apiService = AppApiService();
  Timer? _timer;
  Timer? _pollTimer;
  int _index = 0;
  bool _isFetching = false;
  bool _isInitialLoading = true;
  bool _hasError = false;
  List<String> _apiBanners = <String>[];

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
      final total = _apiBanners.length;
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

    debugPrint('SliderTwo => start fetch');
    if (showLoading && mounted) {
      setState(() {
        _isInitialLoading = true;
        _hasError = false;
      });
    }

    try {
      debugPrint(
        'SliderTwo => GET ${AppApiService.baseUrl}/api/v1/slider/slider-two/',
      );
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-two/',
      );

      debugPrint('SliderTwo => status: ${response.statusCode}');
      debugPrint('SliderTwo => body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          if (showErrors && mounted) {
            setState(() {
              _isInitialLoading = false;
              _hasError = true;
            });
          }
          _isFetching = false;
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          if (showErrors && mounted) {
            setState(() {
              _isInitialLoading = false;
              _hasError = true;
            });
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
              _isInitialLoading = false;
              _hasError = false;
            });

            if (_controller.hasClients) {
              _controller.jumpToPage(0);
            }
          } else if (_isInitialLoading) {
            setState(() {
              _isInitialLoading = false;
              _hasError = false;
            });
          }
        } else {
          if (showErrors && mounted) {
            setState(() {
              _isInitialLoading = false;
              _hasError = true;
            });
          }
          debugPrint('SliderTwo => no valid image URL in response');
        }
        _isFetching = false;
        return;
      }
      if (showErrors && mounted) {
        setState(() {
          _isInitialLoading = false;
          _hasError = true;
        });
      }
      debugPrint('SliderTwo => non-success status: ${response.statusCode}');
    } catch (e, st) {
      debugPrint('SliderTwo => exception: $e');
      debugPrint('SliderTwo => stacktrace: $st');
      if (showErrors && mounted) {
        setState(() {
          _isInitialLoading = false;
          _hasError = true;
        });
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
    final hasBanners = _apiBanners.isNotEmpty;
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isInitialLoading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : hasBanners
                      ? PageView.builder(
                          key: const ValueKey('slider-two'),
                          controller: _controller,
                          itemCount: _apiBanners.length,
                          onPageChanged: (i) => setState(() => _index = i),
                          itemBuilder: (_, i) {
                            final source = _apiBanners[i];
                            return Image.network(
                              source,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              cacheWidth: bannerWidthPx,
                              cacheHeight: bannerHeightPx,
                              frameBuilder: (context, child, frame, _) {
                                final visible = frame != null;
                                return AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  opacity: visible ? 1 : 0,
                                  child: child,
                                );
                              },
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (_, __, ___) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.black38,
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          key: const ValueKey('slider-two-empty'),
                          child: Text(
                            _hasError
                                ? 'Banners unavailable'
                                : 'No banners found',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (hasBanners)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_apiBanners.length, (i) {
              final active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 16 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF6B6B6B)
                      : const Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
      ],
    );
  }
}
