import 'dart:async';

import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isObscureText = true;
  String email = '';
  String otp = '';
  late Timer _timer;
  int _start = 30;
  bool verifyClick = false;
  bool nextBtnVisible = false;
  int otpInt = 0;
  void startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print("object");
    return Scaffold(
      body: Container(
        width: width,
        height: height,
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
                            text: "Forgot Password",
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
                        text: "Reset your password !",
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
                            textInputType: TextInputType.emailAddress,
                            onChange: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              if (email != '') {
                                setState(() {
                                  verifyClick = true;
                                  startTimer();
                                });
                              }
                            },
                            child: !verifyClick
                                ? CustomText(
                                    text: "Verify",
                                    color: email != '' ? colorPrimary : gray,
                                    fontfamily: 'semiBold',
                                  )
                                : _start != 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CustomText(
                                            text: "Resend OTP after",
                                            size: 14,
                                            fontfamily: 'semiBold',
                                          ),
                                          const SizedBox(
                                            width: 7.0,
                                          ),
                                          CustomText(
                                            size: 16,
                                            fontfamily: 'semiBold',
                                            color: colorPrimary,
                                            text: "$_start Seconds",
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CustomText(
                                            text: "Didn't Received Code ?",
                                            size: 14,
                                            fontfamily: 'semiBold',
                                          ),
                                          const SizedBox(
                                            width: 7.0,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const CustomText(
                                              size: 16,
                                              fontfamily: 'semiBold',
                                              color: colorPrimary,
                                              text: "Resend Code",
                                            ),
                                          ),
                                        ],
                                      ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          CustomEditText(
                            label: 'OTP',
                            isEnable: verifyClick,
                            width: width * 0.8,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            textInputType: TextInputType.number,
                            onChange: (value) {
                              setState(() {
                                otp = value;
                                if (otp.length == 6) {
                                  nextBtnVisible = true;
                                } else {
                                  nextBtnVisible = false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: nextBtnVisible,
                      child: Container(
                        margin: const EdgeInsets.only(top: 0),
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Next',
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
                                  Get.offAllNamed(homeRoute);
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
                              // Get.to(const ForgotPassword());
                            },
                            child: const CustomText(
                              text: 'Have an account?',
                              size: 16,
                              isUnderline: true,
                              fontfamily: 'semiBold',
                            ),
                          ),
                        ],
                      ),
                    ),
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
