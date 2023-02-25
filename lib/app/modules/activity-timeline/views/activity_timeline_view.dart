import 'dart:convert';

import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/activity-timeline/model/fetch_activity_model.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/activity_timeline_controller.dart';

class ActivityTimelineView extends GetView<ActivityTimelineController> {
  ActivityTimelineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme:  IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Activity Timeline",
                size: 18,
                fontfamily: 'bold',
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                    onPressed: () {
                      AlertDialog alertDialog = AlertDialog(
                        elevation: 0,
                        content: Container(
                          constraints: BoxConstraints(
                            minWidth: 300,
                          ),
                          // color: colorPrimary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntrinsicWidth(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children:  [
                                    CustomText(
                                      text: 'Add Comment',
                                      color: colorPrimary,
                                      fontfamily: 'semiBold',
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 15.0, bottom: 20),
                                // height: 300.0,
                                child: TextFormField(
                                  onChanged: (value) {
                                    controller.comment.value = value;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: colorSecondary,
                                  maxLines: null,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      labelText: 'Comment',
                                      hintText: 'hintText',
                                      counterText: '',
                                      labelStyle:  TextStyle(color: gray),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                              color: colorSecondary)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                              color: colorSecondary)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                              color: colorPrimary)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                              color: grayExtraLight)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: controller
                                                      .errorText.value ==
                                                  ''
                                              ?  BorderSide(color: grayLight)
                                              :  BorderSide(color: colorPrimary))),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: CustomText(
                                        text: 'cancel',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                controller.comment.value == ''
                                                    ? gray
                                                    : colorSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          onPressed: () {
                                            if (controller.comment.value ==
                                                '') {
                                              return;
                                            } else {
                                              controller.submitComment(context);
                                            }
                                            // controller.matchOtp(context);
                                            // Get.offAllNamed(homeRoute);
                                          },
                                          child:  CustomText(
                                            text: 'Submit',
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      showDialog(
                        context: context,
                        builder: (context) => alertDialog,
                      );
                    },
                    icon:  Icon(
                      Icons.add_rounded,
                      size: 28,
                      color: black,
                    )),
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 0),
            () {
              // print("object");
              controller.future = controller.fetchData();
              rebuildAllChildren(context);
            },
          );
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              height: height,
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Obx(
                () {
                  print(controller.count.value);
                  return FutureBuilder(
                    future: controller.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        FetchActivityDataModel model =
                            snapshot.data as FetchActivityDataModel;
                        List keys = [];
                        for (var i = 0; i < model.data.length; i++) {
                          keys.add(model.data.keys.first);
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < keys.length; i++)
                              Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Date : ${keys[i]}",
                                      fontfamily: 'semiBold',
                                      color: colorPrimary,
                                    ),
                                    for (int j = 0;
                                        j < model.data[keys[i]]!.length;
                                        j++)
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 15.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text: model
                                                          .data[keys[i]]![j]
                                                          .time,
                                                      size: 15,
                                                      fontfamily: 'semiBold',
                                                      color: colorSecondary,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 1.0),
                                                      width: 3,
                                                      // height: 50,
                                                      decoration:  BoxDecoration(
                                                          color: grayLight,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                    ),
                                                    SizedBox(
                                                      width: width - 150,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                '${model.data[keys[i]]![j].firstName} ${model.data[keys[i]]![j].lastName}',
                                                            size: 14,
                                                            fontfamily:
                                                                'semiBold',
                                                          ),
                                                          CustomText(
                                                            text: model
                                                                .data[keys[i]]![
                                                                    j]
                                                                .comment,
                                                            size: 14,
                                                            fontfamily:
                                                                'medium',
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                          ],
                        );
                      } else {
                        print(snapshot.error);
                        print(snapshot.connectionState);
                        print(snapshot.stackTrace);
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
