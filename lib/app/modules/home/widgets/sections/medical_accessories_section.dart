import 'dart:async';
import 'dart:convert';

import 'package:bellevie/app/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../routes/app_routes.dart';

class MedicalAccessoriesSection extends StatefulWidget {
  const MedicalAccessoriesSection({super.key});

  @override
  State<MedicalAccessoriesSection> createState() =>
      _MedicalAccessoriesSectionState();
}

class _MedicalAccessoriesSectionState extends State<MedicalAccessoriesSection> {
  static const String _cacheKey = 'medical_accessories_categories_cache_v1';
  final AppApiService _apiService = AppApiService();
  bool _isFetching = false;
  bool _isLoading = true;
  List<_MedicalAccessoryItem> _items = [];

  @override
  void initState() {
    super.initState();
    _restoreCachedCategories().then((hasCache) {
      _fetchCategories(showLoading: !hasCache);
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

  Future<void> _fetchCategories({bool showLoading = true}) async {
    if (_isFetching) return;
    _isFetching = true;
    if (showLoading && mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      debugPrint(
          'Medical categories => GET ${AppApiService.baseUrl}/api/v1/medical-accessories/categories/');
      final response = await _apiService.get(
          path: '/api/v1/medical-accessories/categories/');

      debugPrint('Medical categories => status: ${response.statusCode}');
      debugPrint('Medical categories => body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        debugPrint('Medical categories decoded => $decoded');

        if (decoded is! Map<String, dynamic>) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          _isFetching = false;
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          _isFetching = false;
          return;
        }

        final List<_MedicalAccessoryItem> items = results
            .whereType<Map<String, dynamic>>()
            .map((m) => _MedicalAccessoryItem(
                  (m['name'] ?? '').toString(),
                  _resolveImageUrl((m['image'] ?? '').toString()),
                ))
            .where((it) => it.name.isNotEmpty)
            .toList();

        if (!mounted) return;

        setState(() {
          _items = items;
          _isLoading = false;
        });
        await _saveCachedCategories(items);
        _isFetching = false;
        return;
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Categories fetch error => $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<bool> _restoreCachedCategories() async {
    final cached = await _loadCachedCategories();
    if (!mounted || cached.isEmpty) return false;
    setState(() {
      _items = cached;
      _isLoading = false;
    });
    return true;
  }

  Future<List<_MedicalAccessoryItem>> _loadCachedCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      if (cachedJson == null || cachedJson.isEmpty) return [];

      final decoded = jsonDecode(cachedJson);
      if (decoded is! List) return [];

      return decoded
          .whereType<Map<String, dynamic>>()
          .map((m) => _MedicalAccessoryItem(
                (m['name'] ?? '').toString(),
                (m['imageUrl'] ?? '').toString(),
              ))
          .where((it) => it.name.isNotEmpty)
          .toList();
    } catch (e) {
      debugPrint('Medical accessories cache read error => $e');
      return [];
    }
  }

  Future<void> _saveCachedCategories(List<_MedicalAccessoryItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(items
          .map((e) => {
                'name': e.name,
                'imageUrl': e.imageUrl,
              })
          .toList());
      await prefs.setString(_cacheKey, encoded);
    } catch (e) {
      debugPrint('Medical accessories cache write error => $e');
    }
  }

  void _showComingSoon() {
    Get.toNamed(Routes.COMING_SOON);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'medical_accessories'.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _showComingSoon,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFF2F6FED),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _isLoading && _items.isEmpty
            ? const SizedBox(
                height: 120,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : _items.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No categories found',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, i) {
                      final item = _items[i];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: _showComingSoon,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 44,
                              width: 44,
                              child: item.imageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: item.imageUrl,
                                      fit: BoxFit.contain,
                                      errorWidget: (_, __, ___) =>
                                          const Icon(Icons.image_not_supported),
                                    )
                                  : const Icon(Icons.image_not_supported),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                height: 1.2,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ],
    );
  }
}

class _MedicalAccessoryItem {
  final String name;
  final String imageUrl;
  _MedicalAccessoryItem(this.name, this.imageUrl);
}
