part of '../views/foreign_treatment_view.dart';

class _ForeignTreatmentHome extends StatefulWidget {
  const _ForeignTreatmentHome();

  @override
  State<_ForeignTreatmentHome> createState() => _ForeignTreatmentHomeState();
}

class _ForeignTreatmentHomeState extends State<_ForeignTreatmentHome> {
  final AppApiService _apiService = AppApiService();
  final List<_CountryCardData> _countries = <_CountryCardData>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }

  String _fallbackAssetByName(String name) {
    final normalized = name.toLowerCase();
    if (normalized.contains('india')) return 'assets/images/Flag_of_India.png';
    if (normalized.contains('china')) return 'assets/images/Chaina.png';
    if (normalized.contains('thailand')) return 'assets/images/Thailand.jpg';
    if (normalized.contains('turkey')) return 'assets/images/Turkey.jpg';
    if (normalized.contains('singapore')) return 'assets/images/Singapore.jpg';
    if (normalized.contains('malaysia')) return 'assets/images/Malaysia.jpg';
    return 'assets/images/Flag_of_India.png';
  }

  Future<void> _fetchCountries() async {
    final token = AuthService.to.accessToken.value.trim();
    if (token.isEmpty) {
      debugPrint(
          'Foreign treatment view countries fetch skipped => token empty');
      EasyLoading.showError('Please login again.');
      if (mounted) {
        setState(() => _isLoading = false);
      }
      return;
    }

    EasyLoading.show(status: 'Loading countries...');

    try {
      final response = await _apiService.get(
        path: '/api/v1/foreign-treatments/countries/',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint(
          'Foreign treatment view countries status => ${response.statusCode}');
      debugPrint('Foreign treatment view countries body => ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        EasyLoading.showError('Country load failed. Please try again.');
        return;
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        EasyLoading.showError('Invalid country response.');
        return;
      }

      final dynamic results = decoded['results'];
      if (results is! List) {
        EasyLoading.showError('Invalid country data.');
        return;
      }

      final mapped = results
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => _CountryCardData(
              id: (item['id'] is int)
                  ? item['id'] as int
                  : int.tryParse((item['id'] ?? '').toString()) ?? 0,
              name: (item['name'] ?? '').toString(),
              imageUrl: _resolveImageUrl((item['flag'] ?? '').toString()),
              fallbackAssetPath:
                  _fallbackAssetByName((item['name'] ?? '').toString()),
            ),
          )
          .where((item) => item.id > 0 && item.name.trim().isNotEmpty)
          .toList();

      if (!mounted) return;
      setState(() {
        _countries
          ..clear()
          ..addAll(mapped);
      });
    } catch (e) {
      debugPrint('Foreign treatment view countries fetch error => $e');
      EasyLoading.showError(
          'Country load failed. Check internet and try again.');
    } finally {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openCountry(_CountryCardData item) {
    if (!AuthService.to.requireLogin()) return;

    Get.to(
      () => IndiaHospitalsView(
        countryId: item.id,
        countryTitle: item.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'foreign_treatment'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _countries.isEmpty
                    ? const Center(
                        child: Text(
                          'No country found.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: _countries.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.32,
                        ),
                        itemBuilder: (context, index) {
                          final item = _countries[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _openCountry(item),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCFEDEA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        height: 52,
                                        width: 72,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          child: item.imageUrl.isNotEmpty
                                              ? Image.network(
                                                  item.imageUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) {
                                                    return Image.asset(
                                                      item.fallbackAssetPath,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                )
                                              : Image.asset(
                                                  item.fallbackAssetPath,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      height: 1.15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _CountryCardData {
  final int id;
  final String name;
  final String imageUrl;
  final String fallbackAssetPath;

  const _CountryCardData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.fallbackAssetPath,
  });
}
