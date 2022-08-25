import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = dashboardDetailsScreen.obs;
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
      case dashboardDetailsScreen:
        return _customIcon(Iconsax.chart_3, itemName);
      case addCompanyScreen:
        return _customIcon(Iconsax.briefcase4, itemName);
      case addManagerScreen:
        return _customIcon(Iconsax.user4, itemName);
      case addEmployerScreen:
        return _customIcon(Iconsax.user_add, itemName);
      case addEmployeeScreen:
        return _customIcon(Iconsax.user_add, itemName);
      case notificationScreen:
        return _customIcon(Iconsax.notification, itemName);
      default:
        return _customIcon(Iconsax.chart_3, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        color: white,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName) ? black.withOpacity(0.7) : gray,
    );
  }
}
