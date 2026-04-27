import 'dart:async';
import 'dart:convert';

import 'package:bellevie/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';


class MedicalAccessoriesSection extends StatefulWidget {
  const MedicalAccessoriesSection({super.key});

  @override
  State<MedicalAccessoriesSection> createState() =>
      _MedicalAccessoriesSectionState();
}

class _MedicalAccessoriesSectionState extends State<MedicalAccessoriesSection> {
  final AppApiService _apiService = AppApiService();
  bool _isFetching = false;
  List<_MedicalAccessoryItem> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return '${AppApiService.baseUrl}$value';
  }

  Future<void> _fetchCategories() async {
    if (_isFetching) return;
    _isFetching = true;
    EasyLoading.show(status: 'Loading categories...');

    try {
      final response = await _apiService.get(
          path: '/api/v1/medical-accessories/categories/');

      if (EasyLoading.isShow) EasyLoading.dismiss();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic decoded = jsonDecode(response.body);
        debugPrint('Medical categories decoded => $decoded');

        if (decoded is! Map<String, dynamic>) {
          EasyLoading.showError('Invalid categories response.');
          _isFetching = false;
          return;
        }

        final dynamic results = decoded['results'];
        if (results is! List) {
          EasyLoading.showError('Invalid categories data.');
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
        });
        _isFetching = false;
        return;
      }

      EasyLoading.showError('Failed to load categories.');
    } catch (e) {
      if (EasyLoading.isShow) EasyLoading.dismiss();
      EasyLoading.showError('Categories load failed.');
      debugPrint('Categories fetch error => $e');
    } finally {
      _isFetching = false;
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
        Text(
          'medical_accessories'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.0,
            ),
            itemBuilder: (context, i) {
              final item = _items[i];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: _showComingSoon,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 241, 240),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color.fromARGB(255, 197, 228, 225),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 46,
                        width: 46,
                        child: item.imageUrl.isNotEmpty
                            ? Image.network(
                                item.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.image_not_supported),
                              )
                            : const Icon(Icons.image_not_supported),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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
