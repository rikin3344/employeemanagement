import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/modules/home/model/company_model.dart';
import 'package:addrec_employee_management/app/routes/app_pages.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/manage_companies_controller.dart';

class ManageCompaniesView extends GetView<ManageCompaniesController> {
  const ManageCompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context123) {
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
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Manage Companies',
                size: 18,
                fontfamily: 'bold',
              ),
              IconButton(
                  onPressed: () {
                    controller.modal = controller.getCompanies();
                    rebuildAllChildren(context123);
                  },
                  icon: const Icon(Icons.refresh_rounded))
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 0),
              () {
                // print("object");
              },
            );
          },
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Obx(
                () {
                  print(controller.count.value);
                  return FutureBuilder(
                    future: controller.modal,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        CompanyModel model = snapshot.data as CompanyModel;
                        print(model
                            .datumCompany[(model.datumCompany.length - 1)].logo
                            .toString());
                        return Column(
                          children: [
                            if (model.datumCompany.isEmpty)
                              const CustomText(text: "No data found!!")
                            else
                              for (int i = 0;
                                  i < model.datumCompany.length;
                                  i++)
                                Slidable(
                                  closeOnScroll: true,

                                  // Specify a key if the Slidable is dismissible.
                                  key: ValueKey(i),

                                  // The end action pane is the one at the right or the bottom side.
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dragDismissible: true,
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          var value = controller.deleteCompany(
                                              context123,
                                              model.datumCompany[i].name,
                                              model.datumCompany[i]
                                                  .contactPerson,
                                              model.datumCompany[i].email,
                                              model.datumCompany[i]
                                                  .contactNumber,
                                              model.datumCompany[i].id);

                                          if (value == 1) {
                                            print(this);
                                            Future.delayed(
                                              const Duration(seconds: 1),
                                              () {
                                                controller.modal =
                                                    controller.getCompanies();
                                                controller.rebuildAllChildren(
                                                    context123);
                                                // print("object");
                                              },
                                            );
                                          }
                                        },
                                        backgroundColor: colorPrimary,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_forever_rounded,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          Get.toNamed(Routes.ADD_COMPANY,
                                              arguments:
                                                  model.datumCompany[i].id);
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
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  model.datumCompany[i].logo,
                                              height: 55.0,
                                              width: 55.0,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator
                                                      .adaptive(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                iconMale[0],
                                                height: 55.0,
                                                width: 55.0,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: model.datumCompany[i].name,
                                              color: colorPrimary,
                                              fontfamily: 'semiBold',
                                            ),
                                            CustomText(
                                              text: model.datumCompany[i].code,
                                              color: colorSecondary,
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
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
