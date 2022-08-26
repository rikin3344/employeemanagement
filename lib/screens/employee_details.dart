import 'dart:math';

import 'package:employeemanagement/constants/api_client.dart';
import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/model/employee_details_model.dart';
import 'package:employeemanagement/model/employee_model.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final Map<dynamic, dynamic> arguments;
  const EmployeeDetailsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsStateScreen();
}

class _EmployeeDetailsStateScreen extends State<EmployeeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Datum data;
  late Future<EmployeeDetailsModel> detailsModel;
  bool checkBox = false;
  @override
  void initState() {
    setState(() {
      data = widget.arguments['employeeId'];
    });
    detailsModel = getEmployeeDetails(data.id);
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
            FutureBuilder(
              future: detailsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  EmployeeDetailsModel model =
                      snapshot.data as EmployeeDetailsModel;
                  String familyMember = '';
                  for (var i = 0; i < model.data.familyMembers.length; i++) {
                    if (familyMember == '') {
                      familyMember = model.data.familyMembers[i].familyMember;
                    } else {
                      familyMember =
                          '$familyMember, ${model.data.familyMembers[i].familyMember}';
                    }
                  }
                  return Stack(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  width: width,
                                  height: 100.0,
                                  child: Row(
                                    children: [
                                      ClipRect(
                                        child: Image.asset(
                                          iconMale[Random()
                                              .nextInt(iconMale.length)],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                child: CustomText(
                                                  text:
                                                      'Name : ${model.data.firstName} ${model.data.lastName}',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                              ),
                                              CustomText(
                                                text:
                                                    'Email : ${model.data.email}',
                                                size: 14,
                                                fontfamily: 'semiBold',
                                              ),
                                              CustomText(
                                                text:
                                                    'Contact : ${model.data.contactNumber}',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'Company : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text: model.data.company.name,
                                              size: 14,
                                              fontfamily: 'medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'Transportation : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text: model.data.travelBy,
                                              size: 14,
                                              fontfamily: 'medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'Designation : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text: model.data.designation,
                                              size: 14,
                                              fontfamily: 'medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomText(
                                              text: 'Family Member : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            Flexible(
                                              child: CustomText(
                                                text: familyMember,
                                                size: 14,
                                                fontfamily: 'medium',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'Arrival Place : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text: model.data.arrivalPlace,
                                              size: 14,
                                              fontfamily: 'medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const CustomText(
                                              text: 'Arrival Date & Time : ',
                                              size: 14,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text:
                                                  '${model.data.arrivalDate.toString()} ${model.data.arrivalTime}',
                                              size: 14,
                                              fontfamily: 'medium',
                                            ),
                                          ],
                                        ),
                                      ),
                                      model.data.note != ''
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Row(
                                                children: [
                                                  const CustomText(
                                                    text:
                                                        'Other Information : ',
                                                    size: 14,
                                                    fontfamily: 'semiBold',
                                                  ),
                                                  CustomText(
                                                    text: model.data.note,
                                                    size: 14,
                                                    fontfamily: 'medium',
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
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
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
            FutureBuilder(
              future: detailsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  EmployeeDetailsModel model =
                      snapshot.data as EmployeeDetailsModel;
                  return Stack(
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
                              for (int i = 0;
                                  i < model.data.services.length;
                                  i++)
                                SizedBox(
                                  width: width * 0.88,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: BorderSide.none),
                                        activeColor: colorPrimary,
                                        checkColor: Colors.white,
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                      color: colorPrimary,
                                                    )),
                                        value: true,
                                        onChanged: (value) {
                                          // setState(() {
                                          //   checkBox = value!;
                                          // });
                                        },
                                      ),
                                      Flexible(
                                        child: CustomText(
                                            size: 16,
                                            color: true ? colorPrimary : black,
                                            fontfamily:
                                                true ? 'semiBold' : 'medium',
                                            text: model.data.services[i].name),
                                      )
                                    ],
                                  ),
                                ),
                              // SizedBox(
                              //   width: width * 0.88,
                              //   child: Row(
                              //     children: [
                              //       Checkbox(
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             side: BorderSide.none),
                              //         activeColor: colorPrimary,
                              //         checkColor: Colors.white,
                              //         side: MaterialStateBorderSide.resolveWith(
                              //             (states) => const BorderSide(
                              //                   color: colorPrimary,
                              //                 )),
                              //         value: checkBox,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             checkBox = value!;
                              //           });
                              //         },
                              //       ),
                              //       Flexible(
                              //         child: CustomText(
                              //             size: 16,
                              //             color:
                              //                 checkBox ? colorPrimary : black,
                              //             fontfamily:
                              //                 checkBox ? 'semiBold' : 'medium',
                              //             text: "Housing"),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: width * 0.88,
                              //   child: Row(
                              //     children: [
                              //       Checkbox(
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             side: BorderSide.none),
                              //         activeColor: colorPrimary,
                              //         checkColor: Colors.white,
                              //         side: MaterialStateBorderSide.resolveWith(
                              //             (states) => const BorderSide(
                              //                   color: colorPrimary,
                              //                 )),
                              //         value: checkBox,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             checkBox = value!;
                              //           });
                              //         },
                              //       ),
                              //       Flexible(
                              //         child: CustomText(
                              //             size: 16,
                              //             color:
                              //                 checkBox ? colorPrimary : black,
                              //             fontfamily:
                              //                 checkBox ? 'semiBold' : 'medium',
                              //             text: "School"),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: width * 0.88,
                              //   child: Row(
                              //     children: [
                              //       Checkbox(
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             side: BorderSide.none),
                              //         activeColor: colorPrimary,
                              //         checkColor: Colors.white,
                              //         side: MaterialStateBorderSide.resolveWith(
                              //             (states) => const BorderSide(
                              //                   color: colorPrimary,
                              //                 )),
                              //         value: checkBox,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             checkBox = value!;
                              //           });
                              //         },
                              //       ),
                              //       Flexible(
                              //         child: CustomText(
                              //             size: 16,
                              //             color:
                              //                 checkBox ? colorPrimary : black,
                              //             fontfamily:
                              //                 checkBox ? 'semiBold' : 'medium',
                              //             text: "PickUp"),
                              //       )
                              //     ],
                              //   ),
                              // )
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
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
