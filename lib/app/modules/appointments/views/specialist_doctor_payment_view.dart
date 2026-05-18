import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/app_loader.dart';
import '../../../services/auth_service.dart';

class SpecialistDoctorPaymentView extends StatefulWidget {
  const SpecialistDoctorPaymentView({super.key});

  @override
  State<SpecialistDoctorPaymentView> createState() =>
      _SpecialistDoctorPaymentViewState();
}

class _SpecialistDoctorPaymentViewState
    extends State<SpecialistDoctorPaymentView> {
  final AppApiService _apiService = AppApiService();
  final AuthService _authService = AuthService.to;

  final TextEditingController _transactionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  int? _bookingId;
  String? _paymentMethod;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _bookingId = _bookingIdFromRoute();
  }

  @override
  void dispose() {
    _transactionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  int? _bookingIdFromRoute() {
    final idText = Get.parameters['bookingId'];
    if (idText == null || idText.isEmpty) return null;
    return int.tryParse(idText);
  }

  Future<void> _submit() async {
    final bookingId = _bookingId;
    final transactionId = _transactionController.text.trim();
    final amountText = _amountController.text.trim();

    if (bookingId == null) {
      AppLoader.showError('booking_id_missing'.tr);
      return;
    }
    if (amountText.isEmpty) {
      AppLoader.showError('please_enter_amount'.tr);
      return;
    }
    if (_paymentMethod == null) {
      AppLoader.showError('please_select_payment_method'.tr);
      return;
    }
    if (transactionId.isEmpty) {
      AppLoader.showError('please_enter_transaction_id'.tr);
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
        path: '/api/v1/auth/payments/submit/',
        headers: accessToken.isEmpty
            ? null
            : {
                'Authorization': 'Bearer $accessToken',
              },
        body: {
          'amount': amountText,
          'appointment': bookingId,
          'method': _paymentMethod,
          'transaction_id': transactionId,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        AppLoader.showSuccess('payment_submitted_successfully'.tr);
        if (mounted) {
          Get.back();
        }
        return;
      }

      AppLoader.showError('payment_failed_try_again'.tr);
    } catch (e) {
      AppLoader.showError('payment_failed_try_again'.tr);
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
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F6),
      appBar: AppBar(
        title: Text('payment'.tr),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.6,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoField(
            label: 'payment_number'.tr,
            value: '+8801805464400',
          ),
          const SizedBox(height: 12),
          _InfoField(
            label: 'booking_id'.tr,
            value: _bookingId?.toString() ?? 'not_available'.tr,
          ),
          const SizedBox(height: 12),
          _PaymentMethodField(
            value: _paymentMethod,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value;
              });
            },
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _amountController,
            label: 'amount'.tr,
            hintText: 'enter_amount'.tr,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _transactionController,
            label: 'transaction_id'.tr,
            hintText: 'enter_transaction_id'.tr,
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
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
      ),
    );
  }
}

class _PaymentMethodField extends StatelessWidget {
  const _PaymentMethodField({
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8E7)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text('select_payment_method'.tr),
          isExpanded: true,
          onChanged: onChanged,
          items: [
            DropdownMenuItem(value: 'bkash', child: Text('bkash'.tr)),
            DropdownMenuItem(value: 'nagad', child: Text('nagad'.tr)),
            DropdownMenuItem(value: 'rocket', child: Text('rocket'.tr)),
          ],
        ),
      ),
    );
  }
}
