import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/api_service.dart';
import '../../../specialist_doctors/data/subcategory_repository.dart';
import '../../../specialist_doctors/models/specialist_doctor_item.dart';
import '../../../specialist_doctors/models/subcategory.dart';

class TopDoctorsSection extends StatefulWidget {
  const TopDoctorsSection({super.key});

  @override
  State<TopDoctorsSection> createState() => _TopDoctorsSectionState();
}

class _TopDoctorsSectionState extends State<TopDoctorsSection> {
  static const int _categoryId = 1;

  final AppApiService _apiService = AppApiService();
  final SubcategoryRepository _subcategoryRepository = SubcategoryRepository();
  final ScrollController _scrollController = ScrollController();

  List<Subcategory> _subcategories = [];
  List<SpecialistDoctorItem> _doctors = [];
  int? _selectedSubcategoryId;
  bool _isLoadingCategories = false;
  bool _isLoadingDoctors = false;
  bool _resolvedDoctors = false;
  String? _errorMessage;
  int _doctorRequestToken = 0;
  bool _showScrollHintLeft = false;
  bool _showScrollHintRight = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollRight() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final next = (_scrollController.offset + 220.0).clamp(0.0, max).toDouble();
    _scrollController.animateTo(
      next,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _scrollLeft() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final next = (_scrollController.offset - 220.0).clamp(0.0, max).toDouble();
    _scrollController.animateTo(
      next,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _updateScrollHint() {
    if (!mounted || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    final showLeft = position.pixels > 2;
    final showRight = position.maxScrollExtent > 0 &&
        position.pixels < position.maxScrollExtent - 2;
    if (showLeft != _showScrollHintLeft || showRight != _showScrollHintRight) {
      setState(() {
        _showScrollHintLeft = showLeft;
        _showScrollHintRight = showRight;
      });
    }
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _loadSubcategories(),
      _fetchDoctors(),
    ]);
  }

  Future<void> _loadSubcategories() async {
    if (!mounted) return;
    setState(() {
      _isLoadingCategories = true;
    });

    try {
      final cached = await _subcategoryRepository.loadCachedSubcategories(
        categoryId: _categoryId,
      );
      if (mounted && cached.isNotEmpty) {
        setState(() {
          _subcategories = cached;
        });
      }

      final items = await _subcategoryRepository.fetchSubcategories(
        categoryId: _categoryId,
      );

      if (!mounted) return;
      setState(() {
        _subcategories = items.isNotEmpty ? items : _subcategories;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCategories = false;
        });
      }
    }
  }

  Future<void> _fetchDoctors({int? subcategoryId}) async {
    final requestToken = ++_doctorRequestToken;
    if (!mounted) return;
    setState(() {
      _isLoadingDoctors = true;
      _errorMessage = null;
    });
    final path = subcategoryId == null
        ? '/api/v1/popular-service/doctors/?subcategory__category=$_categoryId'
        : '/api/v1/popular-service/doctors/?subcategory=$subcategoryId&subcategory__category=$_categoryId';

    // Attempt to hydrate from cache first so UI shows data when offline.
    // Try multiple candidate paths so we match what other parts of the app
    // may have saved (page param, different endpoint variants).
    try {
      final candidates = <String>[];
      if (subcategoryId == null) {
        candidates.add(
            '/api/v1/popular-service/doctors/?subcategory__category=$_categoryId');
        candidates.add('/api/v1/popular-service/doctors/');
        candidates.add(
            '/api/v1/popular-service/doctors/?page=1&subcategory__category=$_categoryId');
        candidates.add('/api/v1/popular-service/doctors/?page=1');
      } else {
        candidates.add(
            '/api/v1/popular-service/doctors/?subcategory=$subcategoryId&subcategory__category=$_categoryId');
        candidates.add(
            '/api/v1/popular-service/doctors/?page=1&subcategory=$subcategoryId&subcategory__category=$_categoryId');
        candidates.add(
            '/api/v1/popular-service/doctors/?page=1&subcategory__category=$_categoryId');
        candidates.add('/api/v1/popular-service/doctors/');
      }

      for (final candidate in candidates) {
        final cachedBody = await _apiService.getCachedBody(path: candidate);
        if (cachedBody == null) continue;
        if (!mounted || requestToken != _doctorRequestToken) return;
        try {
          final decoded = jsonDecode(cachedBody);
          final rawItems = _extractList(decoded);
          final items = rawItems
              .whereType<Map<String, dynamic>>()
              .map(SpecialistDoctorItem.fromJson)
              .where((doctor) => doctor.localizedName().trim().isNotEmpty)
              .where((doctor) => !_isHiddenDoctor(doctor))
              .toList();

          if (items.isNotEmpty) {
            setState(() {
              _doctors = items;
              _resolvedDoctors = true;
              _showScrollHintLeft = false;
              _showScrollHintRight = false;
              _errorMessage = items.isEmpty ? 'no_doctors_available'.tr : null;
            });
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _updateScrollHint());
            break;
          }
        } catch (_) {
          // ignore cache parse errors and try next candidate
        }
      }
    } catch (_) {
      // ignore cache read errors
    }

    try {
      final response = await _apiService.get(path: path);
      if (!mounted || requestToken != _doctorRequestToken) return;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        setState(() {
          _doctors = [];
          _resolvedDoctors = true;
          _isLoadingDoctors = false;
          _errorMessage = 'no_doctors_available'.tr;
        });
        return;
      }

      final decoded = jsonDecode(response.body);
      final rawItems = _extractList(decoded);
      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(SpecialistDoctorItem.fromJson)
          .where((doctor) => doctor.localizedName().trim().isNotEmpty)
          .where((doctor) => !_isHiddenDoctor(doctor))
          .toList();

      setState(() {
        _doctors = items;
        _resolvedDoctors = true;
        _isLoadingDoctors = false;
        _showScrollHintLeft = false;
        _showScrollHintRight = false;
        _errorMessage = items.isEmpty ? 'no_doctors_available'.tr : null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollHint());
    } catch (_) {
      if (!mounted || requestToken != _doctorRequestToken) return;
      setState(() {
        _doctors = [];
        _resolvedDoctors = true;
        _isLoadingDoctors = false;
        _showScrollHintLeft = false;
        _showScrollHintRight = false;
        _errorMessage = 'no_doctors_available'.tr;
      });
    }
  }

  List<dynamic> _extractList(dynamic decoded) {
    if (decoded is List) return decoded;
    if (decoded is Map<String, dynamic>) {
      final candidates = <dynamic>[
        decoded['results'],
        decoded['data'],
        decoded['items'],
      ];
      for (final candidate in candidates) {
        if (candidate is List) return candidate;
      }
    }
    return const [];
  }

  void _selectSubcategory(int? subcategoryId) {
    if (_selectedSubcategoryId == subcategoryId && _resolvedDoctors) {
      return;
    }

    setState(() {
      _selectedSubcategoryId = subcategoryId;
    });
    _fetchDoctors(subcategoryId: subcategoryId);
  }

  void _openBooking(String doctorId) {
    Get.toNamed('${Routes.SPECIALIST_DOCTOR_BOOKING}?id=$doctorId');
  }

  void _openAllDoctors() {
    Get.toNamed(Routes.SPECIALIST_DOCTORS);
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    if (value.startsWith('/')) {
      return '${AppApiService.baseUrl}$value';
    }
    return value;
  }

  bool _isHiddenDoctor(SpecialistDoctorItem doctor) {
    return doctor.subcategoryName.trim().toLowerCase() == 'general physician';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'specialist_doctors'.tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: _openAllDoctors,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2F6FED),
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'view_all'.tr,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip(
                  label: 'all'.tr,
                  iconUrl: null,
                  iconFallback: Icons.medical_services_outlined,
                  selected: _selectedSubcategoryId == null,
                  onTap: () => _selectSubcategory(null),
                  isLoading: _isLoadingCategories && _subcategories.isEmpty,
                ),
                const SizedBox(width: 8),
                ..._subcategories.map(
                  (subcategory) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _CategoryChip(
                        label: subcategory.localizedName(Get.locale),
                        iconUrl: _resolveImageUrl(subcategory.icon ?? ''),
                        iconFallback: Icons.local_hospital_outlined,
                        selected: _selectedSubcategoryId == subcategory.id,
                        onTap: () => _selectSubcategory(subcategory.id),
                        isLoading: false,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 135,
          child: _isLoadingDoctors && _doctors.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                )
              : _doctors.isEmpty
                  ? Center(
                      child: Text(
                        _errorMessage ?? 'no_doctors_available'.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification ||
                                notification is ScrollEndNotification) {
                              _updateScrollHint();
                            }
                            return false;
                          },
                          child: ListView.separated(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: _showScrollHintLeft ? 36 : 0,
                              right: _showScrollHintRight ? 36 : 0,
                            ),
                            itemCount: _doctors.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final doctor = _doctors[index];
                              return _DoctorCard(
                                doctor: doctor,
                                onTap: () => _openBooking(doctor.id),
                              );
                            },
                          ),
                        ),
                        if (_doctors.length > 1 && _showScrollHintRight)
                          Positioned(
                            right: 6,
                            top: 0,
                            bottom: 0,
                            child: _ScrollHintArrow(
                              onPressed: _scrollRight,
                              icon: Icons.arrow_forward_ios_rounded,
                            ),
                          ),
                        if (_doctors.length > 1 && _showScrollHintLeft)
                          Positioned(
                            left: 6,
                            top: 0,
                            bottom: 0,
                            child: _ScrollHintArrow(
                              onPressed: _scrollLeft,
                              icon: Icons.arrow_back_ios_new_rounded,
                            ),
                          ),
                      ],
                    ),
        ),
      ],
    );
  }
}

class _ScrollHintArrow extends StatelessWidget {
  const _ScrollHintArrow({required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFF2F6FED),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.iconUrl,
    required this.iconFallback,
    required this.selected,
    required this.onTap,
    required this.isLoading,
  });

  final String label;
  final String? iconUrl;
  final IconData iconFallback;
  final bool selected;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? const Color(0xFFE1F5FD) : Colors.white;
    final borderColor =
        selected ? const Color(0xFFB8E6F8) : const Color(0xFFE5EDF7);

    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CategoryIcon(
              iconUrl: iconUrl,
              iconFallback: iconFallback,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? const Color(0xFF1F4E99) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({
    required this.iconUrl,
    required this.iconFallback,
  });

  final String? iconUrl;
  final IconData iconFallback;

  @override
  Widget build(BuildContext context) {
    final url = iconUrl?.trim() ?? '';
    if (url.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: 18,
          height: 18,
          fit: BoxFit.cover,
          placeholder: (_, __) => Icon(
            iconFallback,
            size: 18,
            color: const Color(0xFF2F6FED),
          ),
          errorWidget: (_, __, ___) => Icon(
            iconFallback,
            size: 18,
            color: const Color(0xFF2F6FED),
          ),
        ),
      );
    }

    return Icon(
      iconFallback,
      size: 18,
      color: const Color(0xFF2F6FED),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.doctor, required this.onTap});

  final SpecialistDoctorItem doctor;
  final VoidCallback onTap;

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    if (value.startsWith('/')) {
      return '${AppApiService.baseUrl}$value';
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = doctor.imageAssetPath.trim();
    final resolvedImageUrl = _resolveImageUrl(imagePath);

    final isNetworkImage = resolvedImageUrl.startsWith('http://') ||
        resolvedImageUrl.startsWith('https://');

    final subtitle = doctor.subcategoryName.isNotEmpty
        ? doctor.subcategoryName
        : doctor.localizedDesignation();

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 238,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFBEE9FF),
              Color(0xFFDFF8EF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33FFFFFF),
              offset: Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(3, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                width: 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: imagePath.isNotEmpty
                      ? isNetworkImage
                          ? CachedNetworkImage(
                              imageUrl: resolvedImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => _DoctorPlaceholder(
                                name: doctor.localizedName(),
                              ),
                              errorWidget: (_, __, ___) => _DoctorPlaceholder(
                                name: doctor.localizedName(),
                              ),
                            )
                          : Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _DoctorPlaceholder(
                                name: doctor.localizedName(),
                              ),
                            )
                      : _DoctorPlaceholder(
                          name: doctor.localizedName(),
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.localizedName(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (doctor.experience.isNotEmpty)
                      Text(
                        '${'experience'.tr}: ${doctor.experience}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    if (doctor.fees.isNotEmpty)
                      Text(
                        '${'fees'.tr}: ৳${doctor.fees}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    const SizedBox(height: 6),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Container(
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: onTap,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'book_appointment'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2F6FED),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorPlaceholder extends StatelessWidget {
  const _DoctorPlaceholder({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDFF8EF),
      alignment: Alignment.center,
      child: Text(
        _initialsFromName(name),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }

  String _initialsFromName(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    final firstLetter = parts[0].substring(0, 1);
    final secondLetter = parts[1].substring(0, 1);
    return (firstLetter + secondLetter).toUpperCase();
  }
}
