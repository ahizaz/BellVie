import '../models/specialist_doctor_item.dart';

class SpecialistDoctorsRepository {
  static const String _defaultDoctorImage = 'assets/images/Doctor Services.png';

  static final Map<String, List<SpecialistDoctorItem>>
      _staticDoctorsByCategory = {
    'neuromedicine': const [
      SpecialistDoctorItem(
        id: 'neuro-1',
        name: 'Dr. Arif Hasan',
        designation: 'Consultant, Neuromedicine',
        imageAssetPath: 'assets/images/special doctors/4.Neuromedicine.png',
      ),
      SpecialistDoctorItem(
        id: 'neuro-2',
        name: 'Dr. Nabila Rahman',
        designation: 'Associate Consultant, Neuromedicine',
        imageAssetPath: 'assets/images/special doctors/4.Neuromedicine.png',
      ),
      SpecialistDoctorItem(
        id: 'neuro-3',
        name: 'Dr. Fahim Kabir',
        designation: 'Senior Registrar, Neuromedicine',
        imageAssetPath: 'assets/images/special doctors/4.Neuromedicine.png',
      ),
    ],
    'gastroenterology': const [
      SpecialistDoctorItem(
        id: 'gastro-1',
        name: 'Dr. Tanvir Ahmed',
        designation: 'Consultant, Gastroenterology',
        imageAssetPath: 'assets/images/special doctors/Gastroenterology.png',
      ),
      SpecialistDoctorItem(
        id: 'gastro-2',
        name: 'Dr. Samia Sultana',
        designation: 'Associate Consultant, Gastroenterology',
        imageAssetPath: 'assets/images/special doctors/Gastroenterology.png',
      ),
      SpecialistDoctorItem(
        id: 'gastro-3',
        name: 'Dr. Omar Faruq',
        designation: 'Specialist, Hepatology & Gastro',
        imageAssetPath: 'assets/images/special doctors/Gastroenterology.png',
      ),
    ],
  };

  Future<List<SpecialistDoctorItem>> getDoctorsByCategory({
    required String categoryKey,
    String? categoryAssetPath,
  }) async {
    final selected = _staticDoctorsByCategory[categoryKey];
    if (selected != null) {
      return selected;
    }

    final fallbackImage =
        (categoryAssetPath != null && categoryAssetPath.isNotEmpty)
            ? categoryAssetPath
            : _defaultDoctorImage;

    return [
      SpecialistDoctorItem(
        id: '$categoryKey-1',
        name: 'Dr. Ahsan Karim',
        designation: 'Consultant Specialist',
        imageAssetPath: fallbackImage,
      ),
      SpecialistDoctorItem(
        id: '$categoryKey-2',
        name: 'Dr. Nusrat Jahan',
        designation: 'Associate Consultant',
        imageAssetPath: fallbackImage,
      ),
    ];
  }
}
