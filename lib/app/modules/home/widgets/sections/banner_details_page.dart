
import 'dart:convert';

import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
import 'package:bellevie/app/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerDetailPage extends StatefulWidget {
  final int bannerId;
  final String? initialImage;

  const BannerDetailPage({
    super.key,
    required this.bannerId,
    this.initialImage,
  });

  @override
  State<BannerDetailPage> createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
  final AppApiService _apiService = AppApiService();

  bool _isLoading = true;
  bool _hasError = false;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _fetchBannerDetail();
  }

  Future<void> _fetchBannerDetail() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final response = await _apiService.get(
        path: '/api/v1/slider/slider-one/${widget.bannerId}/',
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          if (!mounted) return;

          setState(() {
            _data = decoded;
            _isLoading = false;
            _hasError = false;
          });

          return;
        }
      }

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  String _text(dynamic value) {
    return (value ?? '').toString().trim();
  }

  String get _image {
    final apiImage = _text(_data?['image']);
    if (apiImage.isNotEmpty) return apiImage;

    return widget.initialImage ?? '';
  }

  String _localizedTitle(bool isBangla) {
    if (isBangla) {
      final bn = _text(_data?['title_bn']);
      if (bn.isNotEmpty) return bn;
    }
    final en = _text(_data?['title_en']);
    if (en.isNotEmpty) return en;
    final fallback = _text(_data?['title']);
    if (fallback.isNotEmpty) return fallback;
    if (!isBangla) {
      final bn = _text(_data?['title_bn']);
      if (bn.isNotEmpty) return bn;
    }
    return 'BelleVie Health Banner';
  }

  String _localizedDescription(bool isBangla) {
    if (isBangla) {
      final bn = _text(_data?['description_bn']);
      if (bn.isNotEmpty) return bn;
    }
    final en = _text(_data?['description_en']);
    if (en.isNotEmpty) return en;
    final fallback = _text(_data?['description']);
    if (fallback.isNotEmpty) return fallback;
    if (!isBangla) {
      final bn = _text(_data?['description_bn']);
      if (bn.isNotEmpty) return bn;
    }
    return 'Explore BelleVie health services, offers and latest updates.';
  }

  String _localizedAltText(bool isBangla) {
    if (isBangla) {
      final bn = _text(_data?['alt_text_bn']);
      if (bn.isNotEmpty) return bn;
    }
    final en = _text(_data?['alt_text_en']);
    if (en.isNotEmpty) return en;
    final fallback = _text(_data?['alt_text']);
    if (fallback.isNotEmpty) return fallback;
    if (!isBangla) {
      final bn = _text(_data?['alt_text_bn']);
      if (bn.isNotEmpty) return bn;
    }
    return '';
  }

  String get _createdAt {
    return _text(_data?['created_at']);
  }

  String get _link {
    return _text(_data?['link']);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    final image = _image;

    return Obx(() {
      final isBangla =
          homeController.currentLocale.value.languageCode == 'bn';
      final title = _localizedTitle(isBangla);
      final description = _localizedDescription(isBangla);
      final altText = _localizedAltText(isBangla);

      return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Banner Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : _hasError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 46,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Banner details unavailable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _fetchBannerDetail,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchBannerDetail,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: image.isEmpty
                              ? Container(
                                  height: 280,
                                  width: double.infinity,
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 44,
                                    color: Colors.black38,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: image,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Container(
                                    height: 220,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    height: 220,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 44,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .06),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1D1D1F),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.55,
                                  color: Color(0xFF555B66),
                                ),
                              ),
                              if (altText.isNotEmpty) ...[
                                const SizedBox(height: 14),
                                Text(
                                  altText,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                              if (_link.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F5FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _link,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF2454FF),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                              // if (_createdAt.isNotEmpty) ...[
                              //   const SizedBox(height: 16),
                              //   Row(
                              //     children: [
                              //       const Icon(
                              //         Icons.calendar_today_outlined,
                              //         size: 16,
                              //         color: Colors.black45,
                              //       ),
                              //       const SizedBox(width: 8),
                              //       Expanded(
                              //         child: Text(
                              //           _createdAt,
                              //           style: const TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.black45,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
    });
  }
}
