import 'package:get/get.dart';

class HospitalItem {
  final String name;
  final String district;
  final String division;
  final String image;

  HospitalItem({
    required this.name,
    required this.district,
    required this.division,
    required this.image,
  });
}
class HospitalPackageController extends GetxController {
  final hospitals = <HospitalItem>[
    HospitalItem(
      name: 'Evercare Hospital Dhaka',
      district: 'Dhaka',
      division: 'Dhaka Division',
      image: 'assets/images/hospital_1.png',
    ),
    HospitalItem(
      name: 'Square Hospital Ltd.',
      district: 'Dhaka',
      division: 'Dhaka Division',
      image: 'assets/images/hospital_2.png',
    ),
  ].obs;
}