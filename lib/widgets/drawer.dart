// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/helpers/menu_item.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:employeemanagement/widgets/horizontal_menu_item.dart';
import 'package:employeemanagement/widgets/side_bar_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      width: 350,
      backgroundColor: Colors.transparent,
      child: Expanded(
          child: Container(
        decoration: const BoxDecoration(
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
              decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
                          color: colorSecondary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: const CustomText(
                          text: "Contributor",
                          color: white,
                          fontfamily: "bold",
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                          children: const [
                            CustomText(
                              text: "ID : 154875",
                              size: 18,
                              color: white,
                              fontfamily: "semiBold",
                            ),
                            CustomText(
                              text: "John Dee",
                              size: 18,
                              color: white,
                              fontfamily: "semiBold",
                            ),
                            CustomText(
                              text: "jhonedee124@example.com",
                              size: 14,
                              color: white,
                              fontfamily: "medium",
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
                        Row(
                          children: const [
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
                        InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const CustomText(
                                      text: "Are you sure you want to logout!",
                                      fontfamily: 'bold',
                                      color: colorSecondary,
                                      size: 18,
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                        },
                                        child: const CustomText(text: "CANCEL"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Get.offAllNamed(loginRoute);
                                        },
                                        child: const CustomText(
                                          text: "LOGOUT",
                                          color: colorPrimary,
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: const [
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
              children: sidebarItem(),
            )
          ],
        ),
      )),
    );
  }
}

List<Widget> sidebarItem() {
  List<HorizontalMenuItem> element = [];
  for (var i = 0; i < sideMenuItems.length; i++) {
    element.add(HorizontalMenuItem(
      itemName: sideMenuItems[i].name,
      route: sideMenuItems[i].route,
      onTap: sideMenuItems[i].onTap,
    ));
  }
  return element;
}
