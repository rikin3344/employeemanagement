import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/screens/add_employe_services.dart';
import 'package:employeemanagement/screens/add_employee_other_details.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  int pageIndex = 0;
  List layoutPage = [
    const PersonalDetails(),
    const AddEmployeeOther(),
    const AddEmployeeServices()
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        if (pageIndex != 0) {
          setState(() {
            pageIndex--;
          });
          return Future.value(false);
        } else {
          navigationController.goBack();
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: black,
          iconTheme: const IconThemeData(color: black),
          titleSpacing: 0,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const CustomText(
              text: 'Add Employee Details',
              size: 18,
              fontfamily: 'bold',
            ),
          ),
        ),
        body: SafeArea(
          child: Expanded(
            child: Container(
              height: height,
              child: Stack(
                children: [
                  layoutPage[pageIndex],
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
                        onPressed: () {
                          setState(() {
                            if (layoutPage.length == (pageIndex + 1)) {
                              navigationController.goBack();
                            } else {
                              pageIndex++;
                            }
                          });
                        },
                        child: Icon(
                          layoutPage.length == (pageIndex + 1)
                              ? Icons.download_done_rounded
                              : Icons.arrow_forward_ios_rounded,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String companySelect = 'Company';
  var companyList = ['Company', 'xyz pvt ltd', 'TATA', 'Reliance'];
  DateTime selectedDate = DateTime.now();
  String formattedDate = '';
  TimeOfDay selectTime = TimeOfDay.now();
  String selectedTime = '';

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (newDate == null) return;
    setState(() {
      selectedDate = newDate;
      formattedDate = DateFormat("dd-MM-yyyy").format(selectedDate);
    });
  }

  Future timePicker(BuildContext context) async {
    final initialDate = TimeOfDay.now();
    final newTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: initialDate as TimeOfDay);
    if (newTime == null) return;
    setState(() {
      selectTime = newTime;
      // selectedTime = selectTime.toString().substring(10, 15);
      selectedTime = selectTime.format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Personal Details",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomEditText(
                    label: "First Name",
                    width: width * 0.4,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                  CustomEditText(
                    label: "last Name",
                    width: width * 0.4,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                ],
              ),
              CustomEditText(
                label: "Email Address",
                textInputType: TextInputType.emailAddress,
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
              ),
              CustomEditText(
                label: "Contact Number",
                prefixText: "+91",
                textInputType: TextInputType.number,
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
              ),
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grayLight)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isDense: true,
                    isExpanded: true,
                    hint: const CustomText(
                      text: "Company",
                    ),
                    value: companySelect,
                    onChanged: (newValue) async {
                      setState(() {
                        companySelect = newValue!;
                      });
                    },
                    items: companyList.map((String items) {
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
              CustomEditText(
                label: "Designation",
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
              ),
              InkWell(
                onLongPress: () {
                  pickDate(context);
                },
                onTap: () {
                  Get.snackbar("For Select or change date", 'Press and Hold!!');
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: width * 0.9,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grayLight),
                  ),
                  child: CustomText(
                      color: formattedDate == '' ? gray : black,
                      text:
                          formattedDate == '' ? 'Arrival Date' : formattedDate),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onLongPress: () {
                    timePicker(context);
                  },
                  onTap: () {
                    Get.snackbar(
                        "For Select or change time", 'Press and Hold!!');
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: width * 0.9,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: grayLight),
                    ),
                    child: CustomText(
                        color: selectedTime == '' ? gray : black,
                        text: selectedTime.toString() == ''
                            ? 'Arrival Time'
                            : selectedTime.toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
