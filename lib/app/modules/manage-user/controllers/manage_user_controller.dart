import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/modules/add-user/models/all_user_models.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ManageUserController extends GetxController {
  //TODO: Implement ManageUserController

  final count = 0.obs;
  late Future<AllUserModel> modal;
  @override
  void onInit() {
    modal = getPrefAndUserData();
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

  Future<AllUserModel> getPrefAndUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map data = {'user_id': userId, 'device_token': deviceToken};

    var url = Uri.parse("${APiConst.baseUrl}display-users");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      AllUserModel model = allUserModelFromJson(response.body);

      return model;
    } else {
      print(response.statusCode);
      throw Exception('Failed');
    }
  }
}
