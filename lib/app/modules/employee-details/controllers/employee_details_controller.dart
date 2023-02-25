import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/dynamic-employee-form/model/get_transportation_modal.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/field_value_modal.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/new_employee_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/null_employe_details_model.dart';
import 'package:addrec_employee_management/app/modules/employee-details/models/radio_status_modal.dart';
import 'package:addrec_employee_management/app/modules/home/model/check_box_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/employee_services_model.dart';
import 'package:addrec_employee_management/app/modules/home/model/family_details_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EmployeeDetailsController extends GetxController {
  PopUp popUp = PopUp();
  final count = 0.obs;
  String id = Get.arguments['id'];
  String profile = Get.arguments['profile'];
  RxString checkBoxStatus = 'Not Completed'.obs;

  RxList<RadioStatusModal> radioStatus = <RadioStatusModal>[].obs;
  RxList<FieldValueModal> fieldValueModal = <FieldValueModal>[].obs;
  List<TransportationData> transportationData = [];
  // RxList<CheckBoxModel> changedService = <CheckBoxModel>[].obs;

  // RxList<CheckBoxModel> serviceList = <CheckBoxModel>[].obs;

  late Future<EmployeeDetailsModel> detailsModel;
  late Future<NullEmployeeDetailsModel> nullDetailsModel;

  @override
  void onInit() {
    print('${id}employeeid123');
    getTransportation();
    detailsModel = getEmployeeDetails(id);
    nullDetailsModel = nullGetEmployeeDetails(id);

    // _tabController = TabController(length: 2, vsync: this);

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

  deleteEmployee(email, context) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map params = {
      'user_id': userId,
      'device_token': deviceToken,
      'email': email,
      'employee_data': '[{"field_id":"0", "field_name" : "", "value":""}]',
      "status": '0',
      'id': id
      // 'status' : 's',
      // 'id': contact,
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-employee");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: params);

    if (response.statusCode == 200) {
      print(response.body);
      loading.stopDialog(context);
      popUp.start(context, 'Deleted', "Employee deleted Successfully!!", 100.0,
          green, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                // navigationController.navigateTO(homeRoute, []);

                Get.offNamed(Routes.HOME);
                // Navigator.pop(context);
              },
            );
          });
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }

  updateServiceNew(context, serviceId, value) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    int fail = 0;
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    print(userId);
    print(deviceToken);
    print(id);
    print(serviceId + value);
    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      'id': serviceId,
      'status': value,
      'employee_id': id
    };
    var url = Uri.parse("${APiConst.baseUrl}update-service-status");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      detailsModel = getEmployeeDetails(id);
      loading.stopDialog(context);
      // Get.snackbar('Updated', 'Service Status Updated SuccessFully!!');
      popUp.start(context, 'Updated', 'Service Status updated Successfully!',
          100.0, green, () {});
      rebuildAllChildren(context);
    } else {
      loading.stopDialog(context);
      popUp.start(
          context, 'Failed', 'Internal Error!!!', 100.0, colorPrimary, () {});
      // Get.snackbar('Failed', 'Internal Error!!');
      print(response.statusCode);
      // Get.toNamed(Routes.LOGIN);
      // throw Exception('Failed');
    }
  }

  // void changeValueOfList(i, value) {
  //   serviceList[i].value = value!;
  //   update();
  // }

  getFamilyMemberDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
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
          print(checkBoxModelToJson(checkBoxValue));
        }
      } catch (e) {
        print(e.toString());
        Get.toNamed(Routes.LOGIN);
      }
    } else {
      Get.toNamed(Routes.LOGIN);
      // throw Exception('Failed');
    }
  }

  getEmployeeService() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
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
          print(i);
          employeeServiceValue
              .add(CheckBoxModel(id: employeeServiceData[i].id, value: false));
        }
      } catch (e) {
        print(e.toString());
        Get.toNamed(Routes.LOGIN);
      }
    } else {
      Get.toNamed(Routes.LOGIN);
      // throw Exception('Failed');
    }
  }

  getTransportation() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'user_id': userId, 'device_token': deviceToken};
    var url = Uri.parse("${APiConst.baseUrl}get-transportations");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['success'] ||
          responseData['errorcode'].toString() == "1") {
        TransportationModal modal = transportationModalFromJson(response.body);
        transportationData = modal.data;
      }
    } else {
      print(response.statusCode.toString() + "responseCodeTransportaiion");
      throw Exception('Failed');
    }
  }
}
