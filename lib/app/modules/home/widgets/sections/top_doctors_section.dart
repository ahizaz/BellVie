import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../routes/app_routes.dart';
import '../../../specialist_doctors/data/specialist_doctors_repository.dart';
import '../../../specialist_doctors/models/specialist_doctor_item.dart';
import '../../../specialist_doctors/data/subcategory_repository.dart';
import '../../../specialist_doctors/models/subcategory.dart';

class TopDoctorsSection extends StatefulWidget {
  const TopDoctorsSection({super.key});

  @override
  State<TopDoctorsSection> createState() => _TopDoctorsSectionState();
}

class _TopDoctorsSectionState extends State<TopDoctorsSection> {
  final _subcategoryRepo = SubcategoryRepository();
  final _doctorsRepo = SpecialistDoctorsRepository();

  List<Subcategory> _chips = [];
  Subcategory? _selectedSubcategory;
  List<SpecialistDoctorItem> _doctors = [];
  bool _doctorsResolved = false;
  bool _isFetchingDoctors = false;
  final Map<String, List<SpecialistDoctorItem>> _doctorCache = {};

  @override
  void initState() {
    super.initState();
    _loadChips();
    _loadDoctorsForSelection();
  }

  Future<void> _loadChips() async {
    final items = await _subcategoryRepo.fetchSubcategories();
    if (!mounted) return;
    setState(() {
      _chips = items;
    });
  }

  DoctorsPage? _loadCachedDoctors({Subcategory? subcategory}) {
    if (subcategory != null) {
      if (subcategory.category != null) {
        return _doctorsRepo.getDoctorsByCategorySync(
          categoryId: subcategory.category,
          subcategoryId: subcategory.id,
          page: 1,
        );
      }

      return _doctorsRepo.getDoctorsByCategorySync(
        categoryKey: subcategory.name,
        page: 1,
      );
    }

    return _doctorsRepo.getDoctorsByCategorySync(
      categoryKey: 'popular',
      page: 1,
    );
  }

  String _selectionCacheKey({Subcategory? subcategory}) {
    if (subcategory == null) {
      return 'popular';
    }

    if (subcategory.category != null) {
      return 'cat:${subcategory.category}-sub:${subcategory.id}';
    }

    return 'key:${subcategory.name.trim().toLowerCase()}';
  }

  Future<List<SpecialistDoctorItem>> _loadDoctors(
      {Subcategory? subcategory}) async {
    try {
      if (subcategory != null) {
        // Prefer numeric category+subcategory direct endpoint when available
        if (subcategory.category != null) {
          final page = await _doctorsRepo.getDoctorsByCategory(
            categoryId: subcategory.category,
            subcategoryId: subcategory.id,
            page: 1,
            useCache: true,
          );
          return page.items;
        }

        // Fallback: use the subcategory name as categoryKey
        final page = await _doctorsRepo.getDoctorsByCategory(
          categoryKey: subcategory.name,
          page: 1,
          useCache: true,
        );
        return page.items;
      }

      // default: popular doctors
      final page = await _doctorsRepo.getDoctorsByCategory(
        categoryKey: 'popular',
        page: 1,
        useCache: true,
      );
      return page.items;
    } catch (_) {
      return const [];
    }
  }

  Future<void> _loadDoctorsForSelection({Subcategory? subcategory}) async {
    final cacheKey = _selectionCacheKey(subcategory: subcategory);
    final memoryCache = _doctorCache[cacheKey];
    if (memoryCache != null && memoryCache.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        _doctors = memoryCache;
        _doctorsResolved = true;
        _isFetchingDoctors = false;
      });
      return;
    }

    final cachedPage = _loadCachedDoctors(subcategory: subcategory);
    if (!mounted) return;

    if (cachedPage != null && cachedPage.items.isNotEmpty) {
      setState(() {
        _doctors = cachedPage.items;
        _doctorsResolved = true;
        _isFetchingDoctors = false;
      });
      _doctorCache[cacheKey] = cachedPage.items;
      return;
    }

    if (!mounted) return;
    setState(() {
      _isFetchingDoctors = true;
      if (_doctors.isEmpty) {
        _doctorsResolved = false;
      }
    });

    final items = await _loadDoctors(subcategory: subcategory);
    if (!mounted) return;

    setState(() {
      _doctors = items;
      _doctorsResolved = true;
      _isFetchingDoctors = false;
    });

    if (items.isNotEmpty) {
      _doctorCache[cacheKey] = items;
    }
  }

  void _selectSubcategory(Subcategory? subcategory) {
    setState(() {
      _selectedSubcategory = subcategory;
    });
    _loadDoctorsForSelection(subcategory: subcategory);
  }

  void _onSeeAll() {
    Get.toNamed(Routes.SPECIALIST_DOCTORS);
  }

  void _onBook() {
    Get.toNamed(Routes.BOOK_APPOINTMENT);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Specialist Doctors',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _onSeeAll,
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
        const SizedBox(height: 12),

        // Category chips row
        SizedBox(
          height: 44,
          child: _chips.isEmpty
              ? const SizedBox.shrink()
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _chips.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final selected = _selectedSubcategory == null;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: const Text('All'),
                          selected: selected,
                          onSelected: (_) {
                            _selectSubcategory(null);
                          },
                        ),
                      );
                    }
                    final item = _chips[index - 1];
                    final selected = _selectedSubcategory?.id == item.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        avatar: item.icon != null && item.icon!.isNotEmpty
                            ? Image.network(item.icon!, width: 18, height: 18)
                            : null,
                        label: Text(item.name),
                        selected: selected,
                        onSelected: (_) {
                          _selectSubcategory(selected ? null : item);
                        },
                      ),
                    );
                  },
                ),
        ),

        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: _doctors.isEmpty
              ? (_doctorsResolved
                  ? const Center(
                      child: Text('No doctors available right now.'),
                    )
                  : const SizedBox.shrink())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _doctors.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final d = _doctors[index];
                    return _TopDoctorCard(
                      doctor: d,
                      onCardTap: () {
                        final Map<String, dynamic> args = {
                          'categoryKey': d.subcategoryName.isNotEmpty
                              ? d.subcategoryName
                              : d.designation,
                          'categoryLabel': d.subcategoryName.isNotEmpty
                              ? d.subcategoryName
                              : d.designation,
                          'categoryAssetPath': d.imageAssetPath,
                          'subcategoryId': d.id,
                        };
                        Get.toNamed(Routes.SPECIALIST_DOCTOR_LIST,
                            arguments: args);
                      },
                      onAppointmentTap: _onBook,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _TopDoctorCard extends StatelessWidget {
  final SpecialistDoctorItem doctor;
  final VoidCallback onCardTap;
  final VoidCallback onAppointmentTap;

  const _TopDoctorCard({
    required this.doctor,
    required this.onCardTap,
    required this.onAppointmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onCardTap,
      child: Container(
        width: 175,
        padding: const EdgeInsets.all(12),
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
              offset: Offset(3, 3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: doctor.imageAssetPath.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: doctor.imageAssetPath,
                          fit: BoxFit.cover,
                          placeholder: (c, s) => Container(
                            color: const Color(0xFFDFF8EF),
                            child: Center(
                                child: Text(
                              _initialsFromName(doctor.name),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                          errorWidget: (c, s, e) => Container(
                            color: const Color(0xFFDFF8EF),
                            child: Center(
                                child: Text(
                              _initialsFromName(doctor.name),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        )
                      : Container(
                          color: const Color(0xFFDFF8EF),
                          child: Center(
                            child: Text(
                              _initialsFromName(doctor.name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.subcategoryName.isNotEmpty
                  ? doctor.subcategoryName
                  : doctor.designation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 30,
              child: TextButton(
                onPressed: onAppointmentTap,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F6FED),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r"\s+"));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
