import 'package:get/get.dart';

import '../controllers/manage_companies_controller.dart';

class ManageCompaniesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageCompaniesController>(
      () => ManageCompaniesController(),
    );
  }
}
