import 'dart:math';

import 'package:employeemanagement/model/employee_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/employee_model.dart';
import 'package:http/http.dart' as http;

class APiConst {
  static String baseUrl = 'https://onboarding.addrecsolutions.com/api/';
  static String prefix = 'Bearer ';
}

String getRandomString(int length) {
  const _chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890~!@#%^&*()`_-+=]}[{;:'|/?.><,";

  Random _rnd = Random();

  return String.fromCharCodes(
      List.generate(length, (index) => _rnd.nextInt(33) + 89));
}

Future<EmployeesModel> getEmployee() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String userId = pref.getString('userId')!;
  String deviceToken = pref.getString('deviceToken')!;
  String accessToken = pref.getString('accessToken')!;
  Map data = {'user_id': userId, 'device_token': deviceToken};
  var url = Uri.parse('${APiConst.baseUrl}display-employees');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": '${APiConst.prefix}$accessToken'
      },
      body: data);
  if (response.statusCode == 200) {
    EmployeesModel employeeModel = employeesModelFromJson(response.body);
    return employeeModel;
  } else {
    throw Exception('Failed');
  }
}

Future<EmployeeDetailsModel> getEmployeeDetails(employeeId) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String userId = pref.getString('userId')!;
  String deviceToken = pref.getString('deviceToken')!;
  String accessToken = pref.getString('accessToken')!;
  Map data = {'user_id': userId, 'device_token': deviceToken, 'id': employeeId};
  var url = Uri.parse('${APiConst.baseUrl}edit-employee');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": '${APiConst.prefix}$accessToken'
      },
      body: data);
  if (response.statusCode == 200) {
    EmployeeDetailsModel employeeDetailsModel =
        employeeDetailsModelFromJson(response.body);
    return employeeDetailsModel;
  } else {
    throw Exception('Failed');
  }
}
