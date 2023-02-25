import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Obx(
            () {
              print(controller.count.value);
              return Column(
                children: [
                  SizedBox(
                    height: height / 2.1,
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
                        //         text: "Create an\nAccount",
                        //         size: 36,
                        //         color: white,
                        //         fontfamily: 'semiBold',
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Create an Account !",
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
                                // setState(() {
                                //   email = value;
                                // });
                              },
                              hintText: 'xyz@gmail.com',
                            ),
                            CustomEditText(
                              label: 'Company Code',
                              width: width * 0.8,
                              textInputType: TextInputType.emailAddress,
                              onChange: (value) {
                                controller.companyCode.value = value;
                                // setState(() {
                                //   email = value;
                                // });
                              },
                              hintText: 'D5DW9D',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    width: width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Sign Up',
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
                              // print(controller.companyCode.value);
                              // print(controller.email.value);
                              controller.signUpRequest(context);
                              // if (email == '' || password == '') {
                              //   Get.snackbar("Required", "Details can't be Blank!");
                              // } else {
                              //   loginRequest(email, password, context);
                              // }
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
                  Container(
                    width: width * 0.8,
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        // navigationController
                        //     .navigateTO(forgotPassScreenRoute);
                        Get.back();
                        // Get.to(LoginScreen());
                      },
                      child: CustomText(
                        text: 'Have an Account ?',
                        size: 16,
                        isUnderline: true,
                        fontfamily: 'semiBold',
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
