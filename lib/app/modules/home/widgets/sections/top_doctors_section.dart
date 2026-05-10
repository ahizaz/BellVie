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

  List<Subcategory> _subcategories = [];
  List<SpecialistDoctorItem> _doctors = [];
  int? _selectedSubcategoryId;
  bool _isLoadingCategories = false;
  bool _isLoadingDoctors = false;
  bool _resolvedDoctors = false;
  String? _errorMessage;
  int _doctorRequestToken = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
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

    try {
      final path = subcategoryId == null
          ? '/api/v1/special-doctor/doctors/?subcategory__category=$_categoryId'
          : '/api/v1/special-doctor/doctors/?subcategory=$subcategoryId&subcategory__category=$_categoryId';

      final response = await _apiService.get(path: path);
      if (!mounted || requestToken != _doctorRequestToken) return;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        setState(() {
          _doctors = [];
          _resolvedDoctors = true;
          _isLoadingDoctors = false;
          _errorMessage = 'No doctors available right now.';
        });
        return;
      }

      final decoded = jsonDecode(response.body);
      final rawItems = _extractList(decoded);
      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(SpecialistDoctorItem.fromJson)
          .where((doctor) => doctor.name.isNotEmpty)
          .toList();

      setState(() {
        _doctors = items;
        _resolvedDoctors = true;
        _isLoadingDoctors = false;
        _errorMessage =
            items.isEmpty ? 'No doctors available right now.' : null;
      });
    } catch (_) {
      if (!mounted || requestToken != _doctorRequestToken) return;
      setState(() {
        _doctors = [];
        _resolvedDoctors = true;
        _isLoadingDoctors = false;
        _errorMessage = 'No doctors available right now.';
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

  void _openBooking() {
    Get.toNamed(Routes.BOOK_APPOINTMENT);
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
    return '${AppApiService.baseUrl}$value';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Specialist Doctors',
              textAlign: TextAlign.left,
              style: TextStyle(
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
              child: const Text(
                'See All',
                style: TextStyle(
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
                  label: 'All',
                  iconUrl: null,
                  iconFallback: Icons.medical_services_outlined,
                  selected: _selectedSubcategoryId == null,
                  onTap: () => _selectSubcategory(null),
                  isLoading: _isLoadingCategories && _subcategories.isEmpty,
                ),
                const SizedBox(width: 8),
                ..._subcategories.map(
                  (subcategory) {
                    if (subcategory.name.trim() == 'General Physician') {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _CategoryChip(
                        label: subcategory.name,
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
        const SizedBox(height: 14),
        SizedBox(
          height: 260,
          child: _isLoadingDoctors && _doctors.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                )
              : _doctors.isEmpty
                  ? Center(
                      child: Text(
                        _errorMessage ?? 'No doctors available right now.',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _doctors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final doctor = _doctors[index];
                        return _DoctorCard(
                          doctor: doctor,
                          onTap: _openBooking,
                        );
                      },
                    ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    final imagePath = doctor.imageAssetPath.trim();

    final isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    final subtitle = doctor.subcategoryName.isNotEmpty
        ? doctor.subcategoryName
        : doctor.designation;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: 175,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipOval(
                    child: imagePath.isNotEmpty
                        ? isNetworkImage
                            ? CachedNetworkImage(
                                imageUrl: imagePath,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => _DoctorPlaceholder(
                                  name: doctor.name,
                                ),
                                errorWidget: (_, __, ___) => _DoctorPlaceholder(
                                  name: doctor.name,
                                ),
                              )
                            : Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    _DoctorPlaceholder(
                                  name: doctor.name,
                                ),
                              )
                        : _DoctorPlaceholder(
                            name: doctor.name,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  height: 1.2,
                ),
              ),
              if (doctor.experience.isNotEmpty || doctor.fees.isNotEmpty) ...[
                const SizedBox(height: 2),
                Column(
                  children: [
                    if (doctor.experience.isNotEmpty)
                      Text(
                        'Experience: ${doctor.experience}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    if (doctor.fees.isNotEmpty)
                      Text(
                        'Fees: ৳${doctor.fees}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              ],
              TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
