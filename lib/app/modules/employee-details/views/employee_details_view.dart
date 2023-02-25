import 'dart:math' as math;
import 'dart:math';

import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/controllers.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
// import 'package:addrec_employee_management/app/modules/employee-details/models/employee_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/field_value_modal.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/new_employee_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/no_of_chield_modal.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/null_employe_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/pie_chart_color_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/radio_status_modal.dart';
import 'package:addrec_employee_management/app/modules/home/model/check_box_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/employee_details_controller.dart';

List<CheckBoxModel> serviceList = [];
List<CheckBoxModel> updatedServiceList = [];
List<CheckBoxModel> changedServiceList = [];

class EmployeeDetailsView extends GetView<EmployeeDetailsController> {
  const EmployeeDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final MyTabController _tabx = Get.put(MyTabController());
    // controller.id.value = Get.arguments;
    // print(controller.id.value + 'employeeid');
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        bottom: TabBar(
          controller: tabController.controller,
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
          labelStyle: TextStyle(
            fontSize: 16,
            color: colorPrimary,
            fontFamily: 'bold',
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme: IconThemeData(color: black),
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
            padding: const EdgeInsets.only(right: 0.0),
            child: IconButton(
                onPressed: () async {
                  Loading loading = Loading();
                  loading.start(context);
                  // controller.detailsModel = getEmployeeDetails(controller.id);
                  loading.stopDialog(context);
                  // for (var i = 0;
                  //     i < controller.finalPieColorModel.length;
                  //     i++) {
                  //   controller.finalPieColorModel.removeAt(i);
                  // }

                  // return controller.detailsModel;

                  rebuildAllChildren(context);
                },
                icon: const Icon(Icons.refresh_rounded)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.ACTIVITY_TIMELINE,
                      arguments: controller.id);
                },
                icon: const Icon(Icons.transcribe_outlined)),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            print(controller.count.value);
            return TabBarView(
              controller: tabController.controller,
              children: [
                FutureBuilder(
                  future: controller.detailsModel,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.hasData) {
                      if (snapshot.hasError) {
                        return FutureBuilder(
                          future: controller.nullDetailsModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              NullEmployeeDetailsModel nullDatamodel =
                                  snapshot.data as NullEmployeeDetailsModel;

                              String companyName = '';
                              String modeOfTravel = '';

                              for (int i = 0; i < companyData.length; i++) {
                                print("${companyData[i].id} company");
                                if (companyData[i].id ==
                                    nullDatamodel.data.employees[4]
                                        .employeeFieldValue.value) {
                                  companyName = companyData[i].name;
                                }
                              }
                              for (var i = 0;
                                  i < controller.transportationData.length;
                                  i++) {
                                print(controller.transportationData[i].id +
                                    "   " +
                                    nullDatamodel.data.employees[5]
                                        .employeeFieldValue.value +
                                    "rikinpokiihsfu");
                                if (controller.transportationData[i].id ==
                                    nullDatamodel.data.employees[5]
                                        .employeeFieldValue.value) {
                                  modeOfTravel =
                                      controller.transportationData[i].name;
                                }
                              }
                              return Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            width: width,
                                            child: Row(
                                              children: [
                                                ClipRect(
                                                  child: controller.profile !=
                                                          "https://onboarding.addrecsolutions.com/storage/employee/"
                                                      ? Image.network(
                                                          controller.profile,
                                                          height: 100.0,
                                                          width: 100.0,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.asset(
                                                          iconMale[5],
                                                        ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: width - 155,
                                                        child: CustomText(
                                                          text:
                                                              'Name : ${nullDatamodel.data.employees[0].employeeFieldValue.value} ${nullDatamodel.data.employees[1].employeeFieldValue.value}',
                                                          size: 14,
                                                          fontfamily:
                                                              'semiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width - 155,
                                                        child: Text(
                                                          'Email : ${nullDatamodel.data.employees[2].employeeFieldValue.value}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "medium",
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ),
                                                      ),
                                                      // CustomText(
                                                      //   text:
                                                      //       'Email : ${model.data.employees.email}',
                                                      //   size: 14,
                                                      //   fontfamily: 'semiBold',
                                                      // ),
                                                      CustomText(
                                                        text:
                                                            'Contact : ${nullDatamodel.data.employees[3].employeeFieldValue.value}',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                    ],
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
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      const CustomText(
                                                        text: 'Company : ',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                      CustomText(
                                                        text:companyName,
                                                        size: 14,
                                                        fontfamily: 'medium',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      const CustomText(
                                                        text:
                                                            'Mode of Travel : ',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                      CustomText(
                                                        text: modeOfTravel,
                                                        size: 14,
                                                        fontfamily: 'medium',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: const [
                                                      CustomText(
                                                        text: 'Coming From : ',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                      CustomText(
                                                        text: 'Ahmadabad',
                                                        size: 14,
                                                        fontfamily: 'medium',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: const [
                                                      CustomText(
                                                        text:
                                                            'Arrival Place : ',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                      CustomText(
                                                        text: 'London',
                                                        size: 14,
                                                        fontfamily: 'medium',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      const CustomText(
                                                        text:
                                                            'Arrival Date & Time : ',
                                                        size: 14,
                                                        fontfamily: 'semiBold',
                                                      ),
                                                      CustomText(
                                                        text:
                                                            "${nullDatamodel.data.employees[6].employeeFieldValue.value} ${nullDatamodel.data.employees[7].employeeFieldValue.value}",
                                                        size: 14,
                                                        fontfamily: 'medium',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: SizedBox(
                                        height: 71,
                                        width: 71,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: colorPrimary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(71),
                                              )),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          onPressed: () async {
                                            controller.deleteEmployee(
                                                nullDatamodel.data.employees[2]
                                                    .employeeFieldValue.value,
                                                context);
                                          },
                                          child: const Icon(
                                            Icons.delete_forever_rounded,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Positioned(
                                      bottom: 20.0,
                                      right: 20.0,
                                      child: SizedBox(
                                        height: 71,
                                        width: 71,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: colorSecondary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(71),
                                              )),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          onPressed: () async {},
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            size: 35,
                                          ),
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
                        );
                      } else {
                        EmployeeDetailsModel model =
                            snapshot.data as EmployeeDetailsModel;
                        String companyName = '';
                        String modeOfTravel = '';
                        List<double> graphRadius = [];
                        double remainingRadius = 0;
                        double totalRadius = 0;
                        List<String> graphRadiusDataName = [];
                        List<Color> colorList = [];
                        RxList<PieChartColorModel> pieColorModel =
                            <PieChartColorModel>[].obs;
                        print(model.data.graphData.length.toString() +
                            "model.datadasdasd");
                        for (int i = 0; i < model.data.graphData.length; i++) {
                          switch (model.data.graphData[i].serviceName) {
                            case "AF":
                              pieColorModel.add(PieChartColorModel(
                                  name: model.data.graphData[i].serviceName,
                                  color: "3B2E5A"));
                              break;
                            case "Welcome":
                              pieColorModel.add(PieChartColorModel(
                                  name: model.data.graphData[i].serviceName,
                                  color: "C70A80"));

                              break;
                            case "School":
                              pieColorModel.add(PieChartColorModel(
                                  name: model.data.graphData[i].serviceName,
                                  color: "006E7F"));

                              break;
                            case "Home":
                              pieColorModel.add(PieChartColorModel(
                                  name: model.data.graphData[i].serviceName,
                                  color: "D82148"));

                              break;
                            case "Utilitize":
                              pieColorModel.add(PieChartColorModel(
                                  name: model.data.graphData[i].serviceName,
                                  color: "FFAB4C"));

                              break;
                            default:
                          }
                        }
                        for (int i = 0; i < companyData.length; i++) {
                          print("${companyData[i].id} company");
                          if (companyData[i].id ==
                              model
                                  .data.employees[4].employeeFieldValue.value) {
                            companyName = companyData[i].name;
                          }
                        }
                        for (var i = 0;
                            i < controller.transportationData.length;
                            i++) {
                          if (controller.transportationData[i].id ==
                              model
                                  .data.employees[5].employeeFieldValue.value) {
                            modeOfTravel =
                                controller.transportationData[i].name;
                          }
                        }

                        List<PieChartColorModel> finalPieColorModel =
                            <PieChartColorModel>[];
                        String remainingService = '';
                        double equalPartOfTotalService =
                            2270 / (model.data.employeeServices.length + 1);
                        for (int i = 0;
                            i < model.data.employeeServices.length;
                            i++) {
                          //2270
                          for (var k = 0;
                              k < model.data.graphData.length;
                              k++) {
                            if (model.data.graphData[k].serviceName ==
                                model.data.employeeServices[i].name) {
                              if (model.data.graphData[k].status == 1) {
                                for (int j = 0; j < pieColorModel.length; j++) {
                                  if (pieColorModel[j].name ==
                                      model.data.employeeServices[i].name) {
                                    finalPieColorModel.add(PieChartColorModel(
                                        name: pieColorModel[j].name,
                                        color: pieColorModel[j].color,
                                        radius: equalPartOfTotalService));
                                  }
                                }
                              } else {
                                if (remainingService == "") {
                                  remainingService =
                                      model.data.employeeServices[i].name;
                                } else {
                                  remainingService =
                                      "$remainingService, ${model.data.employeeServices[i].name}";
                                }
                                remainingRadius =
                                    remainingRadius + equalPartOfTotalService;
                              }
                            }

                            // for (var i = 0;
                            //     i < model.data.graphData.length;
                            //     i++) {
                            //   for (int j = 0;
                            //       j < controller.finalPieColorModel.length;
                            //       j++) {
                            //     if (model.data.graphData[i].status == 1) {
                            //       if (controller.finalPieColorModel[j].name ==
                            //           model.data.graphData[i].serviceName) {}
                            //     }
                            //   }
                            // }
                            // if (model.data.graphData[k].serviceName ==
                            //     model.data.employeeServices[i].name) {
                            //   if (model.data.graphData[k].status == 1) {
                            //     graphRadius.add(equalPartOfTotalService);
                            //     graphRadiusDataName
                            //         .add(model.data.employeeServices[i].name);
                            //     for (var j = 0;
                            //         j < controller.pieColorModel.length;
                            //         j++) {
                            //       if (controller.pieColorModel[j].name ==
                            //               model.data.employeeServices[i].name &&
                            //           colorList[i] !=
                            //               Color(int.parse(
                            //                   "0xFF${controller.pieColorModel[j].color}"))) {
                            //         colorList.add(Color(int.parse(
                            //             "0xFF${controller.pieColorModel[j].color}")));
                            //         totalRadius =
                            //             totalRadius + equalPartOfTotalService;
                            //       }
                            //     }
                            //   } else {
                            //     remainingRadius = 2270 - totalRadius;
                            //   }
                            // }
                            // print(graphRadius);
                          }
                        }

                        return Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      width: width,
                                      child: Row(
                                        children: [
                                          ClipRect(
                                            child: controller.profile !=
                                                    "https://onboarding.addrecsolutions.com/storage/employee/"
                                                ? Image.network(
                                                    controller.profile,
                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    iconMale[5],
                                                  ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: width - 155,
                                                  child: CustomText(
                                                    text:
                                                        'Name : ${model.data.employees[0].employeeFieldValue.value} ${model.data.employees[1].employeeFieldValue.value}',
                                                    size: 14,
                                                    fontfamily: 'semiBold',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width - 155,
                                                  child: Text(
                                                    'Email : ${model.data.employees[2].employeeFieldValue.value}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "medium",
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ),
                                                // CustomText(
                                                //   text:
                                                //       'Email : ${model.data.employees.email}',
                                                //   size: 14,
                                                //   fontfamily: 'semiBold',
                                                // ),
                                                CustomText(
                                                  text:
                                                      'Contact : ${model.data.employees[3].employeeFieldValue.value}',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                              ],
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
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: [
                                                const CustomText(
                                                  text: 'Company : ',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                                CustomText(
                                                  text: companyName,
                                                  size: 14,
                                                  fontfamily: 'medium',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: [
                                                const CustomText(
                                                  text: 'Mode of Travel : ',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                                CustomText(
                                                  text: modeOfTravel,
                                                  size: 14,
                                                  fontfamily: 'medium',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: const [
                                                CustomText(
                                                  text: 'Coming From : ',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                                CustomText(
                                                  text: 'Ahmadabad',
                                                  size: 14,
                                                  fontfamily: 'medium',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: const [
                                                CustomText(
                                                  text: 'Arrival Place : ',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                                CustomText(
                                                  text: 'London',
                                                  size: 14,
                                                  fontfamily: 'medium',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: [
                                                const CustomText(
                                                  text:
                                                      'Arrival Date & Time : ',
                                                  size: 14,
                                                  fontfamily: 'semiBold',
                                                ),
                                                CustomText(
                                                  text:
                                                      "${model.data.employees[6].employeeFieldValue.value} ${model.data.employees[7].employeeFieldValue.value}",
                                                  size: 14,
                                                  fontfamily: 'medium',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            height: 150,
                                            width: 150,
                                            child: CustomPaint(
                                              painter: PiePainter(stats: [
                                                for (int i = 0;
                                                    i <
                                                        finalPieColorModel
                                                            .length;
                                                    i++)
                                                  PieValue(
                                                    value: finalPieColorModel[i]
                                                        .radius,
                                                    color: Color(int.parse(
                                                        "0xFF${finalPieColorModel[i].color}")),
                                                  ),
                                                remainingRadius != 0
                                                    ? PieValue(
                                                        value: remainingRadius,
                                                        color: grayLight,
                                                      )
                                                    : PieValue(
                                                        value: 0,
                                                        color: grayLight,
                                                      ),
                                              ]),
                                            ),
                                          ),
                                          for (int i = 0;
                                              i < finalPieColorModel.length;
                                              i++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          "0xFF${finalPieColorModel[i].color}")),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  CustomText(
                                                    text: finalPieColorModel[i]
                                                        .name,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          remainingRadius != 0
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: grayLight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    CustomText(
                                                      text: remainingService,
                                                      size: 14,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Positioned(
                                bottom: 20,
                                left: 20,
                                child: SizedBox(
                                  height: 71,
                                  width: 71,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: colorPrimary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(71),
                                        )),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    onPressed: () async {
                                      controller.deleteEmployee(
                                          model.data.employees[2]
                                              .employeeFieldValue.value,
                                          context);
                                    },
                                    child: const Icon(
                                      Icons.delete_forever_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Positioned(
                                bottom: 20.0,
                                right: 20.0,
                                child: SizedBox(
                                  height: 71,
                                  width: 71,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: colorSecondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(71),
                                        )),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    onPressed: () async {},
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: controller.detailsModel,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.hasData) {
                      if (snapshot.hasError) {
                        return FutureBuilder(
                          future: controller.nullDetailsModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return Column(
                                children: [
                                  Container(
                                    width: width * 0.8,
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: CustomText(
                                      text:
                                          "Assessment data not filled up by employee!!",
                                      size: 16,
                                      color: colorPrimary,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                          },
                        );
                      } else {
                        EmployeeDetailsModel model =
                            snapshot.data as EmployeeDetailsModel;
                        String hobbies = '';
                        String jobAssistants = '';
                        String relocateFamily = '';
                        for (int i = 0;
                            i < model.data.assesmentData.hobbies.length;
                            i++) {
                          if (i == 0) {
                            hobbies = model.data.assesmentData.hobbies[i];
                          } else {
                            hobbies =
                                "$hobbies, ${model.data.assesmentData.hobbies[i]}";
                          }
                        }
                        for (int i = 0;
                            i <
                                model.data.assesmentData
                                    .yourSpouseRequireAssistanceOn.length;
                            i++) {
                          if (i == 0) {
                            jobAssistants = model.data.assesmentData
                                .yourSpouseRequireAssistanceOn[i];
                          } else {
                            jobAssistants =
                                "$jobAssistants, ${model.data.assesmentData.yourSpouseRequireAssistanceOn[i]}";
                          }
                        }
                        for (int i = 0;
                            i <
                                model.data.assesmentData
                                    .howSoonExpectingRelocateFamily.length;
                            i++) {
                          if (i == 0) {
                            relocateFamily = model.data.assesmentData
                                .howSoonExpectingRelocateFamily[i];
                          } else {
                            relocateFamily =
                                "$relocateFamily, ${model.data.assesmentData.howSoonExpectingRelocateFamily[i]}";
                          }
                        }
                        return SingleChildScrollView(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                CustomDetails(
                                  width: width,
                                  title:
                                      'Who all are planning to relocate with you (In next 90 days)? ',
                                  details:
                                      model.data.assesmentData.whoIsArriving[0],
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'If you are relocating with your family, please specify the number of members relocating with you. ',
                                  details: model
                                      .data.assesmentData.numberOfMembers
                                      .toString(),
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'Is any family member differently abled? : ',
                                  details: model.data.assesmentData
                                              .isDiffrentlyAbled ==
                                          0
                                      ? "No"
                                      : "Yes",
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'Are you interested to know about various club membership? : ',
                                  details: model.data.assesmentData
                                              .isInterestedForClubMembership ==
                                          0
                                      ? "No"
                                      : "Yes",
                                ),
                                CustomDetails(
                                  width: width,
                                  title: 'Hobbies : ',
                                  details: hobbies,
                                ),
                                CustomDetails(
                                  width: width,
                                  title: 'Is your spouse presently working?',
                                  details: model.data.assesmentData
                                              .isSpouseWorking ==
                                          '0'
                                      ? "No"
                                      : model.data.assesmentData
                                                  .isSpouseWorking ==
                                              '1'
                                          ? "Yes"
                                          : "Planning to work",
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'Does your spouse require any support to find a new job?',
                                  details: model.data.assesmentData
                                              .spouseRequireSuppoerToWork ==
                                          '0'
                                      ? "No"
                                      : model.data.assesmentData
                                                  .isSpouseWorking ==
                                              '1'
                                          ? "Yes"
                                          : "Maybe",
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'Your Spouse would require assistance on : ',
                                  details: jobAssistants,
                                ),
                                CustomDetails(
                                  width: width,
                                  title:
                                      'How soon are you expecting to relocate your family after joining?',
                                  details: relocateFamily,
                                ),
                                Column(
                                  children: services(
                                      model.data.employeeServices,
                                      width,
                                      model.data.assesmentData,
                                      context,
                                      model.data.graphData),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> services(List<EmployeeService> employeeServices, double width,
      AssesmentData assesmentData, context, List<GraphDatum> graphData) {
    List<Widget> element = [];
    for (int i = 0; i < employeeServices.length; i++) {
      String childList = "";
      List test = [];
      List<NoOfChildModal> childListJson = [];
      // print(assesmentData.noOfChildAndAge.toString());
      for (var j = 0; j < assesmentData.noOfChildAndAge.length; j++) {
        String newList = assesmentData.noOfChildAndAge[j];
        String newList0 = newList.replaceAll("'", '"');
        String newList00 = newList0.replaceAll('"value:"', '"value":"');
        // print(newListOfChild);
        test.add(newList00);
      }
      print(test.toString());
      childListJson = noOfChildModalFromJson(test.toString());

      for (int j = 0; j < childListJson.length; j++) {
        if (j == 0) {
          childList = "${childListJson[j].value} ( ${childListJson[j].year} )";
        } else {
          childList =
              "$childList, ${childListJson[j].value} ( ${childListJson[j].year} )";
        }
      }

      for (var j = 0; j < graphData.length; j++) {
        if (graphData[j].serviceName == employeeServices[i].name) {
          controller.radioStatus.add(RadioStatusModal(
              name: graphData[j].serviceName,
              value: graphData[j].status.toString()));
        }
      }

      print(
          "${controller.radioStatus[i].value} ${controller.radioStatus[i].name}");

      element.add(
        ExpansionTile(
          title: CustomText(
            text: employeeServices[i].name,
            size: 16,
            fontfamily: 'semiBold',
          ),
          children: <Widget>[
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (employeeServices[i].name == "School")
                    CustomDetails(
                      width: width,
                      title: "No of child and age",
                      details: childList,
                    ),
                  Column(
                    children: servicesDetailsList(
                        employeeServices[i].subServices, width),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        RadioListTile(
                          title: CustomText(
                            text: 'Completed',
                            size: 14,
                            color: controller.radioStatus[i].value == '1'
                                ? colorPrimary
                                : black123,
                            fontfamily: 'medium',
                          ),
                          value: '1',
                          activeColor: colorPrimary,
                          groupValue: controller.radioStatus[i].value,
                          onChanged: (value) {
                            controller.updateServiceNew(
                                context, employeeServices[i].id, "1");
                            controller.radioStatus[i].value = value.toString();
                            print(
                                radioStatusModalToJson(controller.radioStatus));
                          },
                        ),
                        RadioListTile(
                          title: CustomText(
                            text: 'Not Completed',
                            size: 14,
                            color: controller.radioStatus[i].value == '0'
                                ? colorPrimary
                                : black123,
                            fontfamily: 'medium',
                          ),
                          value: '0',
                          activeColor: colorPrimary,
                          groupValue: controller.radioStatus[i].value,
                          onChanged: (value) {
                            controller.updateServiceNew(
                                context, employeeServices[i].id, "0");
                            controller.radioStatus[i].value = value.toString();
                            print(
                                radioStatusModalToJson(controller.radioStatus));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
    return element;
  }

  List<Widget> servicesDetailsList(List<SubService> subServices, width) {
    List<Widget> element = [];
    for (var i = 0; i < subServices.length; i++) {
      String field = subServices[i].field;
      String value = subServices[i].value;
      String newField = field.replaceAll('_', " ");
      controller.fieldValueModal
          .add(FieldValueModal(field: newField, value: value));
    }
    for (var i = 0; i < controller.fieldValueModal.length; i++) {
      if (controller.fieldValueModal[i].field != "no of child and age") {
        element.add(
          CustomDetails(
            width: width,
            title: controller.fieldValueModal[i].field,
            details: controller.fieldValueModal[i].value == "0"
                ? "No"
                : controller.fieldValueModal[i].value == "1"
                    ? "Yes"
                    : controller.fieldValueModal[i].value,
          ),
        );
      }
    }
    return element;
  }

  // List<Widget> services(
  //   width,
  //   EmployeesDetailsModel model,
  // ) {
  //   List<Widget> element = [];
  //   for (var i = 0; i < controller.serviceList.length; i++) {
  //     if (controller.serviceList[i].status == '1') {
  //       element.add(
  //   SizedBox(
  //     width: width * 0.88,
  //     child: Row(
  //       children: [
  //         Checkbox(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               side: BorderSide.none),
  //           activeColor: colorPrimary,
  //           checkColor: Colors.white,
  //           side: MaterialStateBorderSide.resolveWith(
  //               (states) => BorderSide(
  //                     color: colorPrimary,
  //                   )),
  //           value: controller.serviceList[i].value,
  //           onChanged: (value) {
  //             // controller.serviceList[i].value = value!;
  //             controller.changeValueOfList(i, value);
  //             controller.update();
  //           },
  //         ),
  //         Flexible(
  //           child: CustomText(
  //               size: 16,
  //               color: true ? colorPrimary : black,
  //               fontfamily: true ? 'semiBold' : 'medium',
  //               text: model.data.employees.services[i].name),
  //         )
  //       ],
  //     ),
  //   ),
  // );
  //     }
  //   }

  //   return element;
  // }
}

class CustomDetails extends StatelessWidget {
  const CustomDetails({
    Key? key,
    required this.width,
    required this.title,
    required this.details,
  }) : super(key: key);

  final double width;
  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width - 40,
            child: CustomText(
              text: title,
              size: 14,
              fontfamily: 'semiBold',
            ),
          ),
          SizedBox(
            width: width - 40,
            child: CustomText(
              text: details,
              size: 14,
              color: colorSecondary,
              fontfamily: 'regular',
            ),
          ),
        ],
      ),
    );
  }
}

class PieValue {
  final double value;
  final Color color;

  PieValue({required this.value, required this.color});
}

class PiePainter extends CustomPainter {
  PiePainter({required this.stats});
  final List<PieValue> stats;

  @override
  void paint(Canvas canvas, Size size) {
    //Short Hand
    final width = size.width;
    final height = size.height;

    final paint = Paint()..style = PaintingStyle.fill;

    //Rectangle object required for drawArc method
    final rect = Rect.fromCenter(
        center: Offset(width / 2, height / 2), width: width, height: height);

    //Sum is used to calculate the radian of each stats
    final sum = stats.fold(
      0.0,
      (double previousValue, element) => previousValue + element.value,
    );

    //Used this to change startAngle after drawing each arc
    double totalRadian = 0.0;

    for (var stat in stats) {
      paint.color = stat.color;

      // Calculate degree by (value/sum) * 360 = degree
      // and to convert degree we can do degree * (pi/180)
      final sweepAngle = (stat.value / sum) * 360 * (math.pi / 180);

      double startAngle = (-math.pi / 2) + totalRadian;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      totalRadian += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
