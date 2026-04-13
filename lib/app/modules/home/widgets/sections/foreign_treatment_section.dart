import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../../../services/api_service.dart';
import '../../../../services/auth_service.dart';
import '../../../foreign_treatment/views/foreign_treatment_view.dart';

class ForeignTreatmentSection extends StatefulWidget {
  const ForeignTreatmentSection({super.key});

  @override
  State<ForeignTreatmentSection> createState() =>
      _ForeignTreatmentSectionState();
}

class _ForeignTreatmentSectionState extends State<ForeignTreatmentSection> {
  final AppApiService _apiService = AppApiService();

  final List<_ForeignTreatmentItem> _countries = <_ForeignTreatmentItem>[
    _ForeignTreatmentItem(
      name: 'Hospitals in India',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Flag_of_India.png',
    ),
    _ForeignTreatmentItem(
      name: 'Hospitals in China',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Chaina.png',
    ),
    _ForeignTreatmentItem(
      name: 'Hospitals in Thailand',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Thailand.jpg',
    ),
    _ForeignTreatmentItem(
      name: 'Hospitals in Turkey',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Turkey.jpg',
    ),
    _ForeignTreatmentItem(
      name: 'Hospitals in Singapore',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Singapore.jpg',
    ),
    _ForeignTreatmentItem(
      name: 'Hospitals in Malaysia',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Malaysia.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return '${AppApiService.baseUrl}$value';
  }

  String _fallbackAssetByName(String name) {
    final normalized = name.toLowerCase();
    if (normalized.contains('india')) return 'assets/images/Flag_of_India.png';
    if (normalized.contains('china')) return 'assets/images/Chaina.png';
    if (normalized.contains('thailand')) return 'assets/images/Thailand.jpg';
    if (normalized.contains('turkey')) return 'assets/images/Turkey.jpg';
    if (normalized.contains('singapore')) return 'assets/images/Singapore.jpg';
    if (normalized.contains('malaysia')) return 'assets/images/Malaysia.jpg';
    return 'assets/images/Flag_of_India.png';
  }

  Future<void> _fetchCountries() async {
    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      debugPrint('Foreign countries fetch skipped => token empty');
      EasyLoading.showError('Please login again.');
      return;
    }

    EasyLoading.show(status: 'Loading countries...');

    try {
      final response = await _apiService.get(
        path: '/api/v1/foreign-treatments/countries/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Foreign countries status => ${response.statusCode}');
      debugPrint('Foreign countries body => ${response.body}');

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        EasyLoading.showError('Country load failed. Please try again.');
        return;
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        EasyLoading.showError('Invalid country response.');
        return;
      }

      final dynamic results = decoded['results'];
      if (results is! List) {
        EasyLoading.showError('Invalid country data.');
        return;
      }

      final List<_ForeignTreatmentItem> mapped = results
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => _ForeignTreatmentItem(
              name: (item['name'] ?? '').toString(),
              flagUrl: _resolveImageUrl((item['flag'] ?? '').toString()),
              fallbackAssetPath:
                  _fallbackAssetByName((item['name'] ?? '').toString()),
            ),
          )
          .where((item) => item.name.trim().isNotEmpty)
          .toList();

      if (!mounted) return;
      if (mapped.isEmpty) {
        EasyLoading.showError('No country found.');
        return;
      }

      setState(() {
        _countries
          ..clear()
          ..addAll(mapped);
      });
    } catch (e) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      debugPrint('Foreign countries fetch error => $e');
      EasyLoading.showError(
          'Country load failed. Check internet and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'foreign_treatment'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _countries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.32,
          ),
          itemBuilder: (context, i) {
            return _ForeignTreatmentCard(item: _countries[i]);
          },
        ),
      ],
    );
  }
}

class _ForeignTreatmentItem {
  final String name;
  final String flagUrl;
  final String fallbackAssetPath;

  const _ForeignTreatmentItem({
    required this.name,
    required this.flagUrl,
    required this.fallbackAssetPath,
  });
}

class _ForeignTreatmentCard extends StatelessWidget {
  final _ForeignTreatmentItem item;
  const _ForeignTreatmentCard({required this.item});

  void _handleTap() {
    if (!AuthService.to.requireLogin()) return;

    final name = item.name.toLowerCase();
    if (name.contains('india')) {
      Get.to(() => const IndiaHospitalsView());
      return;
    }
    if (name.contains('china')) {
      Get.to(() => const ChainaHospitalsView());
      return;
    }
    if (name.contains('thailand')) {
      Get.to(() => const ThailandHospitalsView());
      return;
    }
    if (name.contains('turkey')) {
      Get.to(() => const TurkeyHospitalsView());
      return;
    }
    if (name.contains('singapore')) {
      Get.to(() => const SingaporeHospitalsView());
      return;
    }
    if (name.contains('malaysia')) {
      Get.to(() => const MalaysiaHospitalsView());
      return;
    }

    debugPrint('Foreign country tap ignored => unsupported: ${item.name}');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEDEA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 52,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: item.flagUrl.isNotEmpty
                        ? Image.network(
                            item.flagUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Image.asset(
                                item.fallbackAssetPath,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(item.fallbackAssetPath,
                            fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                height: 1.15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
