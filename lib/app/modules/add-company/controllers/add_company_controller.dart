import 'dart:io';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-company/models/add_company_model.dart';
import 'package:addrec_employee_management/app/modules/add-company/models/update-company-model.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddCompanyController extends GetxController {
  final count = 0.obs;
  RxString companyName = ''.obs;
  RxString contactPersonName = ''.obs;
  RxString email = ''.obs;
  RxString contact = ''.obs;
  RxString address1 = ''.obs;
  RxString address2 = ''.obs;
  RxString city = ''.obs;
  RxString state = ''.obs;
  RxString pincode = ''.obs;

  PopUp popUp = PopUp();

  RxString contactError = ''.obs;
  RxString companyNameError = ''.obs;
  RxString contactPersonError = ''.obs;
  RxString emailError = ''.obs;
  RxString address1Error = ''.obs;
  RxString address2Error = ''.obs;
  RxString cityError = ''.obs;
  RxString stateError = ''.obs;
  RxString pincodeError = ''.obs;
  RxString imageError = ''.obs;
  String id = '';
  DatumCompany companyDetails = DatumCompany(
      id: '',
      name: '',
      code: '',
      contactPerson: '',
      email: '',
      contactNumber: '',
      logo: '',
      addedBy: '',
      address1: '',
      address2: '',
      city: '',
      pincode: '',
      state: '',
      status: '');
  @override
  void onInit() {
    if (Get.arguments != null) {
      id = Get.arguments;
      getCompanyDetails();
      companyName.value = companyDetails.name;
      contactPersonName.value = companyDetails.contactPerson;
      email.value = companyDetails.email;
      contact.value = companyDetails.contactNumber;
    }
    print(companyDetails.id);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    imageData = null;
    super.onClose();
  }

  void increment() => count.value++;

  Loading loading = Loading();

  getCompanies(context) async {
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse("${APiConst.baseUrl}add-edit-company");

    if (imageData == null) {
      Map data = {
        'user_id': userId,
        'device_token': deviceToken,
        'name': companyName.value,
        'contact_person': contactPersonName.value,
        'email': email.value,
        'contact_number': contact.value,
        'address_1': address1.value,
        'address_2': address2.value,
        'city': city.value,
        'state': state.value,
        'pincode': pincode.value,
      };
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": '${APiConst.prefix}$accessToken'
          },
          body: data);
      if (response.statusCode == 200) {
        AddCompanyModel model = addCompanyModelFromJson(response.body);
        if (model.success || model.errorcode == '1') {
          loading.stopDialog(context);
          popUp.start(context, "Added!", 'New Company added Successfully!',
              100.0, green, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                // navigationController.navigateTO(homeRoute, []);

                Get.offNamed(Routes.MANAGE_COMPANIES);
                // Navigator.pop(context);
              },
            );
          });
          // Get.snackbar("Added!", 'New Company added Successfully!');

          // popUp.start(context, "Added!", 'New Company added Successfully!',
          //     100.0, green, () {});
        } else {
          loading.stopDialog(context);
          popUp.start(
              context, "Error!", model.message, 100.0, colorPrimary, () {});
          // Get.snackbar("Error!", model.message);
        }

        // popUp.start(context, "", model.message, 100.0, green);
      } else {
        loading.stopDialog(context);
        popUp.start(context, response.statusCode.toString(),
            'Something went wrong!', 100.0, green, () {});
        // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
        print(response.statusCode);
        // throw Exception('Failed');
      }
    } else {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": '${APiConst.prefix}$accessToken'
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = userId;
      request.fields['device_token'] = deviceToken;
      request.fields['name'] = companyName.value;
      request.fields['contact_person'] = contactPersonName.value;
      request.fields['email'] = email.value;
      request.fields['contact_number'] = contact.value;
      request.fields['address_1'] = address1.value;
      request.fields['address_2'] = address2.value;
      request.fields['city'] = city.value;
      request.fields['state'] = state.value;
      request.fields['pincode'] = pincode.value;
      request.files.add(await http.MultipartFile.fromPath('logo', imageData!.path));

      var responseReq = await request.send();

      var responseData = await responseReq.stream.toBytes();
      var response = String.fromCharCodes(responseData);

      if (responseReq.statusCode == 200) {
        print(response);
        AddCompanyModel model = addCompanyModelFromJson(response);
        if (model.success || model.errorcode == '1') {
          imageData = null;
          Future.delayed(
            const Duration(seconds: 1),
            () {
              // navigationController.navigateTO(homeRoute, []);

              Get.offNamed(Routes.MANAGE_COMPANIES);
              // Navigator.pop(context);
            },
          );
          loading.stopDialog(context);
        } else {
          loading.stopDialog(context);
        }
        popUp.start(context, '', model.message, 100.0, colorPrimary, () {});
      } else {
        loading.stopDialog(context);
        popUp.start(context, responseReq.statusCode.toString(),
            'Something went wrong!', 100.0, colorPrimary, () {});
        // Get.snackbar(
        //     responseReq.statusCode.toString(), 'Something went wrong!');
        print(responseReq.statusCode);
        // throw Exception('Failed');
      }
    }
  }

  updateCompanies(context) async {
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse("${APiConst.baseUrl}add-edit-company");

    if (imageData == null) {
      Map data = {
        'user_id': userId,
        'device_token': deviceToken,
        'name': companyName.value,
        'contact_person': contactPersonName.value,
        'email': email.value,
        'contact_number': contact.value,
        'id': id
      };
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": '${APiConst.prefix}$accessToken'
          },
          body: data);
      if (response.statusCode == 200) {
        UpdateCompanyModel model = updateCompanyModelFromJson(response.body);
        // print(response.body);
        if (model.success || model.errorcode == '1') {
                loading.stopDialog(context);
          popUp.start(context, "Updated!",
              'Company details updated Successfully!', 100.0, green, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                // navigationController.navigateTO(homeRoute, []);

                // Get.back();
                Navigator.pop(context);
              },
            );
          });
          // Get.snackbar("Updated!", 'Company details updated Successfully!');

        } else {
          loading.stopDialog(context);
          popUp.start(context, "Error!", model.message, 100.0, green, () {});
          // Get.snackbar("Error!", model.message);
        }
      } else {
        loading.stopDialog(context);
        popUp.start(context, response.statusCode.toString(),
            'Something went wrong!', 100.0, green, () {});
        // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
        print(response.statusCode);
        // throw Exception('Failed');
      }
    } else {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": '${APiConst.prefix}$accessToken'
      };

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = userId;
      request.fields['device_token'] = deviceToken;
      request.fields['name'] = companyName.value;
      request.fields['contact_person'] = contactPersonName.value;
      request.fields['email'] = email.value;
      request.fields['contact_number'] = contact.value;
      request.fields['id'] = id;
      request.files.add(await http.MultipartFile.fromPath('logo', imageData!.path));

      var responseReq = await request.send();

      var responseData = await responseReq.stream.toBytes();
      var response = String.fromCharCodes(responseData);

      if (responseReq.statusCode == 200) {
        UpdateCompanyModel model = updateCompanyModelFromJson(response);
        // print(response.body);
        imageData = null;
        if (model.success || model.errorcode == '1') {
          loading.stopDialog(context);
          popUp.start(context, "Updated!",
              'Company details updated Successfully!', 100.0, green, () {
            Future.delayed(
              const Duration(seconds: 0),
              () {
                // navigationController.navigateTO(homeRoute, []);

                // Get.back();
                Navigator.pop(context);
              },
            );
          });
          // Get.snackbar("Updated!", 'Company details updated Successfully!');

        } else {
          // Get.snackbar("Error!", model.message);
          loading.stopDialog(context);
          popUp.start(context, "Error!", model.message, 100.0, green, () {});
        }
      } else {
        // Get.snackbar(
        //     responseReq.statusCode.toString(), 'Something went wrong!');
        print(responseReq.statusCode);
        loading.stopDialog(context);
        popUp.start(context, responseReq.statusCode.toString(),
            'Something went wrong!', 100.0, green, () {});
        // throw Exception('Failed');
      }
    }
  }

  void onClickAdd(context) {
    if (companyName.value == '') {
      companyNameError.value = "Not be blank !!";
    } else {
      companyNameError.value = "";
    }
    if (contactPersonName.value == '') {
      contactPersonError.value = "Not be blank !!";
    } else {
      contactPersonError.value = "";
    }
    if (email.value == '') {
      emailError.value = "Not be blank !!";
    } else {
      if (!email.value.contains('@') ||
          (!email.value.contains('.com') && !email.value.contains('.in'))) {
        emailError.value = "Invalid email";
      } else {
        emailError.value = "";
      }
    }

    if (contact.value == '') {
      contactError.value = "Not be blank !!";
    } else {
      if (contact.value.length != 10) {
        contactError.value = "Invalid contact number !";
      } else {
        contactError.value = "";
      }
    }

    if (contactError.value != '' ||
        companyNameError.value != '' ||
        contactPersonError.value != '' ||
        emailError.value != '') {
      // setState(() {
      //   contactError = "Required!!";
      // });
      // Get.snackbar(
      //     "Field Required!", 'All fields are required!!');
    } else {
      // setState(() {
      //   contactError = "";
      // });
      if (id == '') {
        getCompanies(context);
      } else {
        updateCompanies(context);
      }
    }
  }

  getCompanyDetails() {
    for (var i = 0; i < companyData.length; i++) {
      if (companyData[i].id == id) {
        companyDetails = companyData[i];
      }
    }
  }
}
