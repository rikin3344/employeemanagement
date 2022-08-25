import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/routes/router.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: homeRoute,
      onGenerateRoute: generateRoute,
    );
