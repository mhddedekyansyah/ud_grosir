import 'package:get/get.dart';

import '../controllers/read_product_controller.dart';

class ReadProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadProductController>(
      () => ReadProductController(),
    );
  }
}
