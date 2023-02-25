// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-employee/views/other_details_view.dart';
import 'package:addrec_employee_management/app/modules/add-employee/views/personal_details_view.dart';
import 'package:addrec_employee_management/app/modules/add-employee/views/service_details_view.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:addrec_employee_management/app/widgets/horizontal_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants/menu_item.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  late SharedPreferences pref;
  String name = '';
  String userId = '';
  String email = '';
  String roleId = '';
  String roleName = '';

  getPrefData() async {
    // pref = await SharedPreferences.getInstance();
  }

  getSharedPrefData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
      userId = pref.getString('userId')!;
      roleId = pref.getString('roleId')!;
      email = pref.getString('email')!;
      for (var i = 0; i < roleData.length; i++) {
        if (roleData[i].value == roleId) {
          setState(() {
            roleName = roleData[i].name;
          });
        }
      }
    });
  }

  @override
  void initState() {
    getPrefData();
    getSharedPrefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50.0)),
        ),
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(
                top: 0.0,
                left: 20,
              ),
              decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 128,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorSecondary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: CustomText(
                          text: roleName,
                          color: white,
                          fontfamily: "bold",
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    // verticalDirection: VerticalDirection.down,
                    // textDirection: TextDirection.ltr,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          iconMale[Random().nextInt(iconMale.length)],
                          width: 80,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, right: 010.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "ID : $userId",
                              size: 18,
                              color: white,
                              fontfamily: "semiBold",
                            ),
                            CustomText(
                              text: name,
                              size: 18,
                              color: white,
                              fontfamily: "semiBold",
                            ),
                            SizedBox(
                              width: 230,
                              child: Text(
                                email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: white,
                                  fontFamily: "medium",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, top: 15, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ADD_USER, arguments: 'edit');
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_note_rounded,
                                color: white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              CustomText(
                                text: "Edit Profile",
                                fontfamily: "semiBold",
                                size: 14,
                                color: white,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: CustomText(
                                      text: "Are you sure you want to logout!",
                                      fontfamily: 'bold',
                                      color: colorSecondary,
                                      size: 18,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                        child: CustomText(text: "CANCEL"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          pref.setBool('login', false);
                                          pref.clear();
                                          companyData = [];

                                          layoutPage = [
                                            PersonalDetailsView(),
                                            OtherDetailsView(),
                                          ];

                                          familyData = [];

                                          employeeServiceData = [];

                                          checkBoxValue = [];

                                          familyCheckBoxValue = [];

                                          employeeServiceValue = [];

                                          employeeServiceCheckBoxValue = [];

                                          selectedFamilyMember = [];
                                          selectedServices = [];

                                          familyList = [];
                                          serviceList = [];
                                          selectedEmployeeServices = [];

                                          employee = [];

                                          roleData = [];

                                          companyListConst = ['Company'];
                                          // Get.offAll(MyApp());
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                          Get.offAllNamed(Routes.LOGIN);
                                          // navigationController
                                          //     .navigateTO(loginRoute, []);
                                          // Get.offAll(localNavigator());
                                        },
                                        child: CustomText(
                                          text: "LOGOUT",
                                          color: colorPrimary,
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              CustomText(
                                text: "Logout",
                                fontfamily: "semiBold",
                                size: 14,
                                color: white,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.logout_rounded,
                                color: white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: sidebarItem(roleId),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> sidebarItem(roleId) {
  List<HorizontalMenuItem> element = [];
  if (roleId == '4') {
    for (var i = 0; i < employerMenuItem.length; i++) {
      element.add(HorizontalMenuItem(
        itemName: employerMenuItem[i].name,
        route: employerMenuItem[i].route,
        onTap: employerMenuItem[i].onTap,
      ));
    }
  } else {
    for (var i = 0; i < sideMenuItems.length; i++) {
      element.add(HorizontalMenuItem(
        itemName: sideMenuItems[i].name,
        route: sideMenuItems[i].route,
        onTap: sideMenuItems[i].onTap,
      ));
    }
  }

  return element;
}
