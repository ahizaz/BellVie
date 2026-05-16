import 'dart:convert';
import 'package:bellevie/app/services/api_service.dart';
import 'package:bellevie/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppointmentListView extends StatefulWidget {
  const AppointmentListView({Key? key}) : super(key: key);

  @override
  State<AppointmentListView> createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  final AuthService _authService = AuthService.to;
  final AppApiService _apiService = AppApiService();
  bool _loading = true;
  String? _error;
  List<dynamic> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final token = _authService.accessToken.value;
      final response = await _apiService.get(
        path: '/api/v1/auth/appointments/',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _appointments = data['results'] ?? [];
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load appointments.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Appointments')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Appointments')),
        body: Center(child: Text(_error!)),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: _appointments.isEmpty
          ? const Center(child: Text('No appointments found.'))
          : ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final appt = _appointments[index];
                final payment = appt['payment'] ?? {};
                final service = appt['service_details'] ?? {};
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(service['name'] ?? 'Unknown Doctor'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Patient: ${appt['patient_name'] ?? ''}'),
                        Text(
                            'Date: ${appt['appointment_date'] ?? ''} ${appt['appointment_time'] ?? ''}'),
                        Text('Status: ${appt['status'] ?? ''}'),
                        Text(
                            'Payment: ${payment['amount'] ?? ''} (${payment['status'] ?? ''})'),
                        Text('Hospital: ${service['hospital'] ?? ''}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
