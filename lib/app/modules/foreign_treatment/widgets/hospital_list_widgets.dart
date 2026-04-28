part of '../views/foreign_treatment_view.dart';

class _HospitalListTabBody extends StatelessWidget {
  final int index;
  final List<String> hospitals;

  const _HospitalListTabBody({
    required this.index,
    required this.hospitals,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _HospitalListHome(hospitals: hospitals);
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

class _HospitalListHome extends StatelessWidget {
  final List<String> hospitals;

  const _HospitalListHome({
    required this.hospitals,
  });

  Widget _hospitalCard(String hospital) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // pore details page add korba
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFCFEDEA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            hospital,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: ListView.separated(
        itemCount: hospitals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return _hospitalCard(hospitals[index]);
        },
      ),
    );
  }
}

class _BlankCountryTabBody extends StatelessWidget {
  final int index;

  const _BlankCountryTabBody({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const SizedBox.shrink();
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
