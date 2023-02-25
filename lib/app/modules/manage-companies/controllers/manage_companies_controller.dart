import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ManageCompaniesController extends GetxController {
  final count = 0.obs;
  late Future<CompanyModel> modal;
  PopUp popUp = PopUp();
  @override
  void onInit() {
    modal = getCompanies();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  deleteCompany(context, name, contactPerson, email, contextNumber, id) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      'name': name,
      'contact_person': contactPerson,
      'email': email,
      'contact_number': contextNumber,
      'id': id,
      'status': '0'
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-company");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);

    if (response.statusCode == 200) {
      // Get.snackbar("Success", '$name Removed successfully!!');
      loading.stopDialog(context);
      popUp.start(context, 'Success', '$name Removed successfully!!', 100.0,
          green, () {});
      modal = getCompanies();
      rebuildAllChildren(context);
      // loading.dispose();
      // loading.stopDialog(context);
      return 1;
    } else {
      loading.stopDialog(context);
      popUp.start(
          context, 'Failed', 'response.statusCode', 100.0, colorPrimary, () {});
      // Get.snackbar("Failed", '${response.statusCode} Something goes wrong!!');
      return 0;
    }
    // loading.stopDialog(context);
  }

  void rebuildAllChildren(BuildContext context) {
    try {
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }

      (context as Element).visitChildren(rebuild);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<CompanyModel> getCompanies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    String roleId = pref.getString('roleId')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
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
      try {
        CompanyModel model = companyModelFromJson(response.body);
        companyData = model.datumCompany as List<DatumCompany>;
        return model;
      } catch (e) {
        print(e.toString());
        Get.toNamed(Routes.LOGIN);
        throw Exception('Failed');
      }
    } else {
      Get.toNamed(Routes.LOGIN);
      throw Exception('Failed');
      // throw Exception('Failed');
    }
  }
}
