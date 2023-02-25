import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-employee/controllers/add_employee_controller.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OtherDetailsView extends GetView<AddEmployeeController> {
  OtherDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomText(
                text: "Other Details",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              SizedBox(
                height: 20.0,
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
                              color: controller.travelByError.value == ''
                                  ? grayLight
                                  : colorPrimary)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          hint: CustomText(
                            text: "Company",
                          ),
                          value: controller.selectedTravel.value,
                          onChanged: (newValue) async {
                            if (controller.data['travelBy'] == '') {
                              controller.data['travelBy'] = newValue.toString();
                            } else {
                              controller.data.update('travelBy',
                                  (value123) => newValue.toString());
                            }
                            controller.selectedTravel.value = newValue!;
                          },
                          items: controller.travelBy.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: CustomText(
                                text: items,
                                color: items == "Travel By" ? gray : black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.travelByError.value == '' ? false : true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: CustomText(
                          text: controller.travelByError.value,
                          color: colorPrimary,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomEditText(
                label: "Arrival Place",
                width: width * 0.9,
                errorText: controller.arrivalPlaceError.value,
                value: controller.data['arrivalPlace']! == ''
                    ? ''
                    : controller.data['arrivalPlace']!,
                onChange: (value) {
                  controller.arrivalPlaceError.value = '';
                  if (controller.data['arrivalPlace'] == '') {
                    controller.data['arrivalPlace'] = value;
                  } else {
                    controller.data.update('arrivalPlace', (value123) => value);
                  }
                },
                hintText: 'Delhi',
              ),
              CustomText(
                text: "Family Members",
                size: 14,
              ),
              Column(
                children: checkBox(width, controller),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                height: 100.0,
                width: width,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: colorSecondary,
                  maxLines: 5,
                  initialValue: controller.data['note'] == ''
                      ? ''
                      : controller.data['note'],
                  onChanged: (value) {
                    if (controller.data['note'] == '') {
                      controller.data['note'] = value;
                    } else {
                      controller.data.update('note', (value123) => value);
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Other Details",
                      labelStyle:  TextStyle(color: gray),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: colorSecondary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: grayLight))),
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> checkBox(double width, AddEmployeeController controller) {
    List<Widget> element = [];
    for (int i = 0; i < familyData.length; i++) {
      // familyCheckBoxValue.add(CheckBoxModel(
      //   id: familyData[i].id,
      // ));

      for (var j = 0; j < familyCheckBoxValue.length; j++) {
        if (familyData[i].id == familyCheckBoxValue[j].id) {
          element.add(
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
                        (states) =>  BorderSide(
                              color: colorPrimary,
                            )),
                    value: familyCheckBoxValue[j].value,
                    onChanged: (newValue) {
                      familyCheckBoxValue[j].value = newValue!;
                      if (selectedFamilyMember
                          .contains(familyCheckBoxValue[j].id)) {
                        selectedFamilyMember.remove(familyCheckBoxValue[j].id);
                      } else {
                        selectedFamilyMember.add(familyCheckBoxValue[j].id);
                      }
                      if (controller.data['familyMember'] == '') {
                        controller.data['familyMember'] =
                            selectedFamilyMember.toString();
                      } else {
                        controller.data.update('familyMember',
                            (value123) => selectedFamilyMember.toString());
                      }
                      // wifeOrHusband = value!;
                    },
                  ),
                  Flexible(
                    child: CustomText(
                        size: 16,
                        color:
                            familyCheckBoxValue[j].value ? colorPrimary : black,
                        fontfamily: familyCheckBoxValue[j].value
                            ? 'semiBold'
                            : 'medium',
                        text: familyData[i].familyMember),
                  ),
                ],
              ),
            ),
          );
        } else {
          // print('fuck off!!');
        }
      }
    }

    return element;
  }
}
