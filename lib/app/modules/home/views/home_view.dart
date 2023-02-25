import 'dart:math';

import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/home/views/dashboard_view.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:addrec_employee_management/app/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: colorBackground,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Obx(
                  () {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: controller.name.value,
                          size: 16,
                          fontfamily: "bold",
                        ),
                        Obx(
                          () => CustomText(
                            text: controller.roleName.value,
                            size: 12,
                            fontfamily: "medium",
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorBackground,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: black.withOpacity(0.25))
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    iconMale[Random().nextInt(iconMale.length)],
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      drawer: DrawerCustom(),
      body: Center(
        child: DashboardView(),
      ),
    );
  }
}
