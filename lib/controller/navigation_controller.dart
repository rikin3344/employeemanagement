import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTO(routeName) {
    return navigationKey.currentState!.pushNamed(routeName);
    // return Get.toNamed(routeName);
  }

  Future<dynamic> navigateTOandOffRoute(routeName) {
    return navigationKey.currentState!.pushReplacementNamed(routeName);
    // return Get.toNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
