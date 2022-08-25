import 'dart:math';

import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsStateScreen();
}

class _EmployeeDetailsStateScreen extends State<EmployeeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool checkBox = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: colorPrimary,
          labelColor: colorPrimary,
          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: black,
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontFamily: 'semiBold',
          ),
          tabs: const [
            Tab(
              text: 'Personal Details',
            ),
            Tab(
              text: 'Services',
            ),
          ],
          labelStyle: const TextStyle(
            fontSize: 16,
            color: colorPrimary,
            fontFamily: 'bold',
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme: const IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const CustomText(
            text: 'Employee Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.transcribe_outlined)),
          )
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            Stack(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            width: width,
                            height: 100.0,
                            child: Row(
                              children: [
                                ClipRect(
                                  child: Image.asset(
                                    iconMale[Random().nextInt(iconMale.length)],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Flexible(
                                          child: CustomText(
                                            text: 'Name : John Dee',
                                            size: 14,
                                            fontfamily: 'semiBold',
                                          ),
                                        ),
                                        CustomText(
                                          text:
                                              'Email : jhondee@emaple.comdsvbdsbvsbsbsdbb',
                                          size: 14,
                                          fontfamily: 'semiBold',
                                        ),
                                        CustomText(
                                          text: 'Contact : +91 76009 72860',
                                          size: 14,
                                          fontfamily: 'semiBold',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Company : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: 'NaxFill Pvt. Ltd',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Transportation : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: 'Airport',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Designation : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: 'HR Executive',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      CustomText(
                                        text: 'Family Member : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      Flexible(
                                        child: CustomText(
                                          text:
                                              'Wife, Mother, Father, Children (2)',
                                          size: 14,
                                          fontfamily: 'medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Coming From : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      Flexible(
                                        child: CustomText(
                                          text: 'Ahmadabad',
                                          size: 14,
                                          fontfamily: 'medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Arrival Place : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: 'Delhi',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Arrival Date & Time : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: '20-05-2022 05:50 PM',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: const [
                                      CustomText(
                                        text: 'Other Information : ',
                                        size: 14,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: 'Reach hotel by itself',
                                        size: 14,
                                        fontfamily: 'medium',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: SizedBox(
                    height: 71,
                    width: 71,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(71),
                          )),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPressed: () {},
                      child: const Icon(
                        Icons.download_done_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'Employee have taken any services',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: black,
                            fontFamily: 'bold',
                          ),
                        ),
                        SizedBox(
                          width: width * 0.88,
                          child: Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                                activeColor: colorPrimary,
                                checkColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                          color: colorPrimary,
                                        )),
                                value: checkBox,
                                onChanged: (value) {
                                  setState(() {
                                    checkBox = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: CustomText(
                                    size: 16,
                                    color: checkBox ? colorPrimary : black,
                                    fontfamily:
                                        checkBox ? 'semiBold' : 'medium',
                                    text: "Transportation"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.88,
                          child: Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                                activeColor: colorPrimary,
                                checkColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                          color: colorPrimary,
                                        )),
                                value: checkBox,
                                onChanged: (value) {
                                  setState(() {
                                    checkBox = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: CustomText(
                                    size: 16,
                                    color: checkBox ? colorPrimary : black,
                                    fontfamily:
                                        checkBox ? 'semiBold' : 'medium',
                                    text: "Housing"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.88,
                          child: Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                                activeColor: colorPrimary,
                                checkColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                          color: colorPrimary,
                                        )),
                                value: checkBox,
                                onChanged: (value) {
                                  setState(() {
                                    checkBox = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: CustomText(
                                    size: 16,
                                    color: checkBox ? colorPrimary : black,
                                    fontfamily:
                                        checkBox ? 'semiBold' : 'medium',
                                    text: "School"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.88,
                          child: Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                                activeColor: colorPrimary,
                                checkColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                          color: colorPrimary,
                                        )),
                                value: checkBox,
                                onChanged: (value) {
                                  setState(() {
                                    checkBox = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: CustomText(
                                    size: 16,
                                    color: checkBox ? colorPrimary : black,
                                    fontfamily:
                                        checkBox ? 'semiBold' : 'medium',
                                    text: "PickUp"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: SizedBox(
                    height: 71,
                    width: 71,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(71),
                          )),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPressed: () {},
                      child: const Icon(
                        Icons.download_done_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
