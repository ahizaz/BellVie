import 'package:get/get.dart';
import '../data/popular_service_repository.dart';
import '../models/popular_service.dart';

class PopularServicesController extends GetxController {
  final PopularServiceRepository _repo = PopularServiceRepository();
  final RxList<PopularService> items = <PopularService>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      isLoading.value = true;
      final cached = await _repo.loadCachedCategories();
      if (cached.isNotEmpty) {
        items.assignAll(cached);
      }

      final result = await _repo.fetchCategories();
      if (result.isNotEmpty) {
        items.assignAll(result);
      }
    } catch (e) {
      // debugPrint('Popular services load error => $e');
    } finally {
      isLoading.value = false;
    }
  }
}
