import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/api_service.dart';
import '../../../specialist_doctors/models/specialist_doctor_item.dart';

class GeneralPhysicianSection extends StatefulWidget {
  const GeneralPhysicianSection({super.key});

  @override
  State<GeneralPhysicianSection> createState() =>
      _GeneralPhysicianSectionState();
}

class _GeneralPhysicianSectionState extends State<GeneralPhysicianSection> {
  final AppApiService _apiService = AppApiService();
  final ScrollController _scrollController = ScrollController();
  List<SpecialistDoctorItem> _doctors = [];
  bool _isLoading = false;
  bool _resolved = false;
  bool _showScrollHintLeft = false;
  bool _showScrollHintRight = false;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
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

  Future<void> _fetchDoctors() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    const path =
        '/api/v1/popular-service/doctors/?subcategory=3&subcategory__category=1';

    // Try to show cached data immediately (persistent or in-memory)
    try {
      final cachedBody = await _apiService.getCachedBody(path: path);
      if (cachedBody != null && mounted) {
        try {
          final decoded = jsonDecode(cachedBody);
          final rawItems = decoded is Map<String, dynamic>
              ? (decoded['results'] as List<dynamic>? ?? const <dynamic>[])
              : const <dynamic>[];

          final items = rawItems
              .whereType<Map<String, dynamic>>()
              .map(SpecialistDoctorItem.fromJson)
              .where((doctor) => doctor.localizedName().trim().isNotEmpty)
              .toList();

          if (items.isNotEmpty) {
            setState(() {
              _doctors = items;
              _resolved = true;
              _showScrollHintLeft = false;
              _showScrollHintRight = false;
            });
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _updateScrollHint());
          }
        } catch (_) {
          // ignore parse errors from cache
        }
      }
    } catch (_) {
      // ignore cache read errors
    }

    // Fetch fresh data and update cache (if possible)
    try {
      final response = await _apiService.get(path: path);

      if (!mounted) return;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (mounted && _doctors.isEmpty) {
          setState(() {
            _doctors = [];
            _resolved = true;
            _isLoading = false;
          });
        } else if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      final decoded = jsonDecode(response.body);
      final rawItems = decoded is Map<String, dynamic>
          ? (decoded['results'] as List<dynamic>? ?? const <dynamic>[])
          : const <dynamic>[];

      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(SpecialistDoctorItem.fromJson)
          .where((doctor) => doctor.localizedName().trim().isNotEmpty)
          .toList();

      setState(() {
        _doctors = items;
        _resolved = true;
        _isLoading = false;
        _showScrollHintLeft = false;
        _showScrollHintRight = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollHint());
    } catch (_) {
      if (!mounted) return;
      if (_doctors.isEmpty) {
        setState(() {
          _doctors = [];
          _resolved = true;
          _isLoading = false;
          _showScrollHintLeft = false;
          _showScrollHintRight = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openBooking(String doctorId) {
    Get.toNamed('${Routes.GENERAL_PHYSICIAN_BOOKING}?id=$doctorId');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'general_physician'.tr,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 135,
          child: _isLoading && _doctors.isEmpty
              ? const SizedBox.shrink()
              : _doctors.isEmpty
                  ? (_resolved
                      ? Center(
                          child: Text('no_doctors_available'.tr),
                        )
                      : const SizedBox.shrink())
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
                              placeholder: (c, s) => Container(
                                color: const Color(0xFFDFF8EF),
                                child: Center(
                                  child: Text(
                                    _initialsFromName(doctor.localizedName()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (c, s, e) => Container(
                                color: const Color(0xFFDFF8EF),
                                child: Center(
                                  child: Text(
                                    _initialsFromName(doctor.localizedName()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (c, s, e) => Container(
                                color: const Color(0xFFDFF8EF),
                                child: Center(
                                  child: Text(
                                    _initialsFromName(doctor.name),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Container(
                          color: const Color(0xFFDFF8EF),
                          child: Center(
                            child: Text(
                              _initialsFromName(doctor.localizedName()),
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
                      doctor.localizedDesignation(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 1),
                    if (doctor.experience.isNotEmpty)
                      Text(
                        '${'experience'.tr}: ${doctor.experience} year${doctor.experience == '1' ? '' : 's'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    if (doctor.fees.isNotEmpty)
                      Text(
                        '${'fees'.tr}: ${doctor.fees}',
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
                        padding: const EdgeInsets.only(left: 2.0),
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
                                  horizontal: 8, vertical: 0),
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

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
