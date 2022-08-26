import 'package:employeemanagement/model/company_model.dart';
import 'package:employeemanagement/model/role_model.dart';
import 'package:employeemanagement/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
var iconFemale = [
  'assets/images/female_one.png',
  'assets/images/female_two.png',
  'assets/images/female_three.png',
  'assets/images/female_four.png',
  'assets/images/female_five.png',
  'assets/images/female_six.png',
  'assets/images/female_seven.png',
  'assets/images/female_eight.png',
  'assets/images/female_nine.png',
  'assets/images/female_ten.png',
];
List<Datum> roleData = Datum(id: '', name: '', status: '') as List<Datum>;
List<DatumCompany> companyData = DatumCompany(
    id: '',
    name: '',
    code: '',
    status: '',
    contactPerson: '',
    email: '',
    contactNumber: '',
    logo: '',
    addedBy: '') as List<DatumCompany>;
