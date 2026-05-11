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
  List<SpecialistDoctorItem> _doctors = [];
  bool _isLoading = false;
  bool _resolved = false;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.get(
        path: '/api/v1/top-doctor/doctors/',
      );

      if (!mounted) return;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        setState(() {
          _doctors = [];
          _resolved = true;
          _isLoading = false;
        });
        return;
      }

      final decoded = jsonDecode(response.body);
      final rawItems = decoded is Map<String, dynamic>
          ? (decoded['results'] as List<dynamic>? ?? const <dynamic>[])
          : const <dynamic>[];

      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(SpecialistDoctorItem.fromJson)
          .where((doctor) => doctor.name.isNotEmpty)
          .toList();

      setState(() {
        _doctors = items;
        _resolved = true;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _doctors = [];
        _resolved = true;
        _isLoading = false;
      });
    }
  }

  void _openBooking() {
    Get.toNamed(Routes.BOOK_APPOINTMENT);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'General Physician',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 200,
          child: _isLoading && _doctors.isEmpty
              ? const SizedBox.shrink()
              : _doctors.isEmpty
                  ? (_resolved
                      ? const Center(
                          child: Text('No doctors available right now.'),
                        )
                      : const SizedBox.shrink())
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
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

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.doctor, required this.onTap});

  final SpecialistDoctorItem doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imagePath = doctor.imageAssetPath.trim();
    final isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 180,
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
        child: SizedBox(
          width: 178,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 6,
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: imagePath.isNotEmpty
                        ? isNetworkImage
                            ? CachedNetworkImage(
                                imageUrl: imagePath,
                                fit: BoxFit.cover,
                                placeholder: (c, s) => Container(
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
                                errorWidget: (c, s, e) => Container(
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
              const SizedBox(height: 4),
              Text(
                doctor.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                //overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                doctor.designation,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              if (doctor.experience.isNotEmpty || doctor.fees.isNotEmpty) ...[
                Column(
                  children: [
                    if (doctor.experience.isNotEmpty)
                      Text(
                        'Experience: ${doctor.experience}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    if (doctor.fees.isNotEmpty)
                      Text(
                        'Fees: ${doctor.fees}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              ],
              SizedBox(
                child: TextButton(
                  onPressed: onTap,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2F6FED),
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

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
