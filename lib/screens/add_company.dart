import 'package:employeemanagement/constants/api_client.dart';
import 'package:employeemanagement/constants/controllers.dart';
import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/model/add_company_model.dart';
import 'package:employeemanagement/routes/routes.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:employeemanagement/widgets/loding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
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
            text: 'Add Company Details',
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: SafeArea(
        child: PersonalDetailsWidget(width: width),
      ),
    );
  }
}

class PersonalDetailsWidget extends StatefulWidget {
  const PersonalDetailsWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<PersonalDetailsWidget> createState() => _PersonalDetailsWidgetState();
}

class _PersonalDetailsWidgetState extends State<PersonalDetailsWidget> {
  String companyName = '';
  String contactPersonName = '';
  String email = '';
  String contact = '';
  Loading loading = Loading();

  getCompanies(context) async {
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId')!;
    String deviceToken = pref.getString('deviceToken')!;
    String accessToken = pref.getString('accessToken')!;
    Map data = {
      'user_id': userId,
      'device_token': deviceToken,
      'name': companyName,
      'contact_person': contactPersonName,
      'email': email,
      'contact_number': contact
    };
    var url = Uri.parse("${APiConst.baseUrl}add-edit-company");
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
        Get.snackbar("Added!", 'New Company added Successfully!');
        Future.delayed(
          const Duration(seconds: 3),
          () {
            // navigationController.navigateTO(homeRoute, []);

            Navigator.pop(context);
          },
        );
        loading.stopDialog(context);
      } else {
        Get.snackbar("Error!", model.message);
        loading.stopDialog(context);
      }
    } else {
      print(response.statusCode);
      loading.stopDialog(context);
      // throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomText(
                text: "Fill up below form to add new company!",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomEditText(
                label: "Company Name",
                width: widget.width * 0.9,
                onChange: (value) {
                  setState(() {
                    companyName = value;
                  });
                },
              ),
              CustomEditText(
                label: "Contact Person Name",
                width: widget.width * 0.9,
                onChange: (value) {
                  setState(() {
                    contactPersonName = value;
                  });
                },
              ),
              CustomEditText(
                label: "Email Address",
                textInputType: TextInputType.emailAddress,
                width: widget.width * 0.9,
                onChange: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              CustomEditText(
                label: "Contact Number",
                maxLength: 10,
                textInputType: TextInputType.number,
                width: widget.width * 0.9,
                onChange: (value) {
                  setState(() {
                    contact = value;
                  });
                },
              ),
              // CustomEditText(
              //   label: "Designation",
              //   width: width * 0.9,
              //   onChange: (value) {
              //     print(value);
              //   },
              // ),
              Container(
                width: widget.width * 0.9,
                height: 130,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: grayLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const CustomText(
                      text: "Select Company Logo",
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
                      onPressed: () {
                        if (companyName == '' ||
                            contactPersonName == '' ||
                            email == '' ||
                            contact == '') {
                          Get.snackbar(
                              "Field Required!", 'All fields are required!!');
                        } else {
                          getCompanies(context);
                        }
                      },
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
    );
  }
}
