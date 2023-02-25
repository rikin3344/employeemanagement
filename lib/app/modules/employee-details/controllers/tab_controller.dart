import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {

  static MyTabController instance = Get.find();
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
