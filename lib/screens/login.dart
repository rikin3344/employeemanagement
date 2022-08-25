import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/controller/navigation_controller.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
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
            ),
            Expanded(
              flex: 1,
              child: Container(
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
                            label: 'Email / Mobile',
                            width: width * 0.8,
                            onChange: (value) {},
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            height: 50.0,
                            width: width * 0.8,
                            child: TextFormField(
                              obscureText: isObscureText,
                              cursorColor: colorSecondary,
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
                    Container(
                      width: width * 0.8,
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomText(
                            text: 'Sign Up',
                            size: 16,
                            isUnderline: true,
                            fontfamily: 'semiBold',
                          ),
                          CustomText(
                            text: 'Forgot Password?',
                            size: 16,
                            isUnderline: true,
                            fontfamily: 'semiBold',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
