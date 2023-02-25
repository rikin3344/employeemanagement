import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            text: 'Add Employee Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Obx(
            () => Stack(
              children: [
                
    Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomText(
                text: "Personal Details",
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
                    value: controller.data['firstName']!,
                    width: width * 0.4,
                    errorText: controller.firstNameError.value,
                    onChange: (value) {
                      controller.firstNameError.value = '';
                      if (controller.data['firstName'] == '') {
                        controller.data['firstName'] = value;
                      } else {
                        controller.data
                            .update('firstName', (value123) => value);
                      }
                    },
                    hintText: 'Jhon',
                  ),
                  CustomEditText(
                    label: "last Name",
                    value: controller.data['lastName']!,
                    errorText: controller.lastNameError.value,
                    width: width * 0.4,
                    onChange: (value) {
                      controller.lastNameError.value = '';
                      if (controller.data['lastName'] == '') {
                        controller.data['lastName'] = value;
                      } else {
                        controller.data.update('lastName', (value123) => value);
                      }
                    },
                    hintText: 'Dee',
                  ),
                ],
              ),
              CustomEditText(
                label: "Email Address",
                value: controller.data['email']!,
                errorText: controller.emailError.value,
                textInputType: TextInputType.emailAddress,
                width: width * 0.9,
                onChange: (value) {
                  controller.emailError.value = '';
                  if (controller.data['email'] == '') {
                    controller.data['email'] = value;
                  } else {
                    controller.data.update('email', (value123) => value);
                  }
                },
                hintText: 'jhonedee123@gmail.com',
              ),
              CustomEditText(
                label: "Contact Number",
                prefixText: "+91",
                value: controller.data['contact']!,
                maxLength: 10,
                errorText: controller.contactError.value,
                textInputType: TextInputType.number,
                width: width * 0.9,
                onChange: (value) {
                  controller.contactError.value = '';
                  if (controller.data['contact'] == '') {
                    controller.data['contact'] = value;
                  } else {
                    controller.data.update('contact', (value123) => value);
                  }
                },
                hintText: '9876543210',
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: controller.companyError.value == ''
                                  ? grayLight
                                  : colorPrimary)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          hint: CustomText(
                            text: "Company",
                          ),
                          value: controller.companySelect.value,
                          onChanged: (newValue) async {
                            String companyId = '';
                            for (var i = 0; i < companyData.length; i++) {
                              // print(newValue);
                              if ('${companyData[i].name} (${companyData[i].code})' ==
                                  newValue) {
                                companyId = companyData[i].id;
                              }
                            }

                            if (controller.data['company'] == '') {
                              controller.data['company'] = companyId;
                            } else {
                              controller.data
                                  .update('company', (value123) => companyId);
                            }
                            controller.companySelect.value = newValue!;
                          },
                          items: controller.companyList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: CustomText(
                                text: items,
                                color: items == "Company" ? gray : black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.companyError.value == '' ? false : true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: CustomText(
                          text: controller.companyError.value,
                          color: colorPrimary,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomEditText(
                label: "Designation",
                width: width * 0.9,
                errorText: controller.designationError.value,
                value: controller.data['designation']!,
                onChange: (value) {
                  controller.designationError.value = '';
                  if (controller.data['designation'] == '') {
                    controller.data['designation'] = value;
                  } else {
                    controller.data.update('designation', (value123) => value);
                  }
                },
                hintText: 'HR',
              ),
              InkWell(
                onTap: () {
                  controller.pickDate(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.centerLeft,
                  width: width * 0.9,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: controller.arrivalDateError.value == ''
                            ? grayLight
                            : colorPrimary),
                  ),
                  child: CustomText(
                      color:
                          controller.formattedDate.value == '' ? gray : black,
                      text: controller.formattedDate.value == ''
                          ? 'Arrival Date'
                          : controller.formattedDate.value),
                ),
              ),
              Visibility(
                visible: controller.arrivalDateError.value == '' ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: CustomText(
                    text: controller.arrivalDateError.value,
                    color: colorPrimary,
                    size: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    controller.timePicker(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    alignment: Alignment.centerLeft,
                    width: width * 0.9,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: controller.arrivalTimeError.value == ''
                              ? grayLight
                              : colorPrimary),
                    ),
                    child: CustomText(
                        color:
                            controller.selectedTime.value == '' ? gray : black,
                        text: controller.selectedTime.toString() == ''
                            ? 'Arrival Time'
                            : controller.selectedTime.value.toString()),
                  ),
                ),
              ),
              Visibility(
                visible: controller.arrivalTimeError.value == '' ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: CustomText(
                    text: controller.arrivalTimeError.value,
                    color: colorPrimary,
                    size: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
               CustomText(
                text: "Company Details",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomEditText(
                label: "HRBP Name",
                value: controller.data['hrbpName']!,
                errorText: controller.hrbpNameError.value,
                textInputType: TextInputType.text,
                width: width * 0.9,
                onChange: (value) {
                  controller.hrbpNameError.value = '';
                  if (controller.data['hrbpName'] == '') {
                    controller.data['hrbpName'] = value;
                  } else {
                    controller.data.update('hrbpName', (value123) => value);
                  }
                },
                hintText: 'XYZ',
              ),
              CustomEditText(
                label: "HRBP Contact",
                value: controller.data['hrbpContact']!,
                errorText: controller.hrbpContactError.value,
                textInputType: TextInputType.number,
                maxLength: 10,
                width: width * 0.9,
                onChange: (value) {
                  controller.hrbpContactError.value = '';
                  if (controller.data['hrbpContact'] == '') {
                    controller.data['hrbpContact'] = value;
                  } else {
                    controller.data.update('hrbpContact', (value123) => value);
                  }
                },
                hintText: '9876543210',
              ),
              CustomEditText(
                label: "HRBP Email",
                value: controller.data['hrbpEmail']!,
                errorText: controller.hrbpEmailError.value,
                textInputType: TextInputType.emailAddress,
                width: width * 0.9,
                onChange: (value) {
                  controller.hrbpEmailError.value = '';
                  if (controller.data['hrbpEmail'] == '') {
                    controller.data['hrbpEmail'] = value;
                  } else {
                    controller.data.update('hrbpEmail', (value123) => value);
                  }
                },
                hintText: 'xyz@gmail.com',
              ),
              CustomEditText(
                label: "Business Name",
                value: controller.data['businessName']!,
                errorText: controller.businessNameError.value,
                textInputType: TextInputType.text,
                width: width * 0.9,
                onChange: (value) {
                  controller.businessNameError.value = '';
                  if (controller.data['businessName'] == '') {
                    controller.data['businessName'] = value;
                  } else {
                    controller.data.update('businessName', (value123) => value);
                  }
                },
                hintText: 'XYZ',
              ),
              CustomEditText(
                label: "Legal Entity",
                value: controller.data['legalEntity']!,
                errorText: controller.legalEntityError.value,
                textInputType: TextInputType.text,
                width: width * 0.9,
                onChange: (value) {
                  controller.legalEntityError.value = '';
                  if (controller.data['legalEntity'] == '') {
                    controller.data['legalEntity'] = value;
                  } else {
                    controller.data.update('legalEntity', (value123) => value);
                  }
                },
                hintText: 'XYZ',
              ),
              SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
      ),
    )
  ,
                Positioned(
                  bottom: 10,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.pageIndex.value != 0 ? true : false,
                        child: Container(
                          height: 71,
                          width: 71,
                          margin: EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: colorPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(71),
                                )),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            onPressed: () {
                              controller.previousPage();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: controller.pageIndex.value != (0)
                            ? width - 180
                            : width - 91,
                      ),
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
                            controller.changePageIndex(context);
                          },
                          child: Icon(
                            controller.pageIndex.value == 0
                                ? Icons.download_done_rounded
                                : Icons.arrow_forward_ios_rounded,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
