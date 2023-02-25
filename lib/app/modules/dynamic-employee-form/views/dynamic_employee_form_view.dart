import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/dynamic_form_model.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/form_data_model.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dynamic_employee_form_controller.dart';

class DynamicEmployeeFormView extends GetView<DynamicEmployeeFormController> {
  const DynamicEmployeeFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme: IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child:const CustomText(
            text: 'Add Employee Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                CustomText(
                  text: "Fill up below form to add new employee!",
                  size: 18,
                  fontfamily: "bold",
                  color: colorPrimary,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                  future: controller.futureModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.done) {
                      // DynamicFormModel model =
                      //     snapshot.data as DynamicFormModel;
                      return Obx(
                        () => Column(
                          children: elements(snapshot.data as DynamicFormModel, width, context),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
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
                          print(dynamicFormDataModalToJson(
                              controller.collectionData));
                          // controller.onClickAdd(context, imageData);
                        },
                        child: const Icon(
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
    );
  }

  List<Widget> elements(
      DynamicFormModel model, double width, BuildContext context) {
    List<Widget> element = [];
    for (var i = 0; i < model.data.length; i++) {
      switch (model.data[i].type) {
        case "text_box":
          if (model.data[i].fieldName == "arrival_date") {
            element.add(
              InkWell(
                onTap: () {
                  controller.pickDate(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.centerLeft,
                  width: width * 0.9,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grayLight),
                  ),
                  child: CustomText(
                      color:
                          controller.formattedDate.value == '' ? gray : black,
                      text: controller.formattedDate.value == ''
                          ? 'Arrival Date'
                          : controller.formattedDate.value),
                ),
              ),
            );
          } else if (model.data[i].fieldName == "arrival_time") {
            element.add(
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    controller.timePicker(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    alignment: Alignment.centerLeft,
                    width: width * 0.9,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: grayLight),
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
            );
          } else {
            element.add(
              CustomEditText(
                label: model.data[i].label,
                value: '',
                textInputType: model.data[i].type == "contact_number"
                    ? TextInputType.number
                    : TextInputType.text,
                width: width * 0.9,
                errorText: controller.errorCollection[i].error,
                onChange: (value) {
                  for (var j = 0; j < controller.collectionData.length; j++) {
                    if (controller.collectionData[j].fieldId ==
                        model.data[i].id) {
                      controller.collectionData[j].value = value;
                    }
                  }
                  // controller.contactPersonError.value = '';
                  // controller.contactPersonName.value = value;
                },
                hintText: 'Jhon dee',
              ),
            );
          }
          break;
        case "drop_down":
          if (model.data[i].fieldName == "companies_id") {
            element.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.0,
                      margin: const EdgeInsets.only(bottom: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grayLight)),
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
                            controller.companySelectedId.value = companyId;
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
                          controller.errorCollection[i].error == '' ? false : true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: CustomText(
                          text: controller.errorCollection[i].error,
                          color: colorPrimary,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (model.data[i].fieldName == "travel_by") {
            element.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.0,
                      margin: const EdgeInsets.only(bottom: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grayLight)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          hint: CustomText(
                            text: "Mode of Travel",
                          ),
                          value: controller.selectedTravel.value,
                          onChanged: (newValue) async {
                            controller.selectedTravel.value = newValue!;
                          },
                          items:
                              controller.transportationList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: CustomText(
                                text: items,
                                color: items == "Mode of Travel" ? gray : black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.errorCollection[i].error == '' ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CustomText(
                          text: controller.errorCollection[i].error,
                          color: colorPrimary,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          break;
        default:
      }
    }

    return element;
  }
}
