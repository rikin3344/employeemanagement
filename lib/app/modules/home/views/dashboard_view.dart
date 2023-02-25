import 'dart:math';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/data/helper/search_delegate.dart';
import 'package:addrec_employee_management/app/modules/home/controllers/home_controller.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardView extends GetView<HomeController> {
  @override
  DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void rebuildAllChildren(BuildContext context) {
      try {
        void rebuild(Element el) {
          el.markNeedsBuild();
          el.visitChildren(rebuild);
        }

        (context as Element).visitChildren(rebuild);
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 0),
            () {
              // print("object");
              controller.employeeModel = getEmployee();
              rebuildAllChildren(context);
            },
          );
        },

        // print('object');

        child: Container(
          height: height,
          child: Obx(
            () {
              print(controller.count.value);
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  // height: height,
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(
                            top: 5.0, right: 10.0, left: 10.0),
                        width: width * 0.9,
                        height: 60,
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
                          },
                          child: TextFormField(
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontFamily: 'medium',
                            ),
                            decoration: InputDecoration(
                              enabled: false,
                              icon: Icon(
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
                      FutureBuilder(
                        future: controller.employeeModel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            EmployeesModel employeesModel =
                                snapshot.data as EmployeesModel;

                            employee = employeesModel.data.employees;
                            if (employeesModel.data == null) {
                              // print('null data');
                            } else {}
                            return SingleChildScrollView(
                              padding: const EdgeInsets.only(right: 27.0),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // for (int i = 0; i <= 23; i++)
                                  Container(
                                    margin: const EdgeInsets.only(left: 27.0),
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: white,
                                                    size: 0,
                                                  ))
                                            ],
                                          ),
                                          CustomText(
                                            text: employeesModel
                                                .data.totalEmployees
                                                .toString(),
                                            size: 40,
                                            color: white,
                                            fontfamily: 'semiBold',
                                          ),
                                          CustomText(
                                            text: 'Total Employee',
                                            size: 20,
                                            color: white,
                                            fontfamily: 'semiBold',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 27.0),
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: white,
                                                    size: 0,
                                                  ))
                                            ],
                                          ),
                                          CustomText(
                                            text: employeesModel
                                                .data.totalPendingEmployees
                                                .toString(),
                                            size: 40,
                                            color: white,
                                            fontfamily: 'semiBold',
                                          ),
                                          CustomText(
                                            text: 'In-Progress Employee',
                                            size: 20,
                                            color: white,
                                            fontfamily: 'semiBold',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 27.0),
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: white,
                                                    size: 0,
                                                  ))
                                            ],
                                          ),
                                          CustomText(
                                            text: employeesModel
                                                .data.totalDoneEmployees
                                                .toString(),
                                            size: 40,
                                            color: white,
                                            fontfamily: 'semiBold',
                                          ),
                                          CustomText(
                                            text: 'Completed Employee',
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
                            );
                          } else {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child:
                                    const CircularProgressIndicator.adaptive(),
                              );
                            } else {
                              return const CustomText(text: 'text');
                            }
                          }
                        },
                      ),
                      Container(
                        width: width * 0.9,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "Scheduled",
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
                                onPressed: () {
                                  Get.toNamed(Routes.DYNAMIC_EMPLOYEE_FORM);
                                  // navigationController
                                  //     .navigateTO(addEmployeeScreenRoute, []);
                                },
                                child: Row(
                                  children: [
                                    const Icon(
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
                      FutureBuilder(
                        future: controller.employeeModel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            EmployeesModel employeesModel =
                                snapshot.data as EmployeesModel;

                            employee = employeesModel.data.employees;

                            return Column(
                              children: employeeList(
                                  employeesModel.data.employees, width),
                            );
                          } else {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else {
                              return const CustomText(text: 'text');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
              ;
            },
          ),
        ),
      ),
    );
  }
}

List<Widget> employeeList(List<Employee> employee, width) {
  List<Widget> element = [];
  if (employee.length == 0) {
    element.add(
      Container(
        width: width * 0.9,
        margin: const EdgeInsets.only(bottom: 14.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        alignment: Alignment.center,
        child: const CustomText(text: 'Opps, No Data Found!!'),
      ),
    );
  }
  for (var i = 0; i < employee.length; i++) {
    String companyName = employee[i].companyName;
    element.add(InkWell(
      onTap: () {
        Get.toNamed(Routes.EMPLOYEE_DETAILS, arguments: {
          "id": employee[i].id,
          "profile": employee[i].profilePic
        });
      },
      child: Container(
        width: width * 0.9,
        margin: const EdgeInsets.only(bottom: 14.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        height: 90,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  child: employee[i].profilePic !=
                          "https://onboarding.addrecsolutions.com/storage/employee/"
                      ? Image.network(
                          employee[i].profilePic,
                          height: 55.0,
                          width: 55.0,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          iconMale[Random().nextInt(iconMale.length)],
                          width: 55.0,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    width: width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CustomText(
                            text:
                                '${employee[i].firstName} ${employee[i].lastName}',
                            size: 18,
                            color: colorPrimary.withOpacity(0.9),
                            fontfamily: 'semiBold',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: CustomText(
                            text: companyName,
                            size: 12,
                            color: black,
                            fontfamily: 'medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: false,
              child: IconButton(
                onPressed: () {
                  // Get.toNamed(Routes.EMPLOYEE_DETAILS, arguments: employee[i].id);
                  // navigationController.navigateTO(
                  //     employeeDetailsScreenRoute, {'employeeId': employee[i]});
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30.0,
                  color: colorPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  return element;
}
