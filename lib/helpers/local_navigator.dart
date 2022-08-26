import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/routes/router.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() {
  return Navigator(
    key: navigationController.navigationKey,
    // initialRoute: loginRoute,
    onGenerateRoute: generateRoute,
  );
}
