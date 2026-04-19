import '../models/specialist_doctor_item.dart';

class SpecialistDoctorsRepository {
  static const String _defaultDoctorImage = 'assets/images/Doctor Services.png';

  static final Map<String, List<SpecialistDoctorItem>>
      _staticDoctorsByCategory = {
    'internal_medicine': const [
      SpecialistDoctorItem(
        id: 'internal-3',
        name: 'Dr. Sumaiya Nowsheen Khan Panthoi',
        designation: 'Medicine (PGT) Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'internal-4',
        name: 'Dr MD.ABU HASNAN RUBEL',
        designation: 'Medicine Specialist',
        imageAssetPath: '',
      ),
    ],
    'general_physician': const [
      SpecialistDoctorItem(
        id: 'gp-1',
        name: 'Dr. Avishek Chakraborty',
        designation: 'MBBS',
        imageAssetPath: '',
      ),
    ],
    'neuromedicine': const [],
    'gastroenterology': const [],
    'urology': const [
      SpecialistDoctorItem(
        id: 'urology-1',
        name: 'Dr MD.Abdullah Alamin Shohan',
        designation: 'Urology Specialist',
        imageAssetPath: 'assets/images/drsohan.jpeg',
      ),
      SpecialistDoctorItem(
        id: 'urology-2',
        name: 'Dr MD.Ishtiaqul haque Mortuza',
        designation: 'Urology Specialist',
        imageAssetPath: 'assets/images/mortazadr.jpeg',
      ),
      SpecialistDoctorItem(
        id: 'urology-3',
        name: 'Dr.Shafiqur Rahman',
        designation: 'Urology Specialist',
        imageAssetPath: '',
      ),
    ],
    'oncology': const [
      SpecialistDoctorItem(
        id: 'onc-1',
        name: 'Dr MD.Rassell',
        designation: 'Surgical Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-2',
        name: 'Dr K.M.Sakib',
        designation: 'MS (Surgical Oncology) Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-3',
        name: 'Prof.Dr.Md.Khorshed Alam',
        designation: 'Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-4',
        name: 'Dr Altaf Hossain',
        designation: 'Clinical Oncology Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'onc-5',
        name: 'Dr Rifat Zia Hossain',
        designation: 'Oncology Specialist',
        imageAssetPath: '',
      ),
    ],
    'radio_therapy': const [
      SpecialistDoctorItem(
        id: 'rt-1',
        name: 'Dr Md.Waheed Akhtar',
        designation: 'Radiotherapy specialist',
        imageAssetPath: '',
      ),
    ],
    'rheumatology': const [],
    'cardiology': const [],
    'family_medicine': const [],
    'endocrinology': const [],
    'gynaecology_and_obstetrics': const [
      SpecialistDoctorItem(
        id: 'gyn-1',
        name: 'Dr. Sanjida Rezwana',
        designation: 'Gyn Specialist',
        imageAssetPath: '',
      ),
    ],
    'oral_and_maxillofacial_surgery': const [
      SpecialistDoctorItem(
        id: 'oms-1',
        name: 'Dr. Mausumi Iqbal',
        designation: 'Oral & Maxillofacial Surgery Specialist',
        imageAssetPath: '',
      ),
      SpecialistDoctorItem(
        id: 'oms-2',
        name: 'Dr Mezbah ul Azeez',
        designation: 'Periodontology Specialist',
        imageAssetPath: 'assets/images/drmezbah.jpeg',
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
