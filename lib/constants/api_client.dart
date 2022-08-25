import 'dart:io' show Platform;
import 'dart:math';
import 'package:employeemanagement/model/login_model.dart';
import 'package:employeemanagement/widgets/loding.dart';
import 'package:http/http.dart' as http;

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Loading loading = Loading();

class APiConst {
  static String baseUrl = 'https://onboarding.addrecsolutions.com/api/';
}

class ApiRequest {}

String getRandomString(int length) {
  const _chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890~!@#%^&*()`_-+=]}[{;:'|/?.><,";

  Random _rnd = Random();

  return String.fromCharCodes(
      List.generate(length, (index) => _rnd.nextInt(33) + 89));
}
