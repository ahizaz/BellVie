import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  Future<Map<String, dynamic>> _fetchDoctor(int id) async {
    final uri =
        AppApiService().buildUrl('/api/v1/popular-service/doctors/$id/');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load doctor details (${response.statusCode})');
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }

  int? _doctorIdFromRoute() {
    final idText = Get.parameters['id'];
    if (idText == null || idText.isEmpty) return null;
    return int.tryParse(idText);
  }

  String _textValue(dynamic value, {String fallback = 'Not available'}) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? fallback : text;
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

  List<String> _splitLines(String text) {
    return text
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  List<String> _contactLines(String text) {
    return _splitLines(text);
  }

  String _firstLine(List<String> lines, {required String fallback}) {
    if (lines.isEmpty) return fallback;
    return lines.first;
  }

  Widget _chip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE1E8E7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E9E8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFCBF1EF).withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
    BorderSide? borderSide,
  }) {
    final button = borderSide == null
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: foregroundColor,
              side: borderSide,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          );

    return Expanded(
      child: SizedBox(height: 48, child: button),
    );
  }

  Widget _heroAvatar(String imageUrl, String name, String designation) {
    return Column(
      children: [
        Container(
          width: 116,
          height: 116,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFFEFF6F5),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFEFF6F5),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person,
                          size: 56,
                          color: Colors.black26,
                        ),
                      );
                    },
                  )
                : Container(
                    color: const Color(0xFFEFF6F5),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      size: 56,
                      color: Colors.black26,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF17302F),
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          designation,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF6B7B7A),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _scheduleRow({required String left, required String right}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(
              Icons.fiber_manual_record,
              size: 9,
              color: Color(0xFF1DA9A1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17302F),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            right,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4C5E5D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctorId = _doctorIdFromRoute();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      body: doctorId == null
          ? Center(child: Text('invalid_doctor_id'.tr))
          : FutureBuilder<Map<String, dynamic>>(
              future: _fetchDoctor(doctorId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          '${'could_not_load_details'.tr} ${snapshot.error}'),
                    ),
                  );
                }

                final data = snapshot.data ?? const <String, dynamic>{};
                final name = _textValue(data['name']);
                final image =
                    _resolveImageUrl(data['image']?.toString().trim() ?? '');
                final designation = _textValue(data['designation']);
                final years =
                    _textValue(data['years_of_experience'], fallback: '0');
                final fees = _textValue(data['doctor_fees']);
                final hospital = data['hospital'] is Map
                    ? _textValue(data['hospital']['name'])
                    : _textValue(data['hospital']);
                final subcategory = _textValue(data['subcategory_name']);
                final details = _textValue(
                  data['doctor_details'],
                  fallback: 'no_additional_details_available'.tr,
                );
                final schedule = _textValue(
                  data['doctor_sedule'] ?? data['doctor_schedule'],
                );
                final contacts = _textValue(
                  data['contact_details'],
                  fallback: 'no_contact_details_available'.tr,
                );
                final contactLines = _contactLines(contacts);
                final scheduleLines = _splitLines(schedule);
                final contactLead = _firstLine(
                  contactLines,
                  fallback: 'no_contact_details_available'.tr,
                );

                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFC6EFE8),
                            Color(0xFFF3F7F6),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 48,
                                      child: IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(Icons.arrow_back),
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 48,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.snackbar(
                                              'More options',
                                              'Additional actions are not available yet.',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          },
                                          icon: const Icon(Icons.menu),
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Center(
                                  child: Text(
                                    'Profile',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child:
                                        _heroAvatar(image, name, designation),
                                  ),
                                  const SizedBox(height: 18),
                                  Center(
                                    child: Text(
                                      subcategory.isEmpty
                                          ? designation
                                          : subcategory,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2C6D69),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        _chip('Specialty', subcategory),
                                        _chip('Experience', '$years years'),
                                        _chip('Fees', fees),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFFE3E9E8),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.local_hospital_outlined,
                                              size: 18,
                                              color: Color(0xFF1DA9A1),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                hospital,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF17302F),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.phone_outlined,
                                              size: 18,
                                              color: Color(0xFF1DA9A1),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                contactLead,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF4C5E5D),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      _actionButton(
                                        label: 'book_appointment'.tr,
                                        onPressed: () {
                                          Get.toNamed(
                                            '${Routes.DOCTOR_BOOKING}?id=$doctorId',
                                          );
                                        },
                                        backgroundColor:
                                            const Color(0xFF1DA9A1),
                                        foregroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 12),
                                      _actionButton(
                                        label: 'Recommendations',
                                        onPressed: () {
                                          Get.snackbar(
                                            'Recommendations',
                                            'Recommendations are not available yet.',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        },
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFF17302F),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE1E8E7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  _sectionCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _sectionTitle('OPD Timings'),
                                        if (scheduleLines.isNotEmpty)
                                          Column(
                                            children: scheduleLines.map((line) {
                                              final normalized = line
                                                  .replaceAll('–', '-')
                                                  .replaceAll('—', '-')
                                                  .trim();
                                              String left = normalized;
                                              String right = '';

                                              final twoPart = normalized.split(
                                                RegExp(r'\s{2,}'),
                                              );
                                              if (twoPart.length >= 2) {
                                                left = twoPart.first;
                                                right = twoPart
                                                    .sublist(1)
                                                    .join(' ');
                                              } else if (normalized
                                                  .contains(' - ')) {
                                                final dashPart =
                                                    normalized.split(
                                                  RegExp(r'\s*-\s*'),
                                                );
                                                if (dashPart.length >= 2) {
                                                  left = dashPart.first;
                                                  right = dashPart
                                                      .sublist(1)
                                                      .join(' - ');
                                                }
                                              }

                                              return _scheduleRow(
                                                left: left,
                                                right:
                                                    right.isEmpty ? ' ' : right,
                                              );
                                            }).toList(),
                                          )
                                        else
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFCBF1EF)
                                                  .withOpacity(0.32),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Text(
                                              schedule,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                height: 1.5,
                                                color: Color(0xFF17302F),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _sectionCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _sectionTitle('Doctor Information'),
                                        _infoTile(
                                          icon: Icons.local_hospital_outlined,
                                          label: 'Hospital',
                                          value: hospital,
                                        ),
                                        const SizedBox(height: 12),
                                        _infoTile(
                                          icon: Icons.medical_services_outlined,
                                          label: 'Specialty',
                                          value: subcategory,
                                        ),
                                        const SizedBox(height: 12),
                                        _infoTile(
                                          icon: Icons.timer_outlined,
                                          label: 'Experience',
                                          value: '$years years',
                                        ),
                                        const SizedBox(height: 12),
                                        _infoTile(
                                          icon: Icons.payments_outlined,
                                          label: 'Consultation Fee',
                                          value: fees,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _sectionCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _sectionTitle('Details'),
                                        Text(
                                          details,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            height: 1.6,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _sectionCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _sectionTitle('Contact'),
                                        if (contactLines.isNotEmpty)
                                          Column(
                                            children: contactLines
                                                .map(
                                                  (line) => Container(
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFF9FBFB),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFFE3E9E8),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            line,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              height: 1.45,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          )
                                        else
                                          Text(
                                            contacts,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              height: 1.6,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
