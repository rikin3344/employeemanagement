import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String companySelect = 'Company';
  String roleSelect = 'Role';
  var companyList = ['Company', 'xyz pvt ltd', 'TATA', 'Reliance'];
  var role = ['Role', 'Manager', 'Employer', 'Contributor'];
  List addedCompanyList = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: black,
        iconTheme: const IconThemeData(color: black),
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: const CustomText(
            text: 'Add User Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Fill up below form to add new user!",
                    size: 18,
                    fontfamily: "bold",
                    color: colorPrimary,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomEditText(
                        label: "First Name",
                        width: width * 0.4,
                        onChange: (value) {
                          print(value);
                        },
                      ),
                      CustomEditText(
                        label: "last Name",
                        width: width * 0.4,
                        onChange: (value) {
                          print(value);
                        },
                      ),
                    ],
                  ),
                  CustomEditText(
                    label: "Email Address",
                    textInputType: TextInputType.emailAddress,
                    width: width * 0.9,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                  CustomEditText(
                    label: "Contact Number",
                    textInputType: TextInputType.number,
                    width: width * 0.9,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: width * 0.65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: grayLight)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            hint: const CustomText(
                              text: "Company",
                            ),
                            value: companySelect,
                            onChanged: (newValue) async {
                              setState(() {
                                companySelect = newValue!;
                              });
                            },
                            items: companyList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: CustomText(
                                  text: items,
                                  color: items == "Company" ? gray : black,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (addedCompanyList.contains(companySelect)) {
                                  Get.snackbar(companySelect, "Already added!");
                                } else {
                                  if (companySelect == "Company") {
                                  } else {
                                    addedCompanyList.add(companySelect);
                                  }
                                }
                              });
                            },
                            child: const CustomText(
                              text: "Add",
                              fontfamily: 'bold',
                              color: colorSecondary,
                              size: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 05,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (!addedCompanyList.contains(companySelect)) {
                                  Get.snackbar(companySelect, "Not Added!");
                                } else {
                                  addedCompanyList.removeWhere(
                                      (element) => element == companySelect);
                                }
                              });
                            },
                            child: const CustomText(
                              text: "Remove",
                              fontfamily: 'bold',
                              color: colorPrimary,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (addedCompanyList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Selected Company",
                            fontfamily: 'medium',
                            color: colorPrimary,
                            size: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < addedCompanyList.length;
                                    i++)
                                  if (i == 0)
                                    CustomText(
                                      text: addedCompanyList[i],
                                      fontfamily: 'medium',
                                      color: black,
                                      size: 14,
                                    )
                                  else
                                    CustomText(
                                      text: ", ${addedCompanyList[i]}",
                                      fontfamily: 'medium',
                                      color: black,
                                      size: 14,
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    height: 50.0,
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: grayLight)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        isExpanded: true,
                        hint: const CustomText(
                          text: "Role",
                        ),
                        value: roleSelect,
                        onChanged: (newValue) async {
                          setState(() {
                            roleSelect = newValue!;
                          });
                        },
                        items: role.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: CustomText(
                              text: items,
                              color: items == "Role" ? gray : black,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    height: 130,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: grayLight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: gray2,
                            child: const Icon(
                              Iconsax.image,
                              size: 50,
                              color: gray,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const CustomText(
                          text: "Select Profile Picture",
                          size: 16,
                          color: gray,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 71,
                        width: 71,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(71),
                              )),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: () {},
                          child: const Icon(
                            Icons.download_done_rounded,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
