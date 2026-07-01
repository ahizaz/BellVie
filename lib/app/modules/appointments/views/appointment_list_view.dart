import 'dart:convert';
import 'package:bellevie/app/services/api_service.dart';
import 'package:bellevie/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/widgets/call_drawer.dart';
import '../../home/widgets/home_bottom_nav.dart';
import '../../../routes/app_routes.dart';

class AppointmentListView extends StatefulWidget {
  const AppointmentListView({super.key});

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
        headers: {
          'Authorization': 'Bearer $token',
        },
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

  Color _getStatusBgColor(String status) {
    final value = status.toLowerCase();

    if (value == 'confirmed') {
      return const Color(0xFFD9FBE3);
    }

    if (value == 'pending') {
      return const Color(0xFFFFE8C7);
    }

    return Colors.white.withValues(alpha: .5);
  }

  Color _getStatusTextColor(String status) {
    final value = status.toLowerCase();

    if (value == 'confirmed') {
      return const Color(0xFF1B8F3A);
    }

    if (value == 'pending') {
      return const Color(0xFFE67E00);
    }

    return Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Text(_error!),
                )
              : _appointments.isEmpty
                  ? const Center(
                      child: Text(
                        'No appointments found.',
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: _appointments.length,
                      itemBuilder: (context, index) {
                        final appt = _appointments[index];
                        final payment = appt['payment'] ?? {};
                        final service = appt['service_details'] ?? {};
                        final status = appt['status']?.toString() ?? '';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 13),
                          padding: const EdgeInsets.all(16),
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
                            border: Border.all(
                              color: Colors.white24,
                              width: 1,
                            ),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: .4),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.calendar_month_rounded,
                                  size: 34,
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                              SizedBox(width: mediaQuery.width * .04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service['name'] ?? 'Unknown Doctor',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    _buildInfoRow(
                                      icon: Icons.person,
                                      text:
                                          'Patient: ${appt['patient_name'] ?? ''}',
                                    ),
                                    const SizedBox(height: 3),
                                    _buildInfoRow(
                                      icon: Icons.access_time,
                                      text:
                                          '${appt['appointment_date'] ?? ''} ${appt['appointment_time'] ?? ''}',
                                    ),
                                    const SizedBox(height: 3),
                                    _buildInfoRow(
                                      icon: Icons.local_hospital,
                                      text:
                                          'Hospital: ${service['hospital'] ?? ''}',
                                    ),
                                    const SizedBox(height: 3),
                                    _buildInfoRow(
                                      icon: Icons.payments_outlined,
                                      text:
                                          'Payment: ${payment['amount'] ?? ''} (${payment['status'] ?? ''})',
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusBgColor(status),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusTextColor(status),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 2) {
            showBelleVieCallDrawer(context);
            return;
          }

          if (i == 1) {
            return;
          }

          Get.offAllNamed(Routes.HOME, arguments: {'tab': i});
        },
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
