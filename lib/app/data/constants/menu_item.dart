import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MenuItem {
  final String route;
  final String name;
  final Function onTap;

  MenuItem(this.route, this.onTap, this.name);
}

List<MenuItem> employerMenuItem = [
  MenuItem(
    Routes.HOME,
    () {
      Get.back();
    },
    'Dashboard',
  ),
  MenuItem(
    Routes.ADD_EMPLOYEE,
    () {
      Get.toNamed(Routes.DYNAMIC_EMPLOYEE_FORM);
    },
    'Add Employee',
  ),
];

List<MenuItem> sideMenuItems = [
  MenuItem(
    Routes.HOME,
    () {
      Get.back();
    },
    'Dashboard',
  ),
  MenuItem(
    Routes.ADD_COMPANY,
    () {
      Get.toNamed(Routes.ADD_COMPANY);
    },
    'Add Company',
  ),
  MenuItem(
    Routes.MANAGE_COMPANIES,
    () {
      Get.toNamed(Routes.MANAGE_COMPANIES);
    },
    'Manage Company',
  ),
  MenuItem(
    Routes.ADD_USER,
    () {
      Get.toNamed(Routes.ADD_USER);
    },
    'Add User',
  ),
  // MenuItem(
  //   Routes.MANAGE_USER,
  //   () {
  //     Get.toNamed(Routes.MANAGE_USER);
  //   },
  //   'Manage User',
  // ),
  MenuItem(
    Routes.ADD_EMPLOYEE,
    () {
      Get.toNamed(Routes.DYNAMIC_EMPLOYEE_FORM);
    },
    'Add Employee',
  ),
];
