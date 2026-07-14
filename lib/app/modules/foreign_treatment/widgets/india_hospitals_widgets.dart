
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
        return const _PlaceholderScreen(titleKey: 'my_appointments');
      case 2:
        return const _PlaceholderScreen(titleKey: 'my_health');
      case 3:
        return const _PlaceholderScreen(titleKey: 'cart');
      case 4:
        return const _PlaceholderScreen(titleKey: 'menu');
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
  static const bool _useApiHospitals = true;
  static const String _cachePrefix = 'foreign_treatment_hospitals_cache_v1_';
  final AppApiService _apiService = AppApiService();
  final List<_HospitalItem> _hospitals = <_HospitalItem>[];

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    if (_useApiHospitals) {
      _restoreCachedHospitals().then((hasCache) {
        _fetchHospitals(page: 1, showLoader: !hasCache);
      });
    } else {
      _hospitals
        ..clear()
        ..addAll(_staticHospitalsByCountry(widget.countryTitle));
      _isLoading = false;
      _isLoadingMore = false;
      _hasMore = false;
      _currentPage = 1;
    }
  }

  List<_HospitalItem> _staticHospitalsByCountry(String countryTitle) {
    final title = countryTitle.toLowerCase();

    if (title.contains('thailand')) {
      return const [
        _HospitalItem(
          id: 301,
          name: 'MedPark Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Cancer treatment (Oncology), Heart diseases (Cardiology), Brain and nerve disorders (Neurology), Bone and spine problems (Orthopedics), Kidney and liver transplant, Lung and respiratory diseases.',
          specialties: [
            'Cancer treatment (Oncology)',
            'Heart diseases (Cardiology)',
            'Brain and nerve disorders (Neurology)',
            'Bone and spine problems (Orthopedics)',
            'Kidney and liver transplant',
            'Lung and respiratory diseases',
          ],
          contacts: ['+66 2 090 3000', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 302,
          name: 'Sukhumvit Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Child treatment, Heart problems, Spine and joint surgery, Fertility treatment.',
          specialties: [
            'Child treatment',
            'Heart problems',
            'Spine and joint surgery',
            'Fertility treatment',
          ],
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 303,
          name: 'Nakhonthon Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Heart and Cardiovascular Center, Orthopedic and Joint Center, Fertility and Women\'s Health Center, Neurology and Stroke Care, Gastrointestinal and Liver Center, Child Health Center, Cancer and Surgery Services.',
          specialties: [
            'Heart and Cardiovascular Center',
            'Orthopedic and Joint Center',
            'Fertility and Women\'s Health Center',
            'Neurology and Stroke Care',
            'Gastrointestinal and Liver Center',
            'Child Health Center',
            'Cancer and Surgery Services',
          ],
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 304,
          name: 'Bangkok Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Heart treatment (angioplasty, bypass surgery), Cancer treatment, Brain and stroke care, Bone and joint replacement, Women\'s health and IVF, Liver and digestive treatment.',
          specialties: [
            'Heart treatment (angioplasty, bypass surgery)',
            'Cancer treatment',
            'Brain and stroke care',
            'Bone and joint replacement',
            'Women\'s health and IVF',
            'Liver and digestive treatment',
          ],
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 305,
          name: 'Bumrungrad International Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Pediatric (children) treatment, Maternity and fertility care, Advanced surgery with robotic technology, Medical tourism for international patients.',
          specialties: [
            'Pediatric (children) treatment',
            'Maternity and fertility care',
            'Advanced surgery with robotic technology',
            'Medical tourism for international patients',
          ],
          contacts: ['+66 2 066 8888', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 306,
          name: 'Samitivej Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Children\'s Hospital (Pediatrics), Heart and Vascular (Cardiology), Neurology and Neurosurgery, Gastroenterology and Liver Care, Plastic and Cosmetic Surgery, Preventive Health Checkups.',
          specialties: [
            'Children\'s Hospital (Pediatrics)',
            'Heart and Vascular (Cardiology)',
            'Neurology and Neurosurgery',
            'Gastroenterology and Liver Care',
            'Plastic and Cosmetic Surgery',
            'Preventive Health Checkups',
          ],
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 307,
          name: 'Vejthani Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description: 'Orthopedic and Spine, Heart Center.',
          specialties: [
            'Orthopedic and Spine',
            'Heart Center',
          ],
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 308,
          name: 'Phyathai 2 International Hospital',
          iconUrl: '',
          agreementStatus: 'Pending',
          publicHospitalCountText: 'N/A',
          bannerName: 'Preferred Hospital Partner',
          description:
              'Brain and Neurology Center, Orthopedic and Spine Center, Cancer Center, Fertility and IVF Center, Women\'s Health and Maternity Care, Pediatric Center.',
          specialties: [
            'Brain and Neurology Center',
            'Orthopedic and Spine Center',
            'Cancer Center',
            'Fertility and IVF Center',
            'Women\'s Health and Maternity Care',
            'Pediatric Center',
          ],
          contacts: ['+66 2 066 8888', 'N/A', 'N/A'],
        ),
      ];
    }

    if (title.contains('india')) {
      return const [
        _HospitalItem(
          id: 101,
          name: 'Jaslok (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 102,
          name: 'Nanavati Max (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '22',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 103,
          name: 'Apollo pan India (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '71',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 104,
          name: 'HCG pan India (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '22',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 105,
          name: 'KIMS (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '25',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 106,
          name: 'Fortis pan India (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '-28',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 107,
          name: 'Fortis Raheja (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 108,
          name: 'Rainbow child Hospital (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '10',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 109,
          name: 'Manipal Whitefield Bangalore (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '33',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 110,
          name: 'Rela (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 111,
          name: 'Gangaram Delhi (All India)',
          iconUrl: '',
          agreementStatus: 'Through Doctor',
          publicHospitalCountText: '1*',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 112,
          name: 'Wockhardt (All India)',
          iconUrl: '',
          agreementStatus: 'pending',
          publicHospitalCountText: '4',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 113,
          name: 'Lokmanya Pune (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 114,
          name: 'Birla IVF (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '52',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 115,
          name: 'Artemis (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 116,
          name: 'Medanta (All India)',
          iconUrl: '',
          agreementStatus: 'WIP',
          publicHospitalCountText: '10',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 117,
          name: 'Neurogeon. Stem cell (All India)',
          iconUrl: '',
          agreementStatus: 'WIP',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 118,
          name: 'Stem RX stem cell (All India)',
          iconUrl: '',
          agreementStatus: 'WIP',
          publicHospitalCountText: '1',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 119,
          name: 'Narayana Hrudayalaya (All India)',
          iconUrl: '',
          agreementStatus: 'WIP',
          publicHospitalCountText: '23',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 120,
          name: 'Surya pan India (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: '4',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
        _HospitalItem(
          id: 121,
          name: 'Hiranandani (All India)',
          iconUrl: '',
          agreementStatus: 'Done',
          publicHospitalCountText: 'Not publicly aggregated',
          bannerName: 'Preferred Hospital Partner',
          description: 'Hospital details will be available from API.',
          contacts: ['N/A', 'N/A', 'N/A'],
        ),
      ];
    }

    if (title.contains('china')) {
      return const [];
    }

    if (title.contains('turkey')) {
      return const [];
    }

    if (title.contains('singapore')) {
      return const [];
    }

    if (title.contains('malaysia')) {
      return const [];
    }

    return const [
      _HospitalItem(
        id: 999,
        name: 'Hospital information coming soon',
        iconUrl: '',
        agreementStatus: 'Pending',
        publicHospitalCountText: 'N/A',
        bannerName: 'Preferred Hospital Partner',
        description: 'Hospital information will be available soon.',
        contacts: ['N/A', 'N/A', 'N/A'],
      ),
    ];
  }

  String _resolveImageUrl(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }

  Future<void> _fetchHospitals({
    required int page,
    bool append = false,
    bool showLoader = true,
  }) async {
    if (!append && showLoader) {
      AppLoader.show(status: 'Loading hospitals...');
    }

    try {
      final response = await _apiService.get(
        path:
            '/api/v1/foreign-treatments/countries/${widget.countryId}/hospitals/?page=$page',
      );

      debugPrint('Hospital list page => $page');
      debugPrint('Hospital list status => ${response.statusCode}');
      debugPrint('Hospital list body => ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        AppLoader.showError('Hospital load failed. Please try again.');
        return;
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        AppLoader.showError('Invalid hospital response.');
        return;
      }

      final dynamic results = decoded['results'];
      if (results is! List) {
        AppLoader.showError('Invalid hospital data.');
        return;
      }

      final hasNextPage = decoded['next'] != null;

      final mapped = results
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => _HospitalItem(
              id: (item['id'] is int)
                  ? item['id'] as int
                  : int.tryParse((item['id'] ?? '').toString()) ?? 0,
              name: (item['name'] ?? '').toString(),
              nameBn: (item['name_bn'] ?? '').toString(),
              iconUrl: _resolveImageUrl((item['icon'] ?? '').toString()),
              agreementStatus: (item['agreement_status'] ?? 'N/A').toString(),
              publicHospitalCountText: item['public_hospital_count'] == null
                  ? 'N/A'
                  : (item['public_hospital_count']).toString(),
              specialties: [
                (item['speciality'] ?? item['specialty'] ?? '').toString(),
              ].map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
              specialtiesBn: [
                (item['speciality_bn'] ?? '').toString(),
              ].map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
              bannerName: (item['banner_name'] ?? item['banner'] ?? '')
                  .toString()
                  .trim(),
              description: (item['description'] ??
                      item['details'] ??
                      item['about'] ??
                      '')
                  .toString()
                  .trim(),
              contacts: _HospitalItem.extractContacts(item),
            ),
          )
          .where((item) => item.id > 0 && item.name.trim().isNotEmpty)
          .toList();

      final updatedList = append ? [..._hospitals, ...mapped] : mapped;

      if (!mounted) return;
      setState(() {
        _hospitals
          ..clear()
          ..addAll(updatedList);
        _hasMore = hasNextPage;
        _currentPage = page;
      });
      await _saveCachedHospitals(
        items: updatedList,
        hasMore: hasNextPage,
        currentPage: page,
      );
    } catch (e) {
      debugPrint('Hospital list fetch error => $e');
      AppLoader.showError(
          'Hospital load failed. Check internet and try again.');
    } finally {
      if (!append && AppLoader.isShow) {
        AppLoader.dismiss();
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _loadMoreHospitals() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);
    await _fetchHospitals(page: _currentPage + 1, append: true);
  }

  String get _cacheKey => '$_cachePrefix${widget.countryId}';

  Future<bool> _restoreCachedHospitals() async {
    final cached = await _loadCachedHospitals();
    if (!mounted || cached == null) return false;
    setState(() {
      _hospitals
        ..clear()
        ..addAll(cached.items);
      _hasMore = cached.hasMore;
      _currentPage = cached.currentPage;
      _isLoading = false;
      _isLoadingMore = false;
    });
    return cached.items.isNotEmpty;
  }

  Future<_HospitalCache?> _loadCachedHospitals() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      if (cachedJson == null || cachedJson.isEmpty) return null;

      final decoded = jsonDecode(cachedJson);
      if (decoded is! Map<String, dynamic>) return null;

      final rawItems = decoded['items'];
      if (rawItems is! List) return null;

      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .map(_hospitalFromJson)
          .where((item) => item.id > 0 && item.name.trim().isNotEmpty)
          .toList();

      final hasMore = decoded['hasMore'] == true;
      final currentPage = decoded['currentPage'] is int
          ? decoded['currentPage'] as int
          : int.tryParse((decoded['currentPage'] ?? '1').toString()) ?? 1;

      return _HospitalCache(
        items: items,
        hasMore: hasMore,
        currentPage: currentPage,
      );
    } catch (e) {
      debugPrint('Hospital cache read error => $e');
      return null;
    }
  }

  Future<void> _saveCachedHospitals({
    required List<_HospitalItem> items,
    required bool hasMore,
    required int currentPage,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode({
        'items': items.map(_hospitalToJson).toList(),
        'hasMore': hasMore,
        'currentPage': currentPage,
      });
      await prefs.setString(_cacheKey, encoded);
    } catch (e) {
      debugPrint('Hospital cache write error => $e');
    }
  }

  Map<String, dynamic> _hospitalToJson(_HospitalItem item) {
    return {
      'id': item.id,
      'name': item.name,
      'name_bn': item.nameBn,
      'iconUrl': item.iconUrl,
      'agreementStatus': item.agreementStatus,
      'publicHospitalCountText': item.publicHospitalCountText,
      'bannerName': item.bannerName,
      'description': item.description,
      'specialties': item.specialties,
      'specialties_bn': item.specialtiesBn,
      'contacts': item.contacts,
    };
  }

  _HospitalItem _hospitalFromJson(Map<String, dynamic> json) {
    return _HospitalItem(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse((json['id'] ?? '').toString()) ?? 0,
      name: (json['name'] ?? '').toString(),
      nameBn: (json['name_bn'] ?? '').toString(),
      iconUrl: (json['iconUrl'] ?? '').toString(),
      agreementStatus: (json['agreementStatus'] ?? '').toString(),
      publicHospitalCountText:
          (json['publicHospitalCountText'] ?? '').toString(),
      bannerName: (json['bannerName'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      specialties: (json['specialties'] is List)
          ? (json['specialties'] as List).map((e) => e.toString()).toList()
          : const <String>[],
      specialtiesBn: (json['specialties_bn'] is List)
          ? (json['specialties_bn'] as List).map((e) => e.toString()).toList()
          : const <String>[],
      contacts: (json['contacts'] is List)
          ? (json['contacts'] as List).map((e) => e.toString()).toList()
          : const <String>[],
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
                        itemCount: _hospitals.length + (_hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (_hasMore && index == _hospitals.length) {
                            return Center(
                              child: TextButton(
                                onPressed:
                                    _isLoadingMore ? null : _loadMoreHospitals,
                                child: _isLoadingMore
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'More',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                              ),
                            );
                          }

                          final item = _hospitals[index];
                          final normalizedCountryTitle =
                              widget.countryTitle.toLowerCase();
                          final isThailand =
                              normalizedCountryTitle.contains('thailand');
                          final isChina =
                              normalizedCountryTitle.contains('china') ||
                                  normalizedCountryTitle.contains('chaina');
                          final hasValidAgreementStatus =
                              item.agreementStatus.trim().isNotEmpty &&
                                  item.agreementStatus.trim().toLowerCase() !=
                                      'n/a';
                          return _HospitalTile(
                            hospital: item,
                            showAgreementStatus: !widget.countryTitle
                                    .toLowerCase()
                                    .contains('india') &&
                                !isThailand &&
                                !isChina &&
                                hasValidAgreementStatus,
                            showPublicHospitalCount: !isThailand,
                            onTap: () {
                              Get.to(
                                () => HospitalDetailsView(
                                  hospital: item,
                                  countryTitle: widget.countryTitle,
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _HospitalCache {
  final List<_HospitalItem> items;
  final bool hasMore;
  final int currentPage;

  const _HospitalCache({
    required this.items,
    required this.hasMore,
    required this.currentPage,
  });
}

class _HospitalItem {
  final int id;
  final String name;
  final String nameBn;
  final String iconUrl;
  final String agreementStatus;
  final String publicHospitalCountText;
  final String bannerName;
  final String description;
  final List<String> specialties;
  final List<String> specialtiesBn;
  final List<String> contacts;

  const _HospitalItem({
    required this.id,
    required this.name,
    this.nameBn = '',
    required this.iconUrl,
    required this.agreementStatus,
    required this.publicHospitalCountText,
    required this.bannerName,
    required this.description,
    this.specialties = const <String>[],
    this.specialtiesBn = const <String>[],
    required this.contacts,
  });

  String get resolvedBannerName =>
      bannerName.isNotEmpty ? bannerName : 'Preferred Hospital Partner';

  String get resolvedDescription => description.isNotEmpty
      ? description
      : 'Hospital description will appear here when available from API.';

  String get resolvedSpeciality {
    final merged =
        specialties.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (merged.isNotEmpty) {
      return merged.join(' | ');
    }
    final fallback = publicHospitalCountText.trim();
    return fallback.isNotEmpty ? fallback : 'N/A';
  }

  String resolvedSpecialityFor(String lang) {
    if (lang == 'bn') {
      final mergedBn = specialtiesBn
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (mergedBn.isNotEmpty) return mergedBn.join(' | ');
    }
    return resolvedSpeciality;
  }

  String resolvedNameFor(String lang) {
    if (lang == 'bn' && nameBn.trim().isNotEmpty) return nameBn.trim();
    return name.trim();
  }

  List<String> get resolvedContacts {
    final normalized = contacts
        .map((e) => e.trim())
        .where(
          (e) => e.isNotEmpty && e.toLowerCase() != 'n/a',
        )
        .toList();

    if (normalized.isNotEmpty) {
      return [normalized.first];
    }

    return const ['01805-464400'];
  }

  static List<String> extractContacts(Map<String, dynamic> raw) {
    final contacts = <String>[];

    void pushValue(dynamic value) {
      final text = (value ?? '').toString().trim();
      if (text.isNotEmpty) {
        contacts.add(text);
      }
    }

    final dynamic directContacts = raw['contacts'] ?? raw['contact_numbers'];
    if (directContacts is List) {
      for (final item in directContacts) {
        if (item is Map<String, dynamic>) {
          pushValue(item['number'] ?? item['phone'] ?? item['value']);
        } else {
          pushValue(item);
        }
      }
    }

    final dynamic contactInfo = raw['contact_info'];
    if (contactInfo is List) {
      for (final item in contactInfo) {
        if (item is Map<String, dynamic>) {
          pushValue(item['number'] ?? item['phone'] ?? item['value']);
        } else {
          pushValue(item);
        }
      }
    } else if (contactInfo is String) {
      final parts = contactInfo
          .split(RegExp(r'[\n,;|]'))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty);
      contacts.addAll(parts);
    }

    pushValue(raw['phone']);
    pushValue(raw['mobile']);
    pushValue(raw['hotline']);
    pushValue(raw['contact_number_1']);
    pushValue(raw['contact_number_2']);
    pushValue(raw['contact_number_3']);

    return contacts.toSet().toList();
  }
}

class _HospitalTile extends StatelessWidget {
  final _HospitalItem hospital;
  final bool showAgreementStatus;
  final bool showPublicHospitalCount;
  final VoidCallback onTap;

  const _HospitalTile({
    required this.hospital,
    required this.showAgreementStatus,
    this.showPublicHospitalCount = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
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
                child: hospital.iconUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: hospital.iconUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.local_hospital,
                          color: Colors.black87,
                        ),
                      )
                    : const Icon(Icons.local_hospital, color: Colors.black87),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (_) {
                    final lang = Get.find<HomeController>()
                        .currentLocale
                        .value
                        .languageCode;
                    final nameLabel = hospital.resolvedNameFor(lang);
                    final specs = lang == 'bn'
                        ? hospital.specialtiesBn
                        : hospital.specialties;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        if (specs.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            specs.join(' | '),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                  if (showAgreementStatus) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Agreement Status: ${hospital.agreementStatus}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  // Removed duplicate speciality display (it's shown above)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalDetailsView extends GetView<HomeController> {
  final _HospitalItem hospital;
  final String countryTitle;

  const HospitalDetailsView({
    super.key,
    required this.hospital,
    required this.countryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Column(
            children: [
              if (controller.tabIndex.value == 0) const _HomeTopBarClone(),
              Expanded(
                child: _HospitalDetailsTabBody(
                  index: controller.tabIndex.value,
                  hospital: hospital,
                  countryTitle: countryTitle,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _MainBottomNav(controller: controller),
      );
    });
  }
}

class _HospitalDetailsTabBody extends StatelessWidget {
  final int index;
  final _HospitalItem hospital;
  final String countryTitle;

  const _HospitalDetailsTabBody({
    required this.index,
    required this.hospital,
    required this.countryTitle,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _HospitalDetailsHome(
          hospital: hospital,
          countryTitle: countryTitle,
        );
      case 1:
        return const _PlaceholderScreen(titleKey: 'my_appointments');
      case 2:
        return const _PlaceholderScreen(titleKey: 'my_health');
      case 3:
        return const _PlaceholderScreen(titleKey: 'cart');
      case 4:
        return const _PlaceholderScreen(titleKey: 'menu');
      default:
        return const SizedBox.shrink();
    }
  }
}

class _HospitalDetailsHome extends StatelessWidget {
  final _HospitalItem hospital;
  final String countryTitle;

  const _HospitalDetailsHome({
    required this.hospital,
    required this.countryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            countryTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(builder: (_) {
                  final lang = Get.find<HomeController>()
                      .currentLocale
                      .value
                      .languageCode;
                  final localizedBanner = hospital.resolvedBannerName;
                  hospital.resolvedNameFor(lang);
                  return _HospitalBannerCard(
                    bannerName: localizedBanner,
                    iconUrl: hospital.iconUrl,
                  );
                }),
                const SizedBox(height: 12),
                Builder(builder: (_) {
                  final lang = Get.find<HomeController>()
                      .currentLocale
                      .value
                      .languageCode;
                  final localizedName = hospital.resolvedNameFor(lang);
                  return _HospitalInfoCard(
                    hospitalName: localizedName,
                    description: hospital.resolvedDescription,
                  );
                }),
                const SizedBox(height: 12),
                ...hospital.resolvedContacts
                    .map((number) => _HospitalContactCard(number: number)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HospitalBannerCard extends StatelessWidget {
  final String bannerName;
  final String iconUrl;

  const _HospitalBannerCard({
    required this.bannerName,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBFEFE2), Color(0xFFA8DED5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF8BC9BD)),
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
                  ? CachedNetworkImage(
                      imageUrl: iconUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.local_hospital,
                        color: Colors.black87,
                      ),
                    )
                  : const Icon(Icons.local_hospital, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              bannerName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HospitalInfoCard extends StatelessWidget {
  final String hospitalName;
  final String description;

  const _HospitalInfoCard({
    required this.hospitalName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFCFEDEA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB3DAD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hospital Name',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF446963),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            hospitalName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF446963),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.3,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _HospitalContactCard extends StatelessWidget {
  final String number;

  const _HospitalContactCard({
    required this.number,
  });

  Future<void> _openDialPad() async {
    final cleanedNumber = number.replaceAll(
      RegExp(r'[^0-9+]'),
      '',
    );

    if (cleanedNumber.isEmpty) return;

    final Uri phoneUri = Uri.parse('tel:$cleanedNumber');

    try {
      final bool opened = await launchUrl(
        phoneUri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened) {
        Get.snackbar(
          'Call failed',
          'Phone dial pad could not be opened.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      debugPrint('Dial pad error: $error');

      Get.snackbar(
        'Call failed',
        'Phone dial pad could not be opened.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _openDialPad,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD8D8D8),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.call,
                size: 18,
                color: Color(0xFF2D7F72),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
