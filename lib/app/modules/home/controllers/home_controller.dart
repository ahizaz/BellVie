import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt tabIndex = 0.obs;

  bool changeTab(int index) {
    tabIndex.value = index;
    return true;
  }
}
