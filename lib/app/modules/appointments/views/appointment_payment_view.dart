import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/app_loader.dart';
import '../../../services/auth_service.dart';

class AppointmentPaymentView extends StatefulWidget {
  const AppointmentPaymentView({super.key});

  @override
  State<AppointmentPaymentView> createState() => _AppointmentPaymentViewState();
}

class _AppointmentPaymentViewState extends State<AppointmentPaymentView> {
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
      AppLoader.showError('Booking id is missing.');
      return;
    }
    if (amountText.isEmpty) {
      AppLoader.showError('Please enter amount.');
      return;
    }
    if (_paymentMethod == null) {
      AppLoader.showError('Please select a payment method.');
      return;
    }
    if (transactionId.isEmpty) {
      AppLoader.showError('Please enter transaction id.');
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
        AppLoader.showSuccess('Payment submitted successfully.');
        if (mounted) {
          Get.back();
        }
        return;
      }

      AppLoader.showError('Payment failed. Please try again.');
    } catch (e) {
      AppLoader.showError('Payment failed. Please try again.');
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
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.6,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _InfoField(
            label: 'Payment Number',
            value: '+8801805464400',
          ),
          const SizedBox(height: 12),
          _InfoField(
            label: 'Booking ID',
            value: _bookingId?.toString() ?? 'Not available',
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
            label: 'Amount',
            hintText: 'Enter amount',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          _InputField(
            controller: _transactionController,
            label: 'Transaction ID',
            hintText: 'Enter transaction id',
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
                _submitting ? 'Submitting...' : 'Submit Payment',
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          RadioListTile<String>(
            value: 'bkash',
            groupValue: value,
            activeColor: const Color(0xFF1DA9A1),
            title: const Text('bKash'),
            onChanged: onChanged,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
          RadioListTile<String>(
            value: 'nagad',
            groupValue: value,
            activeColor: const Color(0xFF1DA9A1),
            title: const Text('Nagad'),
            onChanged: onChanged,
            contentPadding: EdgeInsets.zero,
            dense: true,
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
