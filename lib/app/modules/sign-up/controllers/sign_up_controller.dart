import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  final count = 0.obs;
  RxString email = ''.obs;
  RxString companyCode = ''.obs;
  @override
  void onInit() {
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

  signUpRequest(context) async {
    Loading loading = Loading();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    loading.start(context);

    print("$deviceToken DT");
    print("${email.value} DT");
    print("${companyCode.value} DT");

    Map data = {
      'email': email.value,
      'code': companyCode.value,
      'device_token': deviceToken,
      'device_type': 'android',
    };
    var url = Uri.parse("${APiConst.baseUrl}signup");

    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data);

    if (response.statusCode == 200) {
      loading.stopDialog(context);
      Get.offAllNamed(Routes.LOGIN);
    } else {
      print(response.statusCode);
      print(response.body);
      loading.stopDialog(context);
    }
  }
}
