import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem {
  final String route;
  final String name;
  final Function onTap;

  MenuItem(this.route, this.name, this.onTap);
}

List<MenuItem> sideMenuItems = [
  MenuItem(dashboardDetailsScreenRoute, dashboardDetailsScreen, () {
    navigationController.navigateTO(dashboardDetailsScreenRoute, []);
  }),
  MenuItem(addCompanyScreenRoute, addCompanyScreen, () {
    navigationController.navigateTO(addCompanyScreenRoute, []);
  }),
  MenuItem(addManagerScreenRoute, addManagerScreen, () {
    navigationController.navigateTO(addManagerScreenRoute, []);
  }),
  // MenuItem(addEmployerScreenRoute, addEmployerScreen, () {}),
  MenuItem(addEmployeeScreenRoute, addEmployeeScreen, () {
    navigationController.navigateTO(addEmployeeScreenRoute, []);
  }),
  MenuItem(notificationScreenRoute, notificationScreen, () {}),
];
