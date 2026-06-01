import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class BannerDetailPage extends StatefulWidget {
  final String? bannerId;
  final Map<String, dynamic>? initialData;

  const BannerDetailPage({super.key, this.bannerId, this.initialData});

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
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show banner image and phone pill when available
                          ..._buildImageSection(),

                          // Show textual fields from API
                          ..._buildInfoWidgets(),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  List<Widget> _buildImageSection() {
    if (_data == null) return [];
    final imageVal = _data?['image'] ?? _data?['image_url'] ?? _data?['photo'];
    final phone = (_data?['phone'] ?? _data?['contact'] ?? '').toString();
    final url = imageVal?.toString();
    if (url == null || url.isEmpty) return [];

    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              color: Colors.grey[200],
              child: const Center(child: Icon(Icons.broken_image)),
            ),
            loadingBuilder: (c, child, progress) {
              if (progress == null) return child;
              return Container(
                color: Colors.grey[100],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
      const SizedBox(height: 12),
      if (phone.isNotEmpty)
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.green.shade700, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Text(phone,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildInfoWidgets() {
    if (_data == null) return [];
    final widgets = <Widget>[];

    // Common label candidates
    final title = (_data?['title'] ?? _data?['heading'] ?? '').toString();
    final desc = (_data?['description'] ?? _data?['detail'] ?? '').toString();
    final phone = (_data?['phone'] ?? _data?['contact'] ?? '').toString();

    if (title.isNotEmpty) {
      widgets.add(Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)));
      widgets.add(const SizedBox(height: 8));
    }

    if (desc.isNotEmpty) {
      widgets.add(Text(desc,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(height: 1.4, color: Colors.black87)));
      widgets.add(const SizedBox(height: 8));
    }

    if (phone.isNotEmpty) {
      widgets.add(InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Calling $phone')),
          );
        },
        child: Row(
          children: [
            const Icon(Icons.phone, size: 18),
            const SizedBox(width: 8),
            Text(phone,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.blueAccent)),
          ],
        ),
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

      // render services as chips when possible
      if (key.toLowerCase().contains('service')) {
        final items = <String>[];
        if (value is List) {
          for (final v in value) {
            final t = v?.toString() ?? '';
            if (t.isNotEmpty) items.add(t.trim());
          }
        } else {
          var raw = s;
          if (raw.startsWith('[') && raw.endsWith(']')) {
            raw = raw.substring(1, raw.length - 1);
          }
          items.addAll(
              raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
        }

        if (items.isNotEmpty) {
          widgets.add(Text('${_capitalize(key)}:',
              style: const TextStyle(fontWeight: FontWeight.w600)));
          widgets.add(const SizedBox(height: 8));
          widgets.add(Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map((t) => Chip(
                      label: Text(t),
                      backgroundColor: Colors.grey[100],
                    ))
                .toList(),
          ));
          widgets.add(const SizedBox(height: 8));
        }
      } else {
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
      }
    });

    return widgets;
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
