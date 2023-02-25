import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/data/helper/search_delegate_company.dart';
import 'package:addrec_employee_management/app/modules/add-company/views/add_company_view.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // print(controller.arguments);
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme:  IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: 'Add User Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Fill up below form to add new user!",
                    size: 18,
                    fontfamily: "bold",
                    color: colorPrimary,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomEditText(
                        label: "First Name",
                        value: controller.firstName.value,
                        width: width * 0.4,
                        errorText: controller.firstNameError.value,
                        onChange: (value) {
                          controller.firstNameError.value = '';
                          controller.firstName.value = value;
                        },
                        hintText: 'Jhon',
                      ),
                      CustomEditText(
                        label: "last Name",
                        value: controller.lastName.value,
                        errorText: controller.lastNameError.value,
                        width: width * 0.4,
                        onChange: (value) {
                          controller.lastNameError.value = '';
                          controller.lastName.value = value;
                        },
                        hintText: 'Dee',
                      ),
                    ],
                  ),
                  CustomEditText(
                    label: "Email Address",
                    value: controller.email.value,
                    errorText: controller.emailError.value,
                    textInputType: TextInputType.emailAddress,
                    width: width * 0.9,
                    onChange: (value) {
                      controller.emailError.value = '';
                      controller.email.value = value;
                    },
                    hintText: 'jhonedee123@gmail.com',
                  ),
                  CustomEditText(
                    label: "Contact Number",
                    value: controller.contact.value,
                    errorText: controller.mobileError.value,
                    textInputType: TextInputType.number,
                    width: width * 0.9,
                    maxLength: 10,
                    onChange: (value) {
                      controller.mobileError.value = '';
                      controller.contact.value = value;
                    },
                    hintText: '9876543210',
                  ),
                  InkWell(
                    onTap: () {
                      showSearch(
                              context: context,
                              delegate: CustomSearchDelegateCompany())
                          .then((value) {
                        print(addedCompanyList);
                      });
                    },
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grayLight)),
                      child: CustomText(
                        size: 16,
                        text: 'Select Company',
                        color: gray,
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       width: width * 0.65,
                  //       height: 55,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           border: Border.all(color: grayLight)),
                  //       child: DropdownButtonHideUnderline(
                  //         child: DropdownButton<String>(
                  //           isDense: true,
                  //           isExpanded: true,
                  //           hint: CustomText(
                  //             text: "Company",
                  //           ),
                  //           value: companySelect,
                  //           onChanged: (newValue) async {
                  //             setState(() {
                  //               companySelect = newValue!;
                  //             });
                  //           },
                  //           items: companyList.map((String items) {
                  //             return DropdownMenuItem(
                  //               value: items,
                  //               child: CustomText(
                  //                 text: items,
                  //                 color: items == "Company" ? gray : black,
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     Column(
                  //       children: [
                  //         InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               if (addedCompanyList.contains(companySelect)) {
                  //                 Get.snackbar(companySelect, "Already added!");
                  //               } else {
                  //                 if (companySelect == "Company") {
                  //                 } else {
                  //                   setState(() {
                  //                     companyError = '';
                  //                   });
                  //                   addedCompanyList.add(companySelect);
                  //                 }
                  //               }
                  //             });
                  //           },
                  //           child: CustomText(
                  //             text: "Add",
                  //             fontfamily: 'bold',
                  //             color: colorSecondary,
                  //             size: 14,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 05,
                  //         ),
                  //         InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               if (!addedCompanyList.contains(companySelect)) {
                  //                 Get.snackbar(companySelect, "Not Added!");
                  //               } else {
                  //                 addedCompanyList.removeWhere(
                  //                     (element) => element == companySelect);
                  //               }
                  //             });
                  //           },
                  //           child: CustomText(
                  //             text: "Remove",
                  //             fontfamily: 'bold',
                  //             color: colorPrimary,
                  //             size: 14,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // if (addedCompanyList.isNotEmpty)
                  Visibility(
                    visible: addedCompanyList.isNotEmpty ? true : false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Selected Company",
                            fontfamily: 'medium',
                            color: colorPrimary,
                            size: 18,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.0),
                            child: Container(
                              width: width,
                              child: Wrap(
                                children: [
                                  for (int i = 0;
                                      i < addedCompanyList.length;
                                      i++)
                                    if (i == 0)
                                      CustomText(
                                        text: addedCompanyList[i],
                                        fontfamily: 'medium',
                                        color: black,
                                        size: 14,
                                      )
                                    else
                                      CustomText(
                                        text: ", ${addedCompanyList[i]}",
                                        fontfamily: 'medium',
                                        color: black,
                                        size: 14,
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.companyError.value == '' ? false : true,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: CustomText(
                        text: controller.companyError.value,
                        color: colorPrimary,
                        size: 12,
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      height: 50.0,
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grayLight)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          hint: CustomText(
                            text: "Role",
                          ),
                          value: controller.roleSelect.value,
                          onChanged: (newValue) async {
                            controller.roleError.value = '';
                            controller.roleSelect.value = newValue!;
                          },
                          items: controller.role.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: CustomText(
                                text: items,
                                color: items == "Role" ? gray : black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.roleError.value == '' ? false : true,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: CustomText(
                        text: controller.roleError.value,
                        color: colorPrimary,
                        size: 12,
                      ),
                    ),
                  ),

                  ImagePickerCustom(
                    width: width,
                    imageError: controller.imageError.value,
                  ),
                  // Container(
                  //   width: width * 0.9,
                  //   height: 130,
                  //   margin: EdgeInsets.only(top: 20),
                  //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(color: grayLight),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       ClipRRect(
                  //         borderRadius: BorderRadius.circular(100.0),
                  //         child: Container(
                  //           width: 100,
                  //           height: 100,
                  //           color: gray2,
                  //           child: Icon(
                  //             Icons.add_photo_alternate_rounded,
                  //             size: 50,
                  //             color: gray,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 20.0,
                  //       ),
                  //       CustomText(
                  //         text: "Select Profile Picture",
                  //         size: 16,
                  //         color: gray,
                  //       )
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 71,
                        width: 71,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(71),
                              )),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: () {
                            controller.checkError(context);
                          },
                          child: Icon(
                            Icons.download_done_rounded,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
