import 'package:employeemanagement/layout.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/screens/add_company.dart';
import 'package:employeemanagement/screens/add_employee.dart';
import 'package:employeemanagement/screens/add_employee_other_details.dart';
import 'package:employeemanagement/screens/add_user.dart';
import 'package:employeemanagement/screens/employee_details.dart';
import 'package:employeemanagement/screens/forgot_password.dart';
import 'package:employeemanagement/screens/login.dart';
import 'package:employeemanagement/screens/login_conformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(Layout());
    case employeeDetailsScreenRoute:
      return _getPageRoute(EmployeeDetailsScreen(
        arguments: arguments as Map<dynamic, dynamic>,
      ));
    case addCompanyScreenRoute:
      return _getPageRoute(const AddCompany());
    case addManagerScreenRoute:
      return _getPageRoute(const AddUser());
    case addEmployeeScreenRoute:
      return _getPageRoute(const AddEmployee());
    case addEmployeeOtherScreenRoute:
      return _getPageRoute(const AddEmployeeOther());
    case forgotPassScreenRoute:
      return _getPageRoute(const ForgotPassword());
    case loginRoute:
      return _getPageRoute(const LoginScreen());
    default:
      return _getPageRoute(LoginConformation());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
