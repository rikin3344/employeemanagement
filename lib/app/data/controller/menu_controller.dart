import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = Routes.HOME.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case Routes.HOME:
        return _customIcon(Icons.work_rounded, itemName);
      case Routes.ADD_COMPANY:
        return _customIcon(Icons.work_rounded, itemName);
      case Routes.ADD_USER:
        return _customIcon(Icons.person_add_rounded, itemName);
      case Routes.ADD_EMPLOYEE:
        return _customIcon(Icons.assignment_ind_rounded, itemName);
      default:
        return _customIcon(Icons.pie_chart_rounded, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        color: gray,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName) ? black.withOpacity(0.7) : gray,
    );
  }
}
