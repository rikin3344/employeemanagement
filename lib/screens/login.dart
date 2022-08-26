import 'dart:io' show Platform;
import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/loding.dart';
import 'package:http/http.dart' as http;

import 'package:employeemanagement/constants/api_client.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/model/login_model.dart';
import 'package:employeemanagement/screens/forgot_password.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  String email = '';
  String password = '';
  late SharedPreferences pref;
  Loading loading = Loading();

  loginRequest(email, password, context) async {
    loading.start(context);

    String deviceToken = getRandomString(100);
    String intudid = '123';
    String deviceType = Platform.operatingSystem;
    String appVersion = '1';

    print("$deviceToken DT");
    print("$deviceType DType");
    print("$appVersion Version");

    Map data = {
      'email': email,
      'password': password,
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
      try {
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

        navigationController.navigateTO(homeRoute, []);
        // Navigator.pushNamed(context, homeRoute);

        // Get.offAll(ForgotPassword());
      } catch (e) {
        Get.snackbar(
            "Invalid Credential!", 'Are you sure your details is valid!');
      }
      loading.stopDialog(context);
    } else {
      print(response.statusCode);
      loading.stopDialog(context);
    }
  }

  setUpPrefData() async {
    pref = await SharedPreferences.getInstance();
    // print(pref.getBool('login')!);
    // if (pref.getBool('login')!) {
    //   navigationController.navigateTO(homeRoute);
    // }
  }

  @override
  void initState() {
    setUpPrefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 2,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset('assets/images/login_three.png'),
                    ),
                    Image.asset(
                      'assets/images/login_two.png',
                    ),
                    Image.asset(
                      'assets/images/login_one.png',
                    ),
                    Positioned(
                      left: 30,
                      bottom: 100,
                      child: Container(
                          width: 188,
                          child: const CustomText(
                            text: "WelcomeBack",
                            size: 36,
                            color: white,
                            fontfamily: 'semiBold',
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: const CustomText(
                        text: "Sign in with your Credential !",
                        size: 20,
                        fontfamily: 'semiBold',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          CustomEditText(
                            label: 'Email',
                            width: width * 0.8,
                            onChange: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            height: 50.0,
                            width: width * 0.8,
                            child: TextFormField(
                              obscureText: isObscureText,
                              cursorColor: colorSecondary,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorSecondary)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObscureText = !isObscureText;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: !isObscureText
                                            ? colorPrimary
                                            : grayLight,
                                      )),
                                  labelStyle: const TextStyle(color: gray),
                                  // helperText:
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: grayLight))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Sign in',
                            size: 32,
                            fontfamily: 'bold',
                          ),
                          SizedBox(
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
                                if (email == '' || password == '') {
                                  Get.snackbar(
                                      "Required", "Details can't be Blank!");
                                } else {
                                  loginRequest(email, password, context);
                                }
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Sign Up',
                            size: 16,
                            isUnderline: true,
                            fontfamily: 'semiBold',
                          ),
                          InkWell(
                            onTap: () {
                              // navigationController
                              //     .navigateTO(forgotPassScreenRoute);
                              Get.to(const ForgotPassword());
                            },
                            child: const CustomText(
                              text: 'Forgot Password?',
                              size: 16,
                              isUnderline: true,
                              fontfamily: 'semiBold',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
