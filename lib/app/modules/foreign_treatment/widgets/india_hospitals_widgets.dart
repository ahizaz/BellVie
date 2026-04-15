part of '../views/foreign_treatment_view.dart';

class _IndiaHospitalsTabBody extends StatelessWidget {
  final int index;
  final int countryId;
  final String countryTitle;

  const _IndiaHospitalsTabBody({
    required this.index,
    required this.countryId,
    required this.countryTitle,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _IndiaHospitalsHome(
          countryId: countryId,
          countryTitle: countryTitle,
        );
      case 1:
        return _PlaceholderScreen(titleKey: 'my_appointments');
      case 2:
        return _PlaceholderScreen(titleKey: 'my_health');
      case 3:
        return _PlaceholderScreen(titleKey: 'cart');
      case 4:
        return _PlaceholderScreen(titleKey: 'menu');
      default:
        return const SizedBox.shrink();
    }
  }
}

class _IndiaHospitalsHome extends StatefulWidget {
  final int countryId;
  final String countryTitle;

  const _IndiaHospitalsHome({
    required this.countryId,
    required this.countryTitle,
  });

  @override
  State<_IndiaHospitalsHome> createState() => _IndiaHospitalsHomeState();
}

class _IndiaHospitalsHomeState extends State<_IndiaHospitalsHome> {
  final AppApiService _apiService = AppApiService();
  final List<_HospitalItem> _hospitals = <_HospitalItem>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }

  Future<void> _fetchHospitals() async {
    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      debugPrint('Hospital fetch skipped => token empty');
      EasyLoading.showError('Please login again.');
      if (mounted) {
        setState(() => _isLoading = false);
      }
      return;
    }

    EasyLoading.show(status: 'Loading hospitals...');

    try {
      final response = await _apiService.get(
        path:
            '/api/v1/foreign-treatments/countries/${widget.countryId}/hospitals/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Hospital list status => ${response.statusCode}');
      debugPrint('Hospital list body => ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        EasyLoading.showError('Hospital load failed. Please try again.');
        return;
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        EasyLoading.showError('Invalid hospital response.');
        return;
      }

      final dynamic results = decoded['results'];
      if (results is! List) {
        EasyLoading.showError('Invalid hospital data.');
        return;
      }

      final mapped = results
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => _HospitalItem(
              id: (item['id'] is int)
                  ? item['id'] as int
                  : int.tryParse((item['id'] ?? '').toString()) ?? 0,
              name: (item['name'] ?? '').toString(),
              iconUrl: _resolveImageUrl((item['icon'] ?? '').toString()),
              agreementStatus: (item['agreement_status'] ?? 'N/A').toString(),
              publicHospitalCountText: item['public_hospital_count'] == null
                  ? 'N/A'
                  : (item['public_hospital_count']).toString(),
            ),
          )
          .where((item) => item.id > 0 && item.name.trim().isNotEmpty)
          .toList();

      if (!mounted) return;
      setState(() {
        _hospitals
          ..clear()
          ..addAll(mapped);
      });
    } catch (e) {
      debugPrint('Hospital list fetch error => $e');
      EasyLoading.showError(
          'Hospital load failed. Check internet and try again.');
    } finally {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.countryTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hospitals.isEmpty
                    ? const Center(
                        child: Text(
                          'No hospitals found.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _hospitals.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = _hospitals[index];
                          return _HospitalTile(
                            hospital: item.name,
                            statusText: item.agreementStatus,
                            countText: item.publicHospitalCountText,
                            iconUrl: item.iconUrl,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _HospitalItem {
  final int id;
  final String name;
  final String iconUrl;
  final String agreementStatus;
  final String publicHospitalCountText;

  const _HospitalItem({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.agreementStatus,
    required this.publicHospitalCountText,
  });
}

class _HospitalTile extends StatelessWidget {
  final String hospital;
  final String statusText;
  final String countText;
  final String iconUrl;

  const _HospitalTile({
    required this.hospital,
    required this.statusText,
    required this.countText,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFBFEFE2),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: iconUrl.isNotEmpty
                  ? Image.network(
                      iconUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                          Icons.local_hospital,
                          color: Colors.black87),
                    )
                  : const Icon(Icons.local_hospital, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Agreement Status: $statusText',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Public Number of Hospitals: $countText',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black38),
        ],
      ),
    );
  }
}
