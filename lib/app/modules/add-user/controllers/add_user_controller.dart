import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-user/models/add_user_model.dart';
import 'package:addrec_employee_management/app/modules/add-user/models/all_user_models.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddUserController extends GetxController {
  final count = 0.obs;
  PopUp popUp = PopUp();
  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString emailError = ''.obs;
  RxString mobileError = ''.obs;
  RxString companyError = ''.obs;
  RxString roleError = ''.obs;
  RxString imageError = ''.obs;

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString contact = ''.obs;
  RxString companyId = ''.obs;
  RxString roleId = ''.obs;
  var companyList = [].obs;
  RxString roleSelect = 'Role'.obs;
  RxString companySelect = 'Company'.obs;
  var role = ['Role'].obs;
  List<DatumCompany> companyDataController = [];

  Datum userData = Datum(
      id: "",
      companiesId: "",
      firstName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      profilePic: '',
      roleId: '',
      addedBy: '',
      status: '',
      otpCode: '',
      otpExpiredAt: '',
      role: Company(id: '', name: ''),
      company: Company(id: '', name: ''));

  var arguments = Get.arguments;
  @override
  void onInit() async {
    for (var i = 0; i < companyData.length; i++) {
      print(i);
      companyList.add('${companyData[i].name} (${companyData[i].code})');
    }
    if (Get.arguments != null) {
      getPrefAndUserData(arguments);
      firstName.value = userData.firstName;
      lastName.value = userData.lastName;
      email.value = userData.email;
      contact.value = userData.phoneNumber;
      update();
    }
    await asyncMethods();
    await getCompanies();

    // print
    super.onInit();
  }

  asyncMethods() {
    for (var i = 0; i < roleData.length; i++) {
      if (roleData[i].id == '25') {
      } else {
        print('added');
        role.add(roleData[i].name);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    imageData = null;
    addedCompanyList.clear();
    super.onClose();
  }

  void increment() => count.value++;

  Loading loading = Loading();

  getPrefAndUserData(arguments) async {
    if (arguments == 'edit') {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userId = pref.getString('userId')!;
      String deviceToken = pref.getString('deviceToken')!;
      String accessToken = pref.getString('accessToken')!;
      if (userId != '') {
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
          if (model.success) {
            for (var i = 0; i < model.data.length; i++) {
              if (userId == model.data[i].id) {
                print(i.toString() + 'found');
                firstName.value = model.data[i].firstName;
                lastName.value = model.data[i].lastName;
                email.value = model.data[i].email;
                contact.value = model.data[i].phoneNumber;
              } else {
                // print(i.toString() + userId);
              }
            }
          }
        } else {
          print(response.statusCode);
        }
      }
    }

    if (arguments != 'edit') {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userId = pref.getString('userId')!;
      String deviceToken = pref.getString('deviceToken')!;
      String accessToken = pref.getString('accessToken')!;
      if (userId != '') {
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
          if (model.success) {
            for (var i = 0; i < model.data.length; i++) {
              if (arguments == model.data[i].id) {
                userData = model.data[i];
                update();
              } else {
                // print(i.toString() + userId);
              }
            }
          }
        } else {
          print(response.statusCode);
        }
      }
    }
  }

  addUser(context) async {
    loading.start(context);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String deviceToken = await messaging.getToken() ?? '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse("${APiConst.baseUrl}add-edit-user");
    print(deviceToken);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": '${APiConst.prefix}$accessToken'
    };
    print(addedCompanyList.length);
    for (var i = 0; i < companyData.length; i++) {
      if ('${companyData[i].name} (${companyData[i].code})' ==
          addedCompanyList[0]) {
        companyId.value = companyData[i].id;
      }
    }

    for (var i = 0; i < roleData.length; i++) {
      if (roleData[i].name == roleSelect.value) {
        roleId.value = roleData[i].value;
      }
    }
    // loading.stopDialog(context);

    if (imageData == null) {
      Map data = {
        'user_id': userId,
        'device_token': deviceToken.toString(),
        'first_name': firstName.value,
        'last_name': lastName.value,
        'email': email.value,
        'phone_number': contact.value,
        'companies_id': companyId.value,
        'role_id': roleId.value,
      };
      // print(userId);
      // print(deviceToken);
      // print(firstName);
      // print(lastName);
      // print(email);
      // print(contact);
      // print(companyId);
      // print(roleId);
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": '${APiConst.prefix}$accessToken'
          },
          body: data);
      if (response.statusCode == 200) {
        // print(response.body);
        AddUserModel model = addUserModelFromJson(response.body);
        if (model.success || model.errorcode == '1') {
          // Get.snackbar("Added!", 'New User added Successfully!');

                loading.stopDialog(context);
          popUp.start(context, "Added!", 'New User added Successfully!', 100.0,
              colorPrimary, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                Get.offAllNamed(Routes.HOME);
              },
            );
          });
        } else {
          loading.stopDialog(context);
          // Get.snackbar("Error!", model.message);
          popUp.start(
              context, "Error!", model.message, 100.0, colorPrimary, () {});
        }
      } else {
        loading.stopDialog(context);
        popUp.start(context, response.statusCode.toString(),
            'Something went wrong!', 100.0, colorPrimary, () {});
        // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
        // print(response.statusCode);
        // print(response.body);
        // throw Exception('Failed');
      }
    } else {
      print('image');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = userId;
      request.fields['device_token'] = deviceToken;
      request.fields['first_name'] = firstName.value;
      request.fields['last_name'] = lastName.value;
      request.fields['email'] = email.value;
      request.fields['phone_number'] = contact.value;
      request.fields['companies_id'] = companyId.value;
      request.fields['role_id'] = roleId.value;
      request.files
          .add(await http.MultipartFile.fromPath('logo', imageData!.path));

      var responseReq = await request.send();

      var responseData = await responseReq.stream.toBytes();
      var response = String.fromCharCodes(responseData);

      if (responseReq.statusCode == 200) {
        print(response);
        AddUserModel model = addUserModelFromJson(response);
        if (model.success || model.errorcode == '1') {
          imageData = null;
                loading.stopDialog(context);
          // Get.snackbar("Added!", 'New User added Successfully!');
          popUp.start(context, 'Added!', 'New User added Successfully!', 100.0,
              colorPrimary, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                Get.offAllNamed(Routes.HOME);
              },
            );
          });
        } else {
          loading.stopDialog(context);
          popUp.start(
              context, 'Error!', model.message, 100.0, colorPrimary, () {});
          // Get.snackbar("Error!", model.message);
        }
      } else {
        // Get.snackbar(
        //     responseReq.statusCode.toString(), 'Something went wrong!');
        // print(responseReq.statusCode);
        // print(response);
        loading.stopDialog(context);
        popUp.start(context, responseReq.statusCode.toString(),
            'Something went wrong!', 100.0, colorPrimary, () {});
        // throw Exception('Failed');
      }
    }
  }

  void checkError(context) {
    if (firstName.value == '') {
      firstNameError.value = 'Invalid name!';
    } else {
      firstNameError.value = '';
    }

    if (lastName.value == '') {
      lastNameError.value = 'Invalid Name!';
    } else {
      lastNameError.value = '';
    }

    if (email.value == '') {
      emailError.value = "Invalid Email !!";
    } else {
      if (!email.value.contains('@') ||
          (!email.value.contains('.com') && !email.value.contains('.in'))) {
        emailError.value = "Invalid email";
      } else {
        emailError.value = "";
      }
    }

    if (contact.value == '') {
      mobileError.value = "Invalid contact number !!";
    } else {
      if (contact.value.length != 10) {
        mobileError.value = "Invalid contact number !";
      } else {
        mobileError.value = "";
      }
    }
    print(addedCompanyList);
    if (addedCompanyList.isEmpty) {
      companyError.value = 'Select company !';
    } else {
      companyError.value = '';
    }

    if (roleSelect.value == 'Role') {
      roleError.value = 'Select User role !';
    } else {
      roleError.value = '';
    }

    if (firstNameError.value != '' ||
        lastNameError.value != '' ||
        emailError.value != '' ||
        mobileError.value != '' ||
        companyError.value != '' ||
        roleError.value != '') {
      // Get.snackbar('Field Required!!',
      //     'All fields are required!!');
    } else {
      addUser(context);
    }
  }

  getCompanies() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String deviceToken = await messaging.getToken() ?? '';
    // String name =
    //     '${pref.getString('firstName')!} ${pref.getString('lastName')!}';
    String userId = pref.getString('userId')!;
    // String deviceToken = pref.getString('deviceToken')!;
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
        // print(model.message);
        companyData = model.datumCompany as List<DatumCompany>;
        companyDataController = model.datumCompany as List<DatumCompany>;

        print(companyData.length);
      } catch (e) {
        print(e.toString());
        Get.toNamed(Routes.LOGIN);
      }
    } else {
      Get.toNamed(Routes.LOGIN);
      // throw Exception('Failed');
    }
  }
}
