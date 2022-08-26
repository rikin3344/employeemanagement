import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginConformation extends StatefulWidget {
  const LoginConformation({Key? key}) : super(key: key);

  @override
  State<LoginConformation> createState() => _LoginConformationState();
}

class _LoginConformationState extends State<LoginConformation> {
  late SharedPreferences pref;
  setUpPrefData() async {
    pref = await SharedPreferences.getInstance();
    // print(pref.getBool('login')!);
    if (((pref.getBool('login')) ?? false)) {
      navigationController.navigateTO(homeRoute, []);
    } else {
      navigationController.navigateTO(loginRoute, []);
    }
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
    return Container(
      width: width,
      height: height,
      color: colorBackground,
    );
  }
}
