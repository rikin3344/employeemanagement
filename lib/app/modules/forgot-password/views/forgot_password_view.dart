import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print("object");
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                    // Positioned(
                    //   left: 30,
                    //   bottom: 100,
                    //   child: SizedBox(
                    //       width: 188,
                    //       child: CustomText(
                    //         text: "Forgot Password",
                    //         size: 36,
                    //         color: white,
                    //         fontfamily: 'semiBold',
                    //       )),
                    // ),
                  ],
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    Container(
                      width: width,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "Reset your password !",
                        size: 20,
                        fontfamily: 'semiBold',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          CustomEditText(
                            label: 'Email',
                            width: width * 0.8,
                            textInputType: TextInputType.emailAddress,
                            onChange: (value) {
                              controller.email.value = value;
                            },
                            hintText: 'xyz@gmail.com',
                          ),
                          InkWell(
                            onTap: () {
                              if (controller.email.value != '' &&
                                  controller.email.value
                                      .toString()
                                      .contains('@') &&
                                  (controller.email.value.contains('.com') ||
                                      controller.email.value.contains('.in'))) {
                                controller.sendMailForOtp(context);
                              } else {
                                print('csc');
                              }
                            },
                            child: !controller.verifyClick.value
                                ? CustomText(
                                    text: "Verify",
                                    color: (controller.email.value != '' &&
                                            controller.email.value
                                                .toString()
                                                .contains('@') &&
                                            (controller.email.value
                                                    .contains('.com') ||
                                                controller.email.value
                                                    .contains('.in')))
                                        ? colorPrimary
                                        : gray,
                                    fontfamily: 'semiBold',
                                  )
                                : (controller.count.value != 0 &&
                                        controller.count.value != 30)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Resend OTP after",
                                            size: 14,
                                            fontfamily: 'semiBold',
                                          ),
                                          SizedBox(
                                            width: 7.0,
                                          ),
                                          CustomText(
                                            size: 16,
                                            fontfamily: 'semiBold',
                                            color: colorPrimary,
                                            text:
                                                "${controller.count.value} Seconds",
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Didn't Received Code ?",
                                            size: 14,
                                            fontfamily: 'semiBold',
                                          ),
                                          SizedBox(
                                            width: 7.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .sendMailForOtp(context);
                                              controller.verifyClick.value =
                                                  true;
                                            },
                                            child: CustomText(
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
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          CustomEditText(
                            label: 'OTP',
                            isEnable: controller.verifyClick.value,
                            width: width * 0.8,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            textInputType: TextInputType.number,
                            onChange: (value) {
                              controller.otp.value = value;
                              if (controller.otp.value.length == 6) {
                                controller.nextBtnVisible.value = true;
                              } else {
                                controller.nextBtnVisible.value = false;
                              }
                            },
                            hintText: '######',
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.nextBtnVisible.value,
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
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
                                  controller.matchOtp(context);
                                  // Get.offAllNamed(homeRoute);
                                },
                                child: Icon(
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
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.SIGN_UP);
                            },
                            child: CustomText(
                              text: 'Sign Up',
                              size: 16,
                              isUnderline: true,
                              fontfamily: 'semiBold',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // navigationController
                              //     .navigateTO(forgotPassScreenRoute);
                              // Get.to(ForgotPassword());

                              Get.back();
                            },
                            child: CustomText(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
