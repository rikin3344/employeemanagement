import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/add-user/models/all_user_models.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/manage_user_controller.dart';

class ManageUserView extends GetView<ManageUserController> {
  ManageUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: 'Manage Companies',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 0),
              () {
                // print("object");
                // controller.modal = controller.getCompanies();
                rebuildAllChildren(context);
              },
            );
          },
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: controller.modal,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AllUserModel model = snapshot.data as AllUserModel;
                    return Column(
                      children: [
                        for (int i = 0; i < model.data.length; i++)
                          Slidable(
                            closeOnScroll: true,

                            // Specify a key if the Slidable is dismissible.
                            key: ValueKey(i),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              dragDismissible: true,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: colorPrimary,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_forever_rounded,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.toNamed(Routes.ADD_USER,
                                        arguments: model.data[i].id);
                                  },
                                  backgroundColor: colorSecondary,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit_note_rounded,
                                  label: 'Edit',
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "${model.data[i].firstName} ${model.data[i].lastName}",
                                    color: colorPrimary,
                                    fontfamily: 'semiBold',
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: model.data[i].company.name,
                                        color: colorSecondary,
                                        size: 16,
                                        fontfamily: 'semiBold',
                                      ),
                                      CustomText(
                                        text: '  (${model.data[i].role.name})',
                                        color: colorSecondary,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
