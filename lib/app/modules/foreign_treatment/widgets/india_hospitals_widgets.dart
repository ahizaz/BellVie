part of '../views/foreign_treatment_view.dart';

class _IndiaHospitalsTabBody extends StatelessWidget {
  final int index;
  const _IndiaHospitalsTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _IndiaHospitalsHome();
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

class _IndiaHospitalsHome extends StatelessWidget {
  const _IndiaHospitalsHome();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'india_hospitals'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                _HospitalTile(
                  hospital: 'Jaslok (All India)',
                  statusKey: 'status_done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Nanavati Max (All India)',
                  statusKey: 'status_done',
                  countText: 'Max Healthcare: 22',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Apollo pan India (All India)',
                  statusKey: 'status_done',
                  countText: '71',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'HCG pan India (All India)',
                  statusKey: 'status_done',
                  countText: '22',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'KIMS (All India)',
                  statusKey: 'status_done',
                  countText: '25',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Fortis pan India (All India)',
                  statusKey: 'status_done',
                  countText: '~28',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Fortis Raheja (All India)',
                  statusKey: 'status_done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Rainbow child Hospital (All India)',
                  statusKey: 'status_done',
                  countText: '10',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Manipal Whitefield Bangalore (All India)',
                  statusKey: 'status_done',
                  countText: '33',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Rela (All India)',
                  statusKey: 'status_done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Gangaram Delhi (All India)',
                  statusKey: 'status_through_doctor',
                  countText: '1*',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Wockhardt (All India)',
                  statusKey: 'status_pending',
                  countText: '4',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Lokmanya Pune (All India)',
                  statusKey: 'status_done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Birla IVF (All India)',
                  statusKey: 'status_done',
                  countText: '52',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Artemis (All India)',
                  statusKey: 'status_done',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Medanta (All India)',
                  statusKey: 'status_wip',
                  countText: '10',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Neurogeon. Stem cell (All India)',
                  statusKey: 'status_wip',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Stem RX stem cell (All India)',
                  statusKey: 'status_wip',
                  countText: '1',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Narayana Hrudayalaya (All India)',
                  statusKey: 'status_wip',
                  countText: '23',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Surya pan India (All India)',
                  statusKey: 'status_done',
                  countText: '4',
                ),
                SizedBox(height: 10),
                _HospitalTile(
                  hospital: 'Hiranandani (All India)',
                  statusKey: 'status_done',
                  countTextKey: 'status_not_publicly_aggregated',
                  countText: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HospitalTile extends StatelessWidget {
  final String hospital;
  final String statusKey;
  final String countText;
  final String? countTextKey;

  const _HospitalTile({
    required this.hospital,
    required this.statusKey,
    required this.countText,
    this.countTextKey,
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
            child: const Icon(Icons.local_hospital, color: Colors.black87),
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
                  'agreement_status'.trParams({'status': statusKey.tr}),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'public_number_of_hospitals'.trParams({
                    'countText': countTextKey?.tr ?? countText,
                  }),
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
