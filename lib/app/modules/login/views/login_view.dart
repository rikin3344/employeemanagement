import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        left: 25,
                        bottom: 120,
                        child: Container(
                            width: 188,
                            child: CustomText(
                              text: "Welcome",
                              size: 32,
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
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Sign in with your Credential !",
                          size: 20,
                          fontfamily: 'semiBold',
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Obx(
                            () => Column(
                              children: [
                                CustomEditText(
                                  label: 'Email',
                                  width: width * 0.8,
                                  onChange: (value) {
                                    controller.email.value = value;
                                  },
                                  hintText: 'xyz@gmail.com',
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  height: 50.0,
                                  width: width * 0.8,
                                  child: TextFormField(
                                    obscureText:
                                        !controller.isObscureText.value,
                                    cursorColor: colorSecondary,
                                    onChanged: (value) {
                                      controller.password.value = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: colorSecondary)),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.isObscureText.value =
                                                  !controller
                                                      .isObscureText.value;
                                            },
                                            icon: Icon(
                                              Icons.remove_red_eye_rounded,
                                              color:
                                                  controller.isObscureText.value
                                                      ? colorPrimary
                                                      : grayLight,
                                            )),
                                        labelStyle: TextStyle(color: gray),
                                        // helperText:
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: grayLight))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  width: width * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
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
                                                borderRadius:
                                                    BorderRadius.circular(71),
                                              )),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          onPressed: () {
                                            if (controller.email.value == '' ||
                                                controller.password.value ==
                                                    '') {
                                              controller.popUp.start(
                                                  context,
                                                  'Required',
                                                  "Details can't be Blank!",
                                                  100.0,
                                                  colorPrimary,
                                                  () {});
                                              // Get.snackbar("Required",
                                              //     "Details can't be Blank!");
                                            } else {
                                              controller.loginRequest(context);
                                            }
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
                              ],
                            ),
                          )),
                      Container(
                        width: width * 0.8,
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
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
                                Get.toNamed(Routes.FORGOT_PASSWORD);
                              },
                              child: CustomText(
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
      ),
    );
  }
}
