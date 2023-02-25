// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/dynamic_form_model.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/form_data_model.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/form_error_data_model.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/get_transportation_modal.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/send_add_emp_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DynamicEmployeeFormController extends GetxController {
  final count = 0.obs;
  PopUp popUp = PopUp();
  Loading loading = Loading();
  var companyList = [
    'Company',
  ];
  var transportationList = [
    'Mode of Travel',
  ];
  late Future<DynamicFormModel> futureModel;
  List<TransportationData> transportationData = [];

  // RxList<Map> collectionData = [{}].obs;
  List<DynamicFormDataModal> collectionData = [];
  RxList<DynamicFormErrorDataModal> errorCollection =
      <DynamicFormErrorDataModal>[].obs;
  String email = '';

  RxString companySelect = 'Company'.obs;
  RxString companySelectedId = ''.obs;
  RxString selectedTravel = 'Mode of Travel'.obs;

  var travelBy = [
    'Travel By',
    'Plane',
    'Bus',
    'Train',
    'Car',
    'Taxi',
  ];
  DateTime selectedDate = DateTime.now();

  RxString formattedDate = ''.obs;
  TimeOfDay selectTime = TimeOfDay.now();
  RxString selectedTime = ''.obs;

  // List company
  @override
  void onInit() {
    futureModel = getFormData();
    super.onInit();
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
  }

  Future<DynamicFormModel> getFormData() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = await messaging.getToken() ?? '';
    String accessToken = pref.getString('accessToken')!;
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse('${APiConst.baseUrl}get-employee-fields');
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      if (data['success'] || data['errorcode'] == '1') {
        DynamicFormModel model = dynamicFormModelFromJson(response.body);
        for (var i = 0; i < model.data.length; i++) {
          collectionData.add(DynamicFormDataModal(
              fieldId: model.data[i].id,
              value: "",
              fieldName: model.data[i].fieldName));
          errorCollection.add(DynamicFormErrorDataModal(
              fieldId: model.data[i].id,
              value: model.data[i].type,
              error: "",
              fieldName: model.data[i].fieldName));
        }
        // print('done');
        for (var i = 0; i < companyData.length; i++) {
          companyList.add('${companyData[i].name} (${companyData[i].code})');
          if (data['company'] == companyData[i].id) {
            print(companyData[i].id);
            companySelect.value =
                '${companyData[i].name} (${companyData[i].code})';
          }
        }
        await getCompanies();
        await getTransportation();
        return model;
      } else {
        print(data['message']);
        throw Exception('Failed');
      }
    } else {
      print(response.statusCode.toString() + "responseCode");
      throw Exception('Failed');
    }
  }

  getTransportation() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}get-transportations");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['success'] ||
          responseData['errorcode'].toString() == "1") {
        TransportationModal modal = transportationModalFromJson(response.body);
        transportationData = modal.data;
        for (var i = 0; i < modal.data.length; i++) {
          if (modal.data[i].status.toString() == "1") {
            transportationList.add(modal.data[i].name);
          }
        }
      }
    } else {
      print(response.statusCode.toString() + "responseCodeTransportaiion");
      throw Exception('Failed');
    }
  }

  checkError(context) {
    int error = 0;
    String companyId = '';
    String transportationId = '';

    for (var i = 0; i < companyData.length; i++) {
      if (companySelect.value ==
          '${companyData[i].name} (${companyData[i].code})') {
        companyId = companyData[i].id;
      }
    }

    for (var i = 0; i < transportationData.length; i++) {
      if (selectedTravel.value == transportationData[i].name) {
        transportationId = transportationData[i].id;
      }
    }

    for (var i = 0; i < collectionData.length; i++) {
      if (collectionData[i].fieldName == "companies_id") {
        collectionData[i].value = companyId;
      }
      if (collectionData[i].fieldName == "travel_by") {
        collectionData[i].value = transportationId;
      }
    }
    for (var i = 0; i < collectionData.length; i++) {
      if (collectionData[i].value == "") {
        if (errorCollection[i].value == "drop_down") {
          print("if if");
          errorCollection[i].error == "Not Selected!";
        } else {
          print("if else");
          errorCollection[i].error == "Not Be Blank!";
        }
      } else if (collectionData[i].fieldName == "email") {
        if (!(collectionData[i].value).toString().contains('@') ||
            (!(collectionData[i].value).toString().contains('.com') &&
                !(collectionData[i].value).toString().contains('.in'))) {
          print("else if if");
          errorCollection[i].error = "Email contains @ or domain name!!";
        } else {
          print("else if else");
          errorCollection[i].error = "";
        }
      } else if (collectionData[i].fieldName == "contact_number") {
        if (collectionData[i].value.toString().length != 10) {
          print("2else if if");
          errorCollection[i].error = "Invalid contact number !";
        } else {
          print("2else if else");
          errorCollection[i].error = "";
        }
      } else {
        print(errorCollection[i].error + " error");
        // errorCollection[i].error == "";
      }
      for (var i = 0; i < errorCollection.length; i++) {
        if (errorCollection[i].error != "") {
          error++;
        }
      }
      if (error == 0) {
        String companyId = '';
        String transportationId = '';

        for (var i = 0; i < companyData.length; i++) {
          if (companySelect.value ==
              '${companyData[i].name} (${companyData[i].code})') {
            companyId = companyData[i].id;
          }
        }

        for (var i = 0; i < transportationData.length; i++) {
          if (selectedTravel.value == transportationData[i].name) {
            transportationId = transportationData[i].id;
          }
        }

        for (var i = 0; i < collectionData.length; i++) {
          if (collectionData[i].fieldName == "companies_id") {
            collectionData[i].value = companyId;
          }
          if (collectionData[i].fieldName == "travel_by") {
            collectionData[i].value = transportationId;
          }
        }
      }
    }
    callAddEmpApi(context);
    update();
  }

  callAddEmpApi(context) async {
    loading.start(context);
    for (var i = 0; i < collectionData.length; i++) {
      if (collectionData[i].fieldName == "email") {
        email = collectionData[i].value;
      }
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      "employee_data": dynamicFormDataModalToJson(collectionData),
      "email": email
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-employee");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['success'] ||
          responseData['errorcode'].toString() == "1") {
        SendAddDataModel model = sendAddDataModelFromJson(response.body);
        // Get.snackbar('Success', model.message);
        loading.stopDialog(context);
        popUp.start(context, 'Success', model.message, 100.0, colorPrimary, () {
          Future.delayed(
            const Duration(seconds: 0),
            () {
              // navigationController.navigateTO(homeRoute, []);

              Get.offNamed(Routes.HOME);
              // Navigator.pop(context);
            },
          );
        });
      } else {
        loading.stopDialog(context);
        // Get.snackbar('Error', responseData['message']);
        popUp.start(context, 'Error', responseData['message'], 100.0,
            colorPrimary, () {});
      }
    } else {
      loading.stopDialog(context);
      // print(response.statusCode.toString() + "responseCodeTransportaiion");
      throw Exception('Failed');
    }
  }

  getCompanies() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}display-company");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
    } else {
      print(response.statusCode.toString() + "responseCodeCompany");
      throw Exception('Failed');
    }
  }
}
