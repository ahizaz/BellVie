import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class TopDoctorsSection extends StatelessWidget {
  const TopDoctorsSection({super.key});

  static const List<_DoctorItem> _doctors = [
    _DoctorItem(
      initials: 'RK',
      name: 'Dr. Rashid Khan',
      specialty: 'Cardiologist',
      rating: 4.9,
      years: 12,
    ),
    _DoctorItem(
      initials: 'SN',
      name: 'Dr. Sara Naser',
      specialty: 'Oncologist',
      rating: 4.8,
      years: 9,
    ),
    _DoctorItem(
      initials: 'AH',
      name: 'Dr. Ayaan Hossain',
      specialty: 'Neurologist',
      rating: 4.7,
      years: 10,
    ),
    _DoctorItem(
      initials: 'LM',
      name: 'Dr. Lina Mirza',
      specialty: 'Dermatologist',
      rating: 4.6,
      years: 7,
    ),
  ];

  void _openDoctors() {
    Get.toNamed(Routes.SPECIALIST_DOCTORS);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Top Doctors',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _openDoctors,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FED),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFF2F6FED),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _doctors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _TopDoctorCard(
                doctor: _doctors[index],
                onTap: _openDoctors,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TopDoctorCard extends StatelessWidget {
  final _DoctorItem doctor;
  final VoidCallback onTap;

  const _TopDoctorCard({
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 175,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFBEE9FF),
              Color(0xFFDFF8EF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33FFFFFF),
              offset: Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(3, 3),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF2F6FED),
                  child: Text(
                    doctor.initials,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26C281),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              doctor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              doctor.specialty,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: Color(0xFFF4B400),
                ),
                const SizedBox(width: 4),
                Text(
                  doctor.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${doctor.years} yrs',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorItem {
  final String initials;
  final String name;
  final String specialty;
  final double rating;
  final int years;

  const _DoctorItem({
    required this.initials,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.years,
  });
}
