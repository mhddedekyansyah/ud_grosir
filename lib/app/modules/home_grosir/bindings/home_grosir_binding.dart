import 'package:get/get.dart';

import '../controllers/home_grosir_controller.dart';

class HomeGrosirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeGrosirController>(
      () => HomeGrosirController(),
    );
  }
}
