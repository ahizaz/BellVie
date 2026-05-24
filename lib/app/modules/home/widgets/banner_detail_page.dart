import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class BannerDetailPage extends StatefulWidget {
  final String? bannerId;
  final Map<String, dynamic>? initialData;

  const BannerDetailPage({Key? key, this.bannerId, this.initialData})
      : super(key: key);

  @override
  State<BannerDetailPage> createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
  final AppApiService _apiService = AppApiService();
  bool _isLoading = true;
  bool _hasError = false;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    if (widget.bannerId != null) {
      _fetchDetail(widget.bannerId!);
    } else if (widget.initialData != null) {
      _data = widget.initialData;
      _isLoading = false;
    } else {
      _hasError = true;
      _isLoading = false;
    }
  }

  Future<void> _fetchDetail(String id) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final path = '/api/v1/slider/slider-one/$id/';
      final response = await _apiService.get(path: path);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          setState(() {
            _data = decoded;
            _isLoading = false;
          });
          return;
        }
      }
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError || _data == null
              ? const Center(child: Text('Unable to load banner details'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show textual fields from API, exclude image
                      ..._buildInfoWidgets(),

                      const SizedBox(height: 16),
                      // The 'More info' ExpansionTile has been removed.
                    ],
                  ),
                ),
    );
  }

  List<Widget> _buildInfoWidgets() {
    if (_data == null) return [];
    final widgets = <Widget>[];

    // Common label candidates
    final title = (_data?['title'] ?? _data?['heading'] ?? '').toString();
    final desc = (_data?['description'] ?? _data?['detail'] ?? '').toString();
    final phone = (_data?['phone'] ?? _data?['contact'] ?? '').toString();

    if (title.isNotEmpty) {
      widgets.add(Text(title, style: Theme.of(context).textTheme.titleLarge));
      widgets.add(const SizedBox(height: 8));
    }

    if (desc.isNotEmpty) {
      widgets.add(Text(desc, style: Theme.of(context).textTheme.bodyMedium));
      widgets.add(const SizedBox(height: 8));
    }

    if (phone.isNotEmpty) {
      widgets.add(Row(
        children: [
          const Icon(Icons.phone, size: 18),
          const SizedBox(width: 8),
          Text(phone, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ));
      widgets.add(const SizedBox(height: 8));
    }

    // Show any other textual fields except 'image'
    _data!.forEach((key, value) {
      if (key == 'image' || value == null) return;
      final s = value.toString();
      if (s.isEmpty) return;
      if (key == 'title' ||
          key == 'description' ||
          key == 'phone' ||
          key == 'heading' ||
          key == 'detail' ||
          key == 'contact') return;

      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_capitalize(key)}:',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(s),
          const SizedBox(height: 8),
        ],
      ));
    });

    return widgets;
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
