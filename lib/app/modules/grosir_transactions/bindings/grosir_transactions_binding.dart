import 'package:get/get.dart';

import '../controllers/grosir_transactions_controller.dart';

class GrosirTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrosirTransactionsController>(
      () => GrosirTransactionsController(),
    );
  }
}
