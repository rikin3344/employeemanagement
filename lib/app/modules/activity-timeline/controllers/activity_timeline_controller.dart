import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/api_client.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/activity-timeline/model/fetch_activity_model.dart';
import 'package:addrec_employee_management/app/modules/activity-timeline/model/submit_success_model.dart';
import 'package:addrec_employee_management/app/widgets/loding.dart';
import 'package:addrec_employee_management/app/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActivityTimelineController extends GetxController {
  final count = 0.obs;
  RxString arguments = ''.obs;
  RxString errorText = ''.obs;
  RxString comment = ''.obs;
  Loading loading = Loading();
  PopUp popUp = PopUp();

  late Future<FetchActivityDataModel> future;

  @override
  void onInit() {
    arguments.value = Get.arguments;
    future = fetchData();
    super.onInit();
  }

  void increment() => count.value++;

  submitComment(context) async {
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse("${APiConst.baseUrl}add-activity");

    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      'employee_id': arguments.value,
      'comment': comment.value,
    };
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      if (data['errorcode'] == 1 || data['success']) {
        SubmitCommentSuccessModel model =
            submitCommentSuccessModelFromJson(response.body);
        // popUp.start(context, 'Saved', model.message, 100.0,
        //     Color.fromARGB(255, 57, 123, 59), () {});
        // Get.snackbar('Saved', model.message);
        future = fetchData();
        update();
        rebuildAllChildren(context);
      } else {
        // popUp.start(
        //     context, 'Failed', data['message'], 100.0, colorPrimary, () {});

        // Get.snackbar('Failed', data['message']);
      }
      loading.stopDialog(context);
      loading.stopDialog(context);
      popUp.start(
          context, '', data['message'], 100.0, colorPrimary, () {});
    } else {
      loading.stopDialog(context);
      popUp.start(context, response.statusCode.toString(),
          'Something went wrong!', 100.0, colorPrimary, () {});
      // Get.snackbar(response.statusCode.toString(), 'Something went wrong!');
      // print(response.statusCode);
      // throw Exception('Failed');
    }
  }

  Future<FetchActivityDataModel> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse("${APiConst.baseUrl}get-activities");

    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      'employee_id': arguments.value,
    };
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": '${APiConst.prefix}$accessToken'
        },
        body: data);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['success'] || responseData['errorcode'] == '1') {
        // print(responseData.toString() + 'eoor');
        // if (responseData['message'] != 'No data found') {
        print('message');
        FetchActivityDataModel model =
            fetchActivityDataModelFromJson(response.body);
        return model;
        // } else {
        //   FetchActivityEmptyDataModel model =
        //       fetchActivityEmptyDataModelFromJson(response.body);
        //   print('messagedscsdc');
        //   // return model;
        // }
      } else {
        throw Exception('Failed');
      }
    } else {
      throw Exception('Failed');
    }
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
}
