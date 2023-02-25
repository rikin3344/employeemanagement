import 'package:get/get.dart';

import '../controllers/add_company_controller.dart';

class AddCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCompanyController>(
      () => AddCompanyController(),
    );
  }
}
