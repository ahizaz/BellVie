import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../data/category_repository.dart';
import '../models/category.dart';

class OtherMedicalController extends GetxController {
  final OtherMedicalRepository _repo = OtherMedicalRepository();
  final RxList<OtherMedicalCategory> items = <OtherMedicalCategory>[].obs;

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
      //debugPrint('Other medical categories loaded: ${result.length}');
    } catch (e) {
      //debugPrint('Other medical categories load error => $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
