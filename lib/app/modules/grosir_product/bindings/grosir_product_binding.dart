import 'package:get/get.dart';

import '../controllers/grosir_product_controller.dart';

class GrosirProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrosirProductController>(
      () => GrosirProductController(),
    );
  }
}
