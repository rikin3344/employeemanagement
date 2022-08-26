import 'dart:math';
import 'package:employeemanagement/model/company_model.dart';
import 'package:http/http.dart' as http;
import 'package:employeemanagement/constants/api_client.dart';
import 'package:employeemanagement/constants/const.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/devices/desktop.dart';
import 'package:employeemanagement/devices/mobile.dart';
import 'package:employeemanagement/devices/tablet.dart';
import 'package:employeemanagement/helpers/responsive.dart';
import 'package:employeemanagement/model/role_model.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:employeemanagement/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  late SharedPreferences pref;
  // late RoleModel roleModel;
  String userId = '';
  String deviceToken = '';
  String accessToken = '';
  String name = '';
  String roleId = '';
  String roleName = '';
  getSharedPrefData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
      userId = pref.getString('userId')!;
      deviceToken = pref.getString('deviceToken')!;
      accessToken = pref.getString('accessToken')!;
      roleId = pref.getString('roleId')!;
      if (userId != '' || deviceToken != '') {
        getRoles(userId, deviceToken, accessToken, roleId);
        getCompanies(userId, deviceToken, accessToken, roleId);

        // print(roleModel.)
      }
    });
  }

  getRoles(userId, deviceToken, accessToken, roleId) async {
    print(accessToken);
    print(deviceToken);
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}display-roles");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      RoleModel model = roleModelFromJson(response.body);
      for (var i = 0; i < model.data.length; i++) {
        if (model.data[i].id == roleId) {
          setState(() {
            roleName = model.data[i].name;
          });
        }
      }
    } else {
      print(response.statusCode);
      // throw Exception('Failed');
    }
  }

  getCompanies(userId, deviceToken, accessToken, roleId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}display-company");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      CompanyModel model = companyModelFromJson(response.body);
      // print(model.message);
      setState(() {
        companyData = model.data;
        print(companyData[0].email);
      });
    } else {
      print(response.statusCode);
      // throw Exception('Failed');
    }
  }

  @override
  void initState() {
    getSharedPrefData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(deviceToken);
    // print(userId);
    // print(accessToken);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: colorBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: name,
                      size: 16,
                      fontfamily: "bold",
                    ),
                    CustomText(
                      text: roleName,
                      size: 12,
                      fontfamily: "medium",
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorBackground,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: black.withOpacity(0.25))
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    iconMale[Random().nextInt(iconMale.length)],
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      drawer: DrawerCustom(),
      body: const SafeArea(
        child: ResponsiveWidget(
            largeScreen: DesktopScreen(),
            mediumScreen: TabletScreen(),
            smallScreen: MobileScreen()),
      ),
    );
  }
}
