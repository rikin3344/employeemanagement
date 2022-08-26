import 'dart:math';

import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/devices/desktop.dart';
import 'package:employeemanagement/devices/mobile.dart';
import 'package:employeemanagement/devices/tablet.dart';
import 'package:employeemanagement/helpers/responsive.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:employeemanagement/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  late SharedPreferences pref;
  String name = '';
  getSharedPrefData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    });
  }

  @override
  void initState() {
    getSharedPrefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: colorBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: name,
                      size: 16,
                      fontfamily: "bold",
                    ),
                    CustomText(
                      text: "Project Manager",
                      size: 12,
                      fontfamily: "medium",
                    ),
                  ],
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
      body: const SafeArea(
        child: ResponsiveWidget(
            largeScreen: DesktopScreen(),
            mediumScreen: TabletScreen(),
            smallScreen: MobileScreen()),
      ),
    );
  }
}
