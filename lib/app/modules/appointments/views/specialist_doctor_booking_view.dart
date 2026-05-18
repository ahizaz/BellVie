import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../services/app_loader.dart';
import '../../../services/auth_service.dart';

class SpecialistDoctorBookingView extends StatefulWidget {
  const SpecialistDoctorBookingView({super.key});

  @override
  State<SpecialistDoctorBookingView> createState() =>
      _SpecialistDoctorBookingViewState();
}

class _SpecialistDoctorBookingViewState
    extends State<SpecialistDoctorBookingView> {
  final AppApiService _apiService = AppApiService();
  final AuthService _authService = AuthService.to;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _doctorId;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _doctorId = _doctorIdFromRoute();
    _nameController.text = _authService.profileName.value.trim();
    _phoneController.text = _authService.profilePhone.value.trim();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int? _doctorIdFromRoute() {
    final idText = Get.parameters['id'];
    if (idText == null || idText.isEmpty) return null;
    return int.tryParse(idText);
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00.000Z';
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  int? _extractBookingId(dynamic decoded) {
    if (decoded == null) return null;

    if (decoded is Map<String, dynamic>) {
      return _asInt(decoded['id']) ??
          _asInt(decoded['booking']) ??
          _asInt(decoded['booking_id']) ??
          _extractBookingId(decoded['data']);
    }

    if (decoded is List && decoded.isNotEmpty) {
      return _extractBookingId(decoded.first);
    }

    return null;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (picked == null) return;
    setState(() {
      _selectedDate = picked;
      _dateController.text = _formatDate(picked);
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked == null) return;
    setState(() {
      _selectedTime = picked;
      _timeController.text = _formatTime(picked);
    });
  }

  Future<void> _submit() async {
    final doctorId = _doctorId;
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (doctorId == null) {
      AppLoader.showError('doctor_id_missing'.tr);
      return;
    }
    if (_selectedDate == null) {
      AppLoader.showError('please_select_date'.tr);
      return;
    }
    if (_selectedTime == null) {
      AppLoader.showError('please_select_time'.tr);
      return;
    }
    if (name.isEmpty) {
      AppLoader.showError('please_enter_patient_name'.tr);
      return;
    }
    if (phone.isEmpty) {
      AppLoader.showError('please_enter_phone_number'.tr);
      return;
    }

    if (_submitting) return;
    setState(() {
      _submitting = true;
    });
    AppLoader.show(status: 'Submitting...');

    try {
      final accessToken = _authService.accessToken.value.trim();
      final response = await _apiService.post(
        path: '/api/v1/auth/appointments/create/',
        headers: accessToken.isEmpty
            ? null
            : {
                'Authorization': 'Bearer $accessToken',
              },
        body: {
          'appointment_date': _formatDate(_selectedDate!),
          'appointment_time': _formatTime(_selectedTime!),
          'doctor_id': doctorId,
          'patient_name': name,
          'patient_phone': phone,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        int? bookingId;
        try {
          bookingId = _extractBookingId(jsonDecode(response.body));
        } catch (_) {
          bookingId = null;
        }

        if (bookingId == null) {
          AppLoader.showError('booking_id_missing'.tr);
          return;
        }

        AppLoader.showSuccess('appointment_submitted_successfully'.tr);
        if (mounted) {
          Get.offNamed(
            Routes.SPECIALIST_DOCTOR_PAYMENT,
            parameters: {
              'bookingId': bookingId.toString(),
            },
          );
        }
        return;
      }

      AppLoader.showError('Booking failed. Please try again.');
    } catch (e) {
      AppLoader.showError('Booking failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
      if (AppLoader.isShow) {
        AppLoader.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorId = _doctorId;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: Text('book_appointment'.tr),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.6,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoField(
            label: 'doctor_id'.tr,
            value: doctorId?.toString() ?? 'Not available',
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _dateController,
            label: 'date'.tr,
            hintText: 'select_date'.tr,
            readOnly: true,
            onTap: _pickDate,
            suffixIcon: Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _timeController,
            label: 'time'.tr,
            hintText: 'select_time'.tr,
            readOnly: true,
            onTap: _pickTime,
            suffixIcon: Icons.access_time_outlined,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _nameController,
            label: 'patient_name'.tr,
            hintText: 'enter_patient_name'.tr,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _phoneController,
            label: 'phone_number'.tr,
            hintText: 'enter_phone_number'.tr,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DA9A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _submitting ? 'submitting'.tr : 'submit'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8E7)),
      ),
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
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E8E7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E8E7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1DA9A1), width: 1.2),
        ),
        suffixIcon: suffixIcon == null
            ? null
            : Icon(suffixIcon, color: const Color(0xFF1DA9A1)),
      ),
    );
  }
}
