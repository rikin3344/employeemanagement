import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  // Map<dynamic, dynamic> arguments = [] as Map;

  Future<dynamic> navigateTO(routeName, arguments) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
    // return Get.toNamed(routeName);
  }

  Future<dynamic> navigateTOPush(widget) {
    return navigationKey.currentState!.push(widget);
    // return Get.toNamed(routeName);
  }

  Future<dynamic> navigateTOandOffRoute(routeName) {
    return navigationKey.currentState!.pushReplacementNamed(routeName);
    // return Get.toNamed(routeName);
  }

  goBack() => navigationKey.currentState!.pop();
}
