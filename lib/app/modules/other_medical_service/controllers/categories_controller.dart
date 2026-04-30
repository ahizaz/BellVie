import 'package:get/get.dart';
import 'package:bellevie/app/services/app_loader.dart';
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
      AppLoader.show();
      final result = await _repo.fetchCategories();
      items.assignAll(result);
    } catch (e) {
      //debugPrint('Other medical categories load error => $e');
    } finally {
      AppLoader.dismiss();
    }
  }
}
