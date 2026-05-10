import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  static const String _baseUrl = 'https://api.dmatechno.com';

  Future<Map<String, dynamic>> _fetchDoctor(int id) async {
    final uri = Uri.parse('$_baseUrl/api/v1/popular-service/doctors/$id/');
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

  List<String> _contactLines(String text) {
    return text
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  Widget _chip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
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
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFCBF1EF).withOpacity(0.8),
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
            color: Colors.black.withOpacity(0.05),
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
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Doctor Details'),
        backgroundColor: const Color(0xFFCBF1EF),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: doctorId == null
          ? const Center(child: Text('Invalid doctor id'))
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
                      child: Text('Could not load details. ${snapshot.error}'),
                    ),
                  );
                }

                final data = snapshot.data ?? const <String, dynamic>{};
                final name = _textValue(data['name']);
                final image = data['image']?.toString().trim() ?? '';
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
                  fallback: 'No additional details available.',
                );
                final schedule = _textValue(
                  data['doctor_sedule'] ?? data['doctor_schedule'],
                );
                final contacts = _textValue(
                  data['contact_details'],
                  fallback: 'No contact details available.',
                );
                final contactLines = _contactLines(contacts);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 11,
                                child: image.isNotEmpty
                                    ? Image.network(
                                        image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                            color: const Color(0xFFEFF6F5),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: const Color(0xFFEFF6F5),
                                            child: const Center(
                                              child: Icon(
                                                Icons.person,
                                                size: 72,
                                                color: Colors.black26,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: const Color(0xFFEFF6F5),
                                        child: const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 72,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.75),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        designation,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _chip('Specialty', subcategory),
                          _chip('Experience', '$years years'),
                          _chip('Fees', fees),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _sectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 16),
                      _sectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle('Schedule'),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFCBF1EF).withOpacity(0.35),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                schedule,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _sectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 16),
                      _sectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle('Contact'),
                            if (contactLines.isNotEmpty)
                              Column(
                                children: contactLines
                                    .map(
                                      (line) => Container(
                                        width: double.infinity,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.phone_in_talk_outlined,
                                              size: 18,
                                              color: Colors.black54,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                line,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  height: 1.45,
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
                );
              },
            ),
    );
  }
}
