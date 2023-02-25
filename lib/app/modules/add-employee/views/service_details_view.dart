import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-employee/controllers/add_employee_controller.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ServiceDetailsView extends GetView<AddEmployeeController> {
  const ServiceDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // AddEmployeeController controller = Get.put(AddEmployeeController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Obx(
          () {
            print(controller.data['services']);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CustomText(
                  text: "Services",
                  size: 18,
                  fontfamily: "bold",
                  color: colorPrimary,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: checkBox(width, controller),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> checkBox(double width, AddEmployeeController controller) {
    List<Widget> element = [];
    for (int i = 0; i < employeeServiceData.length; i++) {
      // employeeServiceValue.add(CheckBoxModel(
      //   id: employeeServiceData[i].id,
      // ));

      for (var j = 0; j < employeeServiceCheckBoxValue.length; j++) {
        if (employeeServiceData[i].id == employeeServiceCheckBoxValue[j].id) {
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
                    value: employeeServiceCheckBoxValue[j].value,
                    onChanged: (newValue) {
                      employeeServiceCheckBoxValue[j].value = newValue!;

                      if (serviceList.isEmpty) {
                        serviceList.add(employeeServiceCheckBoxValue[j].id);
                        print(serviceList.toString() + 'ifadd');
                      } else {
                        if (serviceList
                            .contains(employeeServiceCheckBoxValue[j].id)) {
                          serviceList
                              .remove(employeeServiceCheckBoxValue[j].id);
                          print(serviceList.toString() + 'remove');
                        } else {
                          serviceList.add(employeeServiceCheckBoxValue[j].id);
                          print(serviceList.toString() + 'else add');
                        }
                      }

                      // if (serviceList
                      //     .contains(employeeServiceCheckBoxValue[j].id)) {
                      //   serviceList.remove(employeeServiceCheckBoxValue[j].id);
                      // } else {
                      //   serviceList.add(employeeServiceCheckBoxValue[j].id);
                      // }
                      if (controller.data['services'] == '') {
                        controller.data['services'] = serviceList.toString();
                      } else {
                        controller.data.update(
                            'services', (value123) => serviceList.toString());
                      }
                      print(controller.data['services']);
                      // wifeOrHusband = value!;
                    },
                  ),
                  Flexible(
                    child: CustomText(
                        size: 16,
                        color: employeeServiceCheckBoxValue[j].value
                            ? colorPrimary
                            : black,
                        fontfamily: employeeServiceCheckBoxValue[j].value
                            ? 'semiBold'
                            : 'medium',
                        text: employeeServiceData[i].name),
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
