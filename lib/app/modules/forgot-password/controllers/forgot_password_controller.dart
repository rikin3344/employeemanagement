// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/forgot-password/models/save_password_model.dart';
import 'package:addrec_employee_management/app/modules/forgot-password/models/send_email_otp.dart';
import 'package:addrec_employee_management/app/modules/forgot-password/models/send_email_otp_error.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final count = 30.obs;
  PopUp popUp = PopUp();
  RxBool isObscureText = true.obs;
  RxString email = ''.obs;
  RxString otp = ''.obs;
  late Timer _timer;
  // final _start = 30.obs;
  RxBool verifyClick = false.obs;
  RxBool nextBtnVisible = false.obs;
  RxInt otpInt = 0.obs;
  String trueOtp = '';
  void startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      if (count.value == 0) {
        // timer
        timer.cancel();
        count.value = 30;
      } else {
        count.value--;
      }
    });
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  void onInit() {
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

  sendMailForOtp(context123) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    Loading loading = Loading();
    loading.start(context123);
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {
      'device_token': deviceToken,
      'email': email.value,
    };
    var url = Uri.parse("${APiConst.baseUrl}send-forgot-password-email");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data);

    if (response.statusCode == 200) {
      print(response.body);
      // loading.stopDialog(context);
      Map data = json.decode(response.body);
      // print(data);
      if (data['success'] == true || data['errorcode'] == '1') {
        SendEmailOtp model = sendEmailOtpFromJson(response.body);
        verifyClick.value = true;
        loading.stopDialog(context123);
        trueOtp = model.data.otpCode.toString();
        startTimer();
        print(trueOtp);
      } else {
        SendEmailOtpError model = sendEmailOtpErrorFromJson(response.body);
        // Get.snackbar('Error', model.message);
        loading.stopDialog(context123);

        popUp.start(
            context123, 'Error', 'model.message', 100.0, colorPrimary, () {});
      }
    } else {
      // print(response.statusCode);
      // Get.snackbar(response.statusCode.toString(), 'message');
      loading.stopDialog(context123);

      popUp.start(context123, response.statusCode.toString(),
          'Something goes wrong!', 100.0, colorPrimary, () {});
    }
  }

  matchOtp(context123) async {
    Loading loading = Loading();
    loading.start(context123);
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String deviceToken = pref.getString('deviceToken')!;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    Map data = {
      'device_token': deviceToken,
      'email': email.value,
      'otp_code': otp.value,
    };
    var url = Uri.parse("${APiConst.baseUrl}verify-otp");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data);

    if (response.statusCode == 200) {
      print(response.body);

      Map data = json.decode(response.body);
      if (data['success'] == true || data['errorcode'] == '1') {
        SendEmailOtp model = sendEmailOtpFromJson(response.body);
        verifyClick.value = true;
        loading.stopDialog(context123);
        trueOtp = model.data.otpCode.toString();
        count.value = 0;
        showDialog(
          context: context123,
          builder: (context) {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            return PasswordDialog(
              width: width,
              height: height,
              email: email.value,
              context123: context123,
            );
          },
        );
        // startTimer();
      } else {
        loading.stopDialog(context123);
        popUp.start(
            context123, 'Error', data['message'], 100.0, colorPrimary, () {});
        // Get.snackbar("Error!", data['message']);
      }
    } else {
      print(response.statusCode);
      loading.stopDialog(context123);
    }
  }
}

class PasswordDialog extends StatefulWidget {
  final double width;
  final double height;
  final String email;
  final BuildContext context123;
  const PasswordDialog(
      {Key? key,
      required this.width,
      required this.height,
      required this.email,
      required this.context123})
      : super(key: key);

  @override
  State<PasswordDialog> createState() => PasswordDialogState();
}

class PasswordDialogState extends State<PasswordDialog> {
  RxString newPassword = ''.obs;
  RxString confirmPassword = ''.obs;
  RxString confirmPasswordError = ''.obs;
  PopUp popUp = PopUp();

  saveNewPassword(context) async {
    Loading loading = Loading();
    loading.start(context);
    // SharedPreferences pref = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    Map data = {
      'device_token': deviceToken,
      'email': widget.email,
      'password': confirmPassword.value,
    };
    var url = Uri.parse("${APiConst.baseUrl}save-new-password");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data);

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      if (data['errorcode'] == '1') {
        SavePasswordModel model = savePasswordModelFromJson(response.body);
        // Get.snackbar('Success', model.message);

        loading.stopDialog(context);
        loading.stopDialog(context);
        // loading.stopDialog(context);

        popUp.start(widget.context123, 'Success', model.message, 100.0, green,
            () {
          Future.delayed(
            const Duration(seconds: 0),
            () {
              // navigationController.navigateTO(homeRoute, []);
              Get.offNamed(Routes.LOGIN);
            },
          );
        });
      } else {
        loading.stopDialog(context);
        // Get.snackbar('Error', data['message']);
        popUp.start(
            context, 'Error', data['message'], 100.0, colorPrimary, () {});
      }
    } else {
      print(response.statusCode);
      loading.stopDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: widget.width * 0.85,
        height: confirmPasswordError.value == ''
            ? widget.height * 0.25
            : widget.height * 0.232,
        // color: white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: CustomText(
                text: 'Set up new Password',
                color: colorPrimary,
                fontfamily: 'semiBold',
              ),
            ),
            CustomEditText(
              label: 'New Password',
              width: widget.width * 0.8,
              onChange: (value) {
                setState(() {
                  newPassword.value = value;
                });
              },
              hintText: '***************',
            ),
            CustomEditText(
              label: 'Confirm Password',
              width: widget.width * 0.8,
              wantPadding: false,
              errorText: confirmPasswordError.value,
              onChange: (value) {
                setState(() {
                  confirmPassword.value = value;
                });
              },
              hintText: '***************',
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          child: CustomText(text: "Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (newPassword.value != confirmPassword.value) {
              setState(() {
                confirmPasswordError.value = 'Password not match!!';
              });
            } else {
              setState(() {
                confirmPasswordError.value = '';
              });
              saveNewPassword(context);
            }
            // navigationController
            //     .navigateTO(loginRoute, []);
            // Get.offAll(localNavigator());
          },
          child: CustomText(
            text: "Confirm",
            fontfamily: 'semiBold',
            color: colorPrimary,
          ),
        ),
      ],
    );
  }
}
