import 'dart:convert';
import 'dart:io' show Platform;

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/login/model/login_error_model.dart';
import 'package:addrec_employee_management/app/modules/login/model/login_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final count = 0.obs;
  PopUp popUp = PopUp();
  RxBool isObscureText = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  late SharedPreferences pref;
  Loading loading = Loading();
  @override
  void onInit() {
    getSharedPref();
    super.onInit();
  }

  @override
  void onReady() {
    getSharedPref();
    super.onReady();
  }

  void increment() => count.value++;

  getSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  loginRequest(context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    pref = await SharedPreferences.getInstance();
    loading.start(context);

    // String deviceToken = getRandomString(100);
    String intudid = '123';
    String deviceType = Platform.operatingSystem;
    String appVersion = '1';

    print("$deviceToken DT");
    print("$deviceType DType");
    print("$appVersion Version");

    Map data = {
      'email': email.value,
      'password': password.value,
      'device_token': deviceToken,
      'intudid': intudid,
      'device_type': 'Android',
      'app_version': appVersion
    };
    var url = Uri.parse("${APiConst.baseUrl}login");

    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data);

    if (response.statusCode == 200) {
      // try {
      Map body = json.decode(response.body);
      print(body['errorcode']);
      if (body['errorcode'] == '1') {
        LoginModel model = loginModelFromJson(response.body);
        pref.setString('userId', model.data.id);
        pref.setBool("login", true);
        pref.setString('companyId', model.data.companiesId);
        pref.setString('firstName', model.data.firstName);
        pref.setString('lastName', model.data.lastName);
        pref.setString('email', model.data.email);
        pref.setString('phoneNumber', model.data.phoneNumber);
        pref.setString('profilePic', model.data.profilePic);
        pref.setString('roleId', model.data.roleId);
        pref.setString('addedBy', model.data.addedBy);
        pref.setString('accountStatus', model.data.status);
        pref.setString('accessToken', model.accessToken);
        pref.setString('deviceToken', deviceToken);
        pref.setInt('counter', 1);

        // Navigator.pushNamed(context, Routes.HOME);
        loading.stopDialog(context);
        // Get.to(Layout());
        Get.toNamed(Routes.HOME);
        counter = 1;
      } else {
        LoginErrorModel model = loginErrorModelFromJson(response.body);
        // Get.snackbar('Error!', model.data);
        loading.stopDialog(context);
        popUp.start(context, 'Error', model.data, 100.0, colorPrimary, () {});
      }

      // Get.named
      // navigationController.navigateTO(homeRoute, []);
      // navigationController.navigateTOPush(localNavigator());

      // Navigator.pushNamed(context, homeRoute);

      // Get.offAll(ForgotPassword());
      // } catch (e) {
      //   print('Rikin' + e.toString());
      //   Get.snackbar(
      //       "Invalid Credential!", 'Are you sure your details is valid!');
      // }
      // loading.stopDialog(context);
    } else {
      loading.stopDialog(context);
    }
  }
}
