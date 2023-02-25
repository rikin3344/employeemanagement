import 'dart:io';
import 'dart:math';

import 'package:addrec_employee_management/app/modules/add-employee/views/other_details_view.dart';
import 'package:addrec_employee_management/app/modules/add-employee/views/personal_details_view.dart';
import 'package:addrec_employee_management/app/modules/home/model/check_box_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_services_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/family_details_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/role_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var iconMale = [
  'assets/images/male_one.png',
  'assets/images/male_two.png',
  'assets/images/male_three.png',
  'assets/images/male_four.png',
  'assets/images/male_five.png',
  'assets/images/male_six.png',
  'assets/images/male_seven.png',
  'assets/images/male_eight.png',
  'assets/images/male_nine.png',
  'assets/images/male_ten.png',
  'assets/images/male_eleven.png'
];

// double height = 0;
// double width = 0;
// var iconFemale = [
//   'assets/images/female_one.png',
//   'assets/images/female_two.png',
//   'assets/images/female_three.png',
//   'assets/images/female_four.png',
//   'assets/images/female_five.png',
//   'assets/images/female_six.png',
//   'assets/images/female_seven.png',
//   'assets/images/female_eight.png',
//   'assets/images/female_nine.png',
//   'assets/images/female_ten.png',
// ];
// List<Datum> roleData = Datum(id: '', name: '', status: '') as List<Datum>;

RxList addedCompanyList = [].obs;
int counter = 0;
List<DatumCompany> companyData = [];

List layoutPage = [PersonalDetailsView(), OtherDetailsView()];

List<FamilyData> familyData =
    FamilyData(id: '', familyMember: '', addedBy: '', isDefault: '', status: '')
        as List<FamilyData>;

List<ServiceData> employeeServiceData = [];

// Future<bool> navigation(context) async {
//   // navigationController.goBack();
//   Navigator.of(context).pop();
//   return (true);
// }

List<CheckBoxModel> checkBoxValue = [];
List<CheckBoxModel> familyCheckBoxValue = [];
List<CheckBoxModel> employeeServiceValue = [];
List<CheckBoxModel> employeeServiceCheckBoxValue = [];
// List<CheckBoxModel> employeeServiceValueDetails = [];

List selectedFamilyMember = [];
List selectedServices = [];

List familyList = [];
List serviceList = [];
List selectedEmployeeServices = [];

List<Employee> employee = [];

String getRandomString(int length) {
  const _chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890~!@#%^&*()`_-+=]}[{;:'|/?.><,";

  Random _rnd = Random();

  return String.fromCharCodes(
      List.generate(length, (index) => _rnd.nextInt(33) + 89));
}

List<Datum> roleData = [];

var companyListConst = ['Company'];

File? imageData;

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

logoutFunction() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('login', false);
  pref.clear();
  companyData = [];

  layoutPage = [
    PersonalDetailsView(),
    OtherDetailsView(),
  ];

  familyData = [];

  employeeServiceData = [];

  checkBoxValue = [];

  familyCheckBoxValue = [];

  employeeServiceValue = [];

  employeeServiceCheckBoxValue = [];

  selectedFamilyMember = [];
  selectedServices = [];

  familyList = [];
  serviceList = [];
  selectedEmployeeServices = [];

  employee = [];

  roleData = [];

  companyListConst = ['Company'];
  Get.offAllNamed(Routes.LOGIN);
}
