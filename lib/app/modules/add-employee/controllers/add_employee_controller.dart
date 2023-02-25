import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-employee/models/add_employee_model.dart';
import 'package:addrec_employee_management/app/modules/add-employee/models/update_employee_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddEmployeeController extends GetxController {
  PopUp popUp = PopUp();
  final count = 0.obs;
  RxMap<String, String> data = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'contact': '',
    'company': '',
    'designation': '',
    'arrivalDate': '',
    'selectedTime': '',
    'travelBy': '',
    'arrivalPlace': '',
    'familyMember': '',
    'note': '',
    'services': '',
    'hrbpName': '',
    'hrbpContact': '',
    'hrbpEmail': '',
    'businessName': '',
    'legalEntity': '',
  }.obs;
  RxInt pageIndex = 0.obs;

  RxString companySelect = 'Company'.obs;
  // RxList layoutPage = [
  //   PersonalDetailsView(controller),
  //   OtherDetailsView(controller),
  //   ServiceDetailsView(controller)
  // ].obs;

  DateTime selectedDate = DateTime.now();

  RxString formattedDate = ''.obs;
  TimeOfDay selectTime = TimeOfDay.now();
  RxString selectedTime = ''.obs;

  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString emailError = ''.obs;
  RxString contactError = ''.obs;
  RxString companyError = ''.obs;
  RxString designationError = ''.obs;
  RxString arrivalDateError = ''.obs;
  RxString arrivalTimeError = ''.obs;
  RxString travelByError = ''.obs;
  RxString arrivalPlaceError = ''.obs;
  RxString hrbpNameError = ''.obs;
  RxString hrbpContactError = ''.obs;
  RxString hrbpEmailError = ''.obs;
  RxString businessNameError = ''.obs;
  RxString legalEntityError = ''.obs;
  // RxString Error = ''.obs;
  var arguments = Get.arguments as Map<String, String>;

  var companyList = [
    'Company',
  ];

  var travelBy = [
    'Travel By',
    'Plane',
    'Bus',
    'Train',
    'Car',
    'Taxi',
  ];
  RxString selectedTravel = ''.obs;

  @override
  void onInit() async {
    selectedTravel.value = data['travelBy'].toString() != ''
        ? data['travelBy'].toString()
        : 'Travel By';
    // familyCheckBoxValue = checkBoxValue;
    print(arguments);
    if (!arguments.isNull) {
      await setUpDataForUpdate();
    } else {
      familyCheckBoxValue = checkBoxValue;
      employeeServiceCheckBoxValue = employeeServiceValue;
      print(familyCheckBoxValue);
    }
    for (var i = 0; i < companyData.length; i++) {
      companyList.add('${companyData[i].name} (${companyData[i].code})');
      if (data['company'] == companyData[i].id) {
        print(companyData[i].id);
        companySelect.value = '${companyData[i].name} (${companyData[i].code})';
      }
    }

    selectedDate = data['arrivalDate'] != '' ? DateTime.now() : DateTime.now();
    formattedDate.value = data['arrivalDate']!;
    selectTime = data['selectedTime'] != '' ? TimeOfDay.now() : TimeOfDay.now();
    selectedTime.value = data['selectedTime']!;
    super.onInit();
  }

  setUpDataForUpdate() async {
    data.value = arguments;
    familyList = json.decode(data['familyMember']!);
    serviceList = json.decode(data['services']!);
    // print(data['services']);
    // print(familyList);
    for (var i = 0; i < familyCheckBoxValue.length; i++) {
      for (var j = 0; j < familyList.length; j++) {
        // print(familyList[j].toString() + 'Rikin');

        if (familyCheckBoxValue[i].id.toString() == familyList[j].toString()) {
          familyCheckBoxValue[i].value = true;
        }
      }
    }
    for (var i = 0; i < employeeServiceCheckBoxValue.length; i++) {
      for (var j = 0; j < serviceList.length; j++) {
        if (employeeServiceCheckBoxValue[i].id.toString() ==
            serviceList[j].toString()) {
          employeeServiceCheckBoxValue[i].value = true;
        }
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void previousPage() {
    pageIndex.value--;
  }

  changePageIndex(context) {
    if (data['firstName'] == '') {
      firstNameError.value = 'Invalid Name!';
    } else {
      firstNameError.value = '';
    }

    if (data['lastName'] == '') {
      lastNameError.value = 'Invalid Name!';
    } else {
      lastNameError.value = '';
    }

    if (data['email'] == '') {
      emailError.value = 'Invalid email!';
    } else {
      // print((data['email']).toString().contains('.com'));
      if (!(data['email']).toString().contains('@') ||
          (!(data['email']).toString().contains('.com') &&
              !(data['email']).toString().contains('.in'))) {
        emailError.value = "Email contains @ or domain name!!";
      } else {
        emailError.value = "";
      }
    }

    if (data['contact'] == '') {
      contactError.value = "Invalid contact number !!";
    } else {
      if (data['contact'].toString().length != 10) {
        contactError.value = "Invalid contact number !";
      } else {
        contactError.value = "";
      }
    }

    if (data['company'] == '') {
      companyError.value = 'Select Company';
    } else {
      companyError.value = '';
    }

    if (data['designation'] == '') {
      designationError.value = 'Invalid Designation!';
    } else {
      designationError.value = '';
    }

    if (data['arrivalDate'] == '') {
      arrivalDateError.value = 'Select Date';
    } else {
      arrivalDateError.value = '';
    }

    if (data['selectedTime'] == '') {
      arrivalTimeError.value = 'Select Time';
    } else {
      arrivalTimeError.value = '';
    }

    if (data['hrbpName'] == '') {
      hrbpNameError.value = 'Invalid Name!';
    } else {
      hrbpNameError.value = '';
    }

    if (data['hrbpContact'] == '') {
      hrbpContactError.value = 'Invalid Number!';
    } else {
      if (data['hrbpContact'].toString().length != 10) {
        hrbpContactError.value = "Invalid contact number !";
      } else {
        hrbpContactError.value = "";
      }
    }

    if (data['hrbpEmail'] == '') {
      hrbpEmailError.value = 'Invalid Email!';
    } else {
      if (!(data['hrbpEmail']).toString().contains('@') ||
          (!(data['hrbpEmail']).toString().contains('.com') &&
              !(data['hrbpEmail']).toString().contains('.in'))) {
        hrbpEmailError.value = "Email contains @ or domain name!!";
      } else {
        hrbpEmailError.value = "";
      }
    }

    if (data['businessName'] == '') {
      businessNameError.value = 'Invalid Business Name!';
    } else {
      businessNameError.value = '';
    }

    if (data['legalEntity'] == '') {
      legalEntityError.value = 'Invalid Entity Name!';
    } else {
      legalEntityError.value = '';
    }

    if (firstNameError.value != '' ||
        lastNameError.value != '' ||
        emailError.value != '' ||
        contactError.value != '' ||
        companyError.value != '' ||
        designationError.value != '' ||
        arrivalDateError.value != '' ||
        hrbpNameError.value != '' ||
        hrbpContactError.value != '' ||
        hrbpEmailError.value != '' ||
        businessNameError.value != '' ||
        legalEntityError.value != '' ||
        arrivalTimeError.value != '') {
      print(data.toString());
    } else {
      print(arguments);
      if (!arguments.isNull) {
        print('update');
        updateEmployee(context, data['employeeID']);
      } else {
        print(data);
        print('add');
        addEmployee(context);
      }
      print(pageIndex);
    }
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: colorPrimary,
              colorScheme:
                  ColorScheme.light(primary: colorPrimary, onSurface: black),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colorSecondary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (newDate == null) return;
    selectedDate = newDate;
    formattedDate.value = DateFormat("dd-MM-yyyy").format(selectedDate);
    // formattedDate = selectedDate.toString();
    if (data['arrivalDate'] == '') {
      data['arrivalDate'] = formattedDate.value;
    } else {
      data.update('arrivalDate', (value123) => formattedDate.value);
    }
  }

  Future timePicker(BuildContext context) async {
    final initialDate = TimeOfDay.now();
    final newTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: colorPrimary,
                colorScheme:
                    ColorScheme.light(primary: colorPrimary, onSurface: black),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: colorSecondary, // button text color
                  ),
                ),
              ),
              child: child!,
            ),
        initialTime: initialDate);
    if (newTime == null) return;
    selectTime = newTime;
    // selectedTime = selectTime.toString().substring(10, 15);
    selectedTime.value = selectTime.format(context);
    if (data['selectedTime'] == '') {
      data['selectedTime'] = selectedTime.value;
    } else {
      data.update('selectedTime', (value123) => selectedTime.value);
    }
  }

  addEmployee(context) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    print(data['firstName']);
    Map params = {
      'user_id': userId,
      'device_token': deviceToken,
      'first_name': data['firstName'],
      'last_name': data['lastName'],
      'email': data['email'],
      'contact_number': data['contact'],
      'companies_id': data['company'],
      'designation': data['designation'],
      'arrival_date': data['arrivalDate'],
      'arrival_time': data['selectedTime'],
      'travel_by': 'plane',
      'arrival_place': 'Ahmedabad',
      'hrbp_name': data['hrbpName'],
      'hrbp_contact': data['hrbpContact'],
      'hrbp_email': data['hrbpEmail'],
      'business_name': data['businessName'],
      'legel_entity': data['legalEntity'],
      // 'status' : 's',
      // 'id': contact,
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-employee");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: params);
    print(params);
    if (response.statusCode == 200) {
      AddEmployeeModel model = addEmployeeModelFromJson(response.body);
      if (model.success || model.errorcode == '1') {
        // Get.snackbar("Added!", 'New Employee added Successfully!');
        data = {
          'firstName': '',
          'lastName': '',
          'email': '',
          'contact': '',
          'company': '',
          'designation': '',
          'arrivalDate': '',
          'selectedTime': '',
          'travelBy': '',
          'arrivalPlace': '',
          'familyMember': '',
          'note': '',
          'services': '',
          'hrbpName': '',
          'hrbpContact': '',
          'hrbpEmail': '',
          'businessName': '',
          'legalEntity': '',
        }.obs;
        employeeServiceValue = [];
        // Get.snackbar('Added!', model.message);
              loading.stopDialog(context);

        popUp.start(context, 'Added!', model.message, 100.0, colorPrimary, () {
          Future.delayed(
            const Duration(seconds: 0),
            () {
              // navigationController.navigateTO(homeRoute, []);
              Get.offNamed(Routes.HOME);
            },
          );
        });
      } else {
        // Get.snackbar("Error!", model.message);

        loading.stopDialog(context);
        popUp.start(
            context, "Error!", model.message, 100.0, colorPrimary, () {});
      }
    } else {
      // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
      // print(response.body);
      loading.stopDialog(context);
      popUp.start(context, response.statusCode.toString(),
          'Something went wrong!', 100.0, colorPrimary, () {});
      // throw Exception('Failed');
    }
  }

  updateEmployee(context, empId) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map params = {
      'user_id': userId,
      'device_token': deviceToken,
      'first_name': data['firstName'],
      'last_name': data['lastName'],
      'email': data['email'],
      'contact_number': data['contact'],
      'companies_id': data['company'],
      'designation': data['designation'],
      'arrival_date': data['arrivalDate'],
      'arrival_time': data['selectedTime'],
      'travel_by': data['travelBy'],
      'arrival_place': data['arrivalPlace'],
      'hrbp_name': data['hrbpName'],
      'hrbp_contact': data['hrbpContact'],
      'hrbp_email': data['hrbpEmail'],
      'business_name': data['businessName'],
      'legel_entity': data['legalEntity'],
      'id': empId
      // 'id': contact,
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-employee");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: params);
    if (response.statusCode == 200) {
      UpdateEmpModel model = updateEmpModelFromJson(response.body);
      if (model.success || model.errorcode == '1') {
        // Get.snackbar("Updated!", 'Employee details update Successfully!');
        data = {
          'firstName': '',
          'lastName': '',
          'email': '',
          'contact': '',
          'company': '',
          'designation': '',
          'arrivalDate': '',
          'selectedTime': '',
          'travelBy': '',
          'arrivalPlace': '',
          'familyMember': '',
          'note': '',
          'services': '',
          'hrbpName': '',
          'hrbpContact': '',
          'hrbpEmail': '',
          'businessName': '',
          'legalEntity': '',
        }.obs;
        // Get.snackbar('Updated!', model.message);
        employeeServiceValue = [];
            loading.stopDialog(context);
        Future.delayed(
          const Duration(seconds: 0),
          () {
            // navigationController.navigateTO(homeRoute, []);
            Get.offAllNamed(Routes.HOME);
          },
        );

        popUp.start(
            context, 'Updated!', model.message, 100.0, colorPrimary, () {});
      } else {
        // Get.snackbar("Error!", model.message);
        loading.stopDialog(context);
        popUp.start(
            context, "Error!", model.message, 100.0, colorPrimary, () {});
      }
    } else {
      // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
      print(response.body);
      loading.stopDialog(context);
      popUp.start(context, response.statusCode.toString(),
          'Something went wrong!', 100.0, colorPrimary, () {});
      // throw Exception('Failed');
    }
  }
}
