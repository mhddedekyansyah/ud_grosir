import 'package:get/get.dart';

import '../controllers/read_grosir_controller.dart';

class ReadGrosirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadGrosirController>(
      () => ReadGrosirController(),
    );
  }
}
