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

  Widget _row(String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  int? _doctorIdFromRoute() {
    final idText = Get.parameters['id'];
    if (idText == null || idText.isEmpty) return null;
    return int.tryParse(idText);
  }

  @override
  Widget build(BuildContext context) {
    final doctorId = _doctorIdFromRoute();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        backgroundColor: const Color(0xFFCBF1EF),
        foregroundColor: Colors.black87,
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
                final name = data['name']?.toString() ?? '';
                final image = data['image']?.toString();
                final designation = data['designation']?.toString() ?? '';
                final years = data['years_of_experience']?.toString() ?? '';
                final fees = data['doctor_fees']?.toString() ?? '';
                final hospital = (data['hospital'] is Map)
                    ? (data['hospital']['name']?.toString() ?? '')
                    : data['hospital']?.toString() ?? '';
                final subcategory = data['subcategory_name']?.toString() ?? '';
                final details = data['doctor_details']?.toString() ?? '';
                final schedule = data['doctor_sedule']?.toString() ??
                    data['doctor_schedule']?.toString() ??
                    '';
                final contacts = data['contact_details']?.toString() ?? '';

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (image != null && image.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            image,
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      if (designation.isNotEmpty)
                        Text(designation,
                            style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _row('Hospital', hospital),
                              _row('Specialty', subcategory),
                              _row('Experience',
                                  years.isNotEmpty ? '$years years' : ''),
                              _row('Fees', fees.isNotEmpty ? fees : ''),
                              _row('Schedule', schedule),
                              const SizedBox(height: 8),
                              if (details.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(details),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 8),
                              if (contacts.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Contact',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(contacts),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
