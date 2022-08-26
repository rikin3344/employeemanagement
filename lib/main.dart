import 'dart:ffi';

import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/controller/menu_controller.dart';
import 'package:employeemanagement/controller/navigation_controller.dart';
import 'package:employeemanagement/helpers/local_navigator.dart';
import 'package:employeemanagement/layout.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.put(NavigationController());
  Get.put(MenuController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: loginRoute,
      defaultTransition: Transition.rightToLeft,
      getPages: [
        // GetPage(name: loginRoute, page: () => LoginScreen()),
        GetPage(
            name: rootRoute,
            page: () => localNavigator(),
            transition: Transition.rightToLeft)
      ],
      debugShowCheckedModeBanner: false,
      title: "",
      theme: ThemeData(
        scaffoldBackgroundColor: colorBackground,
        fontFamily: 'Hanuman',
        iconTheme: IconThemeData(color: black),
        textTheme:
            TextTheme(bodyText1: TextStyle(), bodyText2: TextStyle()).apply(
          bodyColor: black,
          displayColor: black,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        primaryColor: colorPrimary,
      ),
      // home: LoginScreen(),
    );
  }
}
