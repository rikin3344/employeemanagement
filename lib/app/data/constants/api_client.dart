// import 'dart:math';

// import 'package:employeemanagement/model/employee_details_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../model/employee_model.dart';
import 'dart:developer';

import 'package:addrec_employee_management/app/modules/employee-details/models/new_employee_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/null_employe_details_model.dart';
import 'package:http/http.dart' as http;

import 'package:addrec_employee_management/app/modules/home/model/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APiConst {
  static String baseUrl = 'https://onboarding.addrecsolutions.com/api/';
  static String prefix = 'Bearer ';
}

// String getRandomString(int length) {
//   const _chars =
//       "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890~!@#%^&*()`_-+=]}[{;:'|/?.><,";

//   Random _rnd = Random();

//   return String.fromCharCodes(
//       List.generate(length, (index) => _rnd.nextInt(33) + 89));
// }

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
    try {
      EmployeesModel employeeModel = employeesModelFromJson(response.body);

      return employeeModel;
    } catch (e) {
      log(e.toString());
      return EmployeesModel(
          success: true,
          errorcode: '1',
          data: Datanum(
              employees: [],
              totalEmployees: 0,
              totalPendingEmployees: 0,
              totalDoneEmployees: 0),
          message: 'message',
          accessToken: 'accessToken');
    }
  } else {
    print(response.statusCode.toString() + "responseCode");
    throw Exception('Failed');
  }
}

Future<EmployeeDetailsModel> getEmployeeDetails(employeeId) async {
  print(employeeId + 'employeeid');
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
    // print(response.body);
    EmployeeDetailsModel model = employeeDetailsModelFromJson(response.body);
    return model;
  } else {
    print(response.statusCode);
    throw Exception('Failed');
  }
}

Future<NullEmployeeDetailsModel> nullGetEmployeeDetails(employeeId) async {
  print(employeeId + 'employeeid');
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
    // print(response.body);
    NullEmployeeDetailsModel model = nullEmployeeDetailsModelFromJson(response.body);
    return model;
  } else {
    print(response.statusCode);
    throw Exception('Failed');
  }
}
