import 'package:get/get.dart';

import '../controllers/dynamic_employee_form_controller.dart';

class DynamicEmployeeFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicEmployeeFormController>(
      () => DynamicEmployeeFormController(),
    );
  }
}
