import 'package:get/get.dart';

import '../controllers/employee_details_controller.dart';

class EmployeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeDetailsController>(
      () => EmployeeDetailsController(),
    );
  }
}
