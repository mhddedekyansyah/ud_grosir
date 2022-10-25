import 'package:get/get.dart';

import '../controllers/edit_grosir_controller.dart';

class EditGrosirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditGrosirController>(
      () => EditGrosirController(),
    );
  }
}
