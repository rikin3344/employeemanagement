import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/modules/home/model/check_box_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_services_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/family_details_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/role_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final count = '0'.obs;
  RxString roleName = ''.obs;
  RxString name = ''.obs;
  late Future<EmployeesModel> employeeModel;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void onInit() async {
    prefData();
    employeeModel = getEmployee();
    super.onInit();
  }

  prefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await getRoles();
    name.value =
        '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    roleName.value = pref.getString('roleName')!;
    await getCompanies();
    await getFamilyMemberDetails();
    await getEmployeeService();
  }

  getRoles() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    String roleId = pref.getString('roleId')!;
    print(accessToken);
    print(deviceToken + 'Rikin');
    print(roleId + 'Rikin');
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
      try {
        RoleModel model = roleModelFromJson(response.body);

        roleData = model.data;
        print(roleId + 'Roleid');
        print(model.data.length);

        for (var i = 0; i < model.data.length; i++) {
          if (model.data[i].value == roleId) {
            pref.setString('roleName', model.data[i].name);
          }
        }
      } catch (e) {
        logoutFunction();
      }
    } else {
        logoutFunction();
      // throw Exception('Failed');
    }
  }

  getCompanies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
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
        // print(model.message);
        companyData = model.datumCompany;
      } catch (e) {
        logoutFunction();
        // Get.toNamed(Routes.LOGIN);
      }
    } else {
        logoutFunction();
      // Get.toNamed(Routes.LOGIN);
      // throw Exception('Failed');
    }
  }

  getFamilyMemberDetails() async {
    String deviceToken = await messaging.getToken() ?? '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}display-family-members");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      try {
        FamilyMemberModel model = familyMemberModelFromJson(response.body);
        // print(model.message);
        familyData = model.data;
        for (var i = 0; i < familyData.length; i++) {
          checkBoxValue.add(CheckBoxModel(id: familyData[i].id, value: false));
        }
      } catch (e) {
        logoutFunction();
      }
    } else {
        logoutFunction();
      // throw Exception('Failed');
    }
  }

  getEmployeeService() async {
    String deviceToken = await messaging.getToken() ?? '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}display-services");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      try {
        EmployeeServicesModel model =
            employeeServicesModelFromJson(response.body);
        // print(model.message);
        employeeServiceData = model.data;
        for (var i = 0; i < employeeServiceData.length; i++) {
          // print(i);
          employeeServiceValue
              .add(CheckBoxModel(id: employeeServiceData[i].id, value: false));
        }
      } catch (e) {
        logoutFunction();
      }
    } else {
        logoutFunction();
      // throw Exception('Failed');
    }
  }
}
