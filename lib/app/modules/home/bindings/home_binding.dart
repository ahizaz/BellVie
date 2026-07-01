import 'package:bellevie/app/modules/medical/controller/medical_controller.dart';
import 'package:bellevie/app/modules/notification/controller/notification_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../other_medical_service/controllers/categories_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());

    Get.put<NotificationController>(
      NotificationController(),
      permanent: true,
    );

    Get.put<MedicalRecordsController>(
      MedicalRecordsController(),
      permanent: true,
    );

    Get.lazyPut<OtherMedicalController>(
      () => OtherMedicalController(),
    );
  }
}