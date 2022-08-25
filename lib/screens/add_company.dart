import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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

class PersonalDetailsWidget extends StatelessWidget {
  const PersonalDetailsWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

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
              SizedBox(
                height: 20.0,
              ),
              CustomEditText(
                label: "Company Name",
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
              ),
              CustomEditText(
                label: "Contact Person Name",
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
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
              // CustomEditText(
              //   label: "Designation",
              //   width: width * 0.9,
              //   onChange: (value) {
              //     print(value);
              //   },
              // ),
              Container(
                width: width * 0.9,
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
    );
  }
}
