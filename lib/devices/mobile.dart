import 'dart:math';

import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
              width: width * 0.9,
              height: 60,
              decoration: BoxDecoration(
                color: colorPrimary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: white,
                  fontSize: 18,
                  fontFamily: 'medium',
                ),
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: white,
                    size: 30,
                  ),
                  hintText: 'Find your stuff!!',
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: white.withOpacity(0.8),
                    fontSize: 18,
                    fontFamily: 'medium',
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.9,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 05.0),
              child: const CustomText(
                text: 'Your Stastics!',
                size: 20,
                fontfamily: 'semiBold',
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(right: 27.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i <= 10; i++)
                    Container(
                      margin: const EdgeInsets.only(left: 27.0),
                      padding: const EdgeInsets.all(10),
                      width: width * 0.45,
                      height: width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              colorPrimary.withOpacity(0.95),
                              colorPrimary.withOpacity(0.3)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: white,
                                      size: 30,
                                    ))
                              ],
                            ),
                            const CustomText(
                              text: '100',
                              size: 40,
                              color: white,
                              fontfamily: 'semiBold',
                            ),
                            const CustomText(
                              text: 'Total Employee',
                              size: 20,
                              color: white,
                              fontfamily: 'semiBold',
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Today's Scheduled",
                    size: 20,
                    fontfamily: 'semiBold',
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colorSecondary.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(71),
                          )),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add_rounded,
                            size: 18,
                          ),
                          CustomText(
                            text: 'ADD',
                            size: 12,
                            color: white,
                            fontfamily: 'semiBold',
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              width: width * 0.9,
              child: Column(
                children: [
                  for (int i = 0; i <= 10; i++)
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: width * 0.9,
                        margin: const EdgeInsets.only(bottom: 14.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 80,
                        decoration: BoxDecoration(
                            color: grayExtraLight,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  offset: const Offset(0, 1.5),
                                  color: black.withOpacity(0.25))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                iconMale[Random().nextInt(iconMale.length)],
                                width: 55.0,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: 'Rikin Patel',
                                  size: 18,
                                  color: colorPrimary.withOpacity(0.9),
                                  fontfamily: 'semiBold',
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 3.0),
                                  child: CustomText(
                                    text: 'TATA Consultancy Services',
                                    size: 12,
                                    color: black,
                                    fontfamily: 'medium',
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  // Get.to(EmployeeDetailsScreen());
                                  // generateRoute( navigationController.navigateTO(employeeDetailsScreenRoute););
                                  navigationController
                                      .navigateTO(employeeDetailsScreenRoute);
                                  // getPageNavigation(EmployeeDetailsScreen());
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 30.0,
                                  color: colorPrimary,
                                ))
                          ],
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
