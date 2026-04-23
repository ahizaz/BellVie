import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../data/popular_service_repository.dart';
import '../models/popular_service.dart';

class PopularServicesController extends GetxController {
  final PopularServiceRepository _repo = PopularServiceRepository();
  final RxList<PopularService> items = <PopularService>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      EasyLoading.show();
      final result = await _repo.fetchCategories();
      items.assignAll(result);
      // debugPrint('Popular services loaded: ${result.length}');
    } catch (e) {
      // debugPrint('Popular services load error => $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
