import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../services/api_service.dart';
import '../../../foreign_treatment/views/foreign_treatment_view.dart';
import '../../../../routes/app_routes.dart';

class ForeignTreatmentSection extends StatefulWidget {
  const ForeignTreatmentSection({super.key});

  static final RxInt countryCount = 6.obs;
//
  @override
  State<ForeignTreatmentSection> createState() =>
      _ForeignTreatmentSectionState();
}

class _ForeignTreatmentSectionState extends State<ForeignTreatmentSection> {
  static const bool _useApiCountries = true;
  static const Duration _pollInterval = Duration(seconds: 4);
  final AppApiService _apiService = AppApiService();
  Timer? _pollTimer;
  bool _isFetching = false;
  bool _isLoading = false;

  final List<_ForeignTreatmentItem> _countries = <_ForeignTreatmentItem>[
    const _ForeignTreatmentItem(
      id: 1,
      name: 'India',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Flag_of_India.png',
    ),
    const _ForeignTreatmentItem(
      id: 2,
      name: 'China',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Chaina.png',
    ),
    const _ForeignTreatmentItem(
      id: 3,
      name: 'Thailand',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Thailand.jpg',
    ),
    const _ForeignTreatmentItem(
      id: 4,
      name: 'Turkey',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Turkey.jpg',
    ),
    const _ForeignTreatmentItem(
      id: 5,
      name: 'Singapore',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Singapore.jpg',
    ),
    const _ForeignTreatmentItem(
      id: 6,
      name: 'Malaysia',
      flagUrl: '',
      fallbackAssetPath: 'assets/images/Malaysia.jpg',
    ),
  ];

  void _setCountryCountSafely(int count) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ForeignTreatmentSection.countryCount.value == count) return;
      ForeignTreatmentSection.countryCount.value = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _setCountryCountSafely(_countries.length);
    if (_useApiCountries) {
      _isLoading = true;
      _fetchCountries(showLoading: true, showErrors: true);
      _startPolling();
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      _fetchCountries(showLoading: false, showErrors: false);
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

  Future<void> _fetchCountries({
    required bool showLoading,
    required bool showErrors,
  }) async {
    if (_isFetching) return;
    _isFetching = true;
    if (showLoading && mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final response = await _apiService.getWithAuthRetry(
        path: '/api/v1/foreign-treatments/countries/',
      );

      debugPrint('Foreign countries status => ${response.statusCode}');
      debugPrint('Foreign countries body => ${response.body}');

      if (response.statusCode == 401) {
        if (showErrors && mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _isFetching = false;
        return;
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (showErrors && mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _isFetching = false;
        return;
      }

      final results = await compute(_extractCountriesResults, response.body);
      if (results is! List) {
        if (showErrors && mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _isFetching = false;
        return;
      }

      final List<_ForeignTreatmentItem> mapped = results
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => _ForeignTreatmentItem(
              id: (item['id'] is int)
                  ? item['id'] as int
                  : int.tryParse((item['id'] ?? '').toString()) ?? 0,
              name: (item['name'] ?? '').toString(),
              flagUrl: _resolveImageUrl((item['flag'] ?? '').toString()),
              fallbackAssetPath:
                  _fallbackAssetByName((item['name'] ?? '').toString()),
            ),
          )
          .where((item) => item.id > 0 && item.name.trim().isNotEmpty)
          .toList();

      if (!mounted) return;
      if (mapped.isEmpty) {
        _setCountryCountSafely(0);
        if (showErrors && mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _isFetching = false;
        return;
      }

      final isDifferent = _countries.length != mapped.length ||
          _countries.asMap().entries.any((entry) {
            final existing = entry.value;
            final incoming = mapped[entry.key];
            return existing.id != incoming.id ||
                existing.name != incoming.name ||
                existing.flagUrl != incoming.flagUrl ||
                existing.fallbackAssetPath != incoming.fallbackAssetPath;
          });

      if (isDifferent) {
        setState(() {
          _countries
            ..clear()
            ..addAll(mapped);
          _isLoading = false;
        });
      } else if (_isLoading && mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      _setCountryCountSafely(_countries.length);
    } catch (e) {
      debugPrint('Foreign countries fetch error => $e');
      if (showErrors && mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

// NOTE: _extractCountriesResults moved to top-level below to be
// sendable to `compute()` without capturing `this`.

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
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
                'foreign_treatment'.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => Get.toNamed(Routes.FOREIGN_TREATMENT),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6FED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _countries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.85,
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
  final int id;
  final String name;
  final String flagUrl;
  final String fallbackAssetPath;

  const _ForeignTreatmentItem({
    required this.id,
    required this.name,
    required this.flagUrl,
    required this.fallbackAssetPath,
  });
}

class _ForeignTreatmentCard extends StatelessWidget {
  final _ForeignTreatmentItem item;
  const _ForeignTreatmentCard({required this.item});

  void _handleTap() {
    Get.to(
      () => IndiaHospitalsView(
        countryId: item.id,
        countryTitle: item.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFBEE9FF),
              Color(0xFFDFF8EF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33FFFFFF),
              offset: Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(3, 3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 36,
                            width: 48,
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
                          fontSize: 11,
                          height: 1.15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _handleTap,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBEE9FF),
                          Color(0xFFDFF8EF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F6F2),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x66FFFFFF),
                            offset: Offset(-4, -4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: Color(0x33000000),
                            offset: Offset(6, 6),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: Text(
                              'Press to view',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// background parser for countries list — top-level and sendable to `compute`
List<dynamic> _extractCountriesResults(String body) {
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
