import 'package:get/get.dart';

import '../controllers/rental_request_controller.dart';

class RentalRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalRequestController>(() => RentalRequestController());
  }
}
