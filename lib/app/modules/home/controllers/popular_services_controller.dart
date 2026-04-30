import 'package:get/get.dart';
import 'package:bellevie/app/services/app_loader.dart';
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
      AppLoader.show();
      final result = await _repo.fetchCategories();
      items.assignAll(result);
    } catch (e) {
      // debugPrint('Popular services load error => $e');
    } finally {
      AppLoader.dismiss();
    }
  }
}
