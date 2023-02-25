import 'dart:io';

import 'package:addrec_employee_management/app/data/constants/const.dart';
import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/widgets/custom_edit_text.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/add_company_controller.dart';

class AddCompanyView extends GetView<AddCompanyController> {
  const AddCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          child: CustomText(
            text: controller.id == ''
                ? 'Add Company Details'
                : "Update Company Details",
            size: 18,
            fontfamily: 'bold',
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               CustomText(
                text: "Fill up below form to add new company!",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () => CustomEditText(
                  label: "Company Name",
                  width: width * 0.9,
                  value: controller.companyDetails.name,
                  errorText: controller.companyNameError.value,
                  onChange: (value) {
                    controller.companyNameError.value = '';
                    controller.companyName.value = value;
                  },
                  hintText: 'XYZ pvt. ltd.',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Contact Person Name",
                  value: controller.companyDetails.contactPerson,
                  width: width * 0.9,
                  errorText: controller.contactPersonError.value,
                  onChange: (value) {
                    controller.contactPersonError.value = '';
                    controller.contactPersonName.value = value;
                  },
                  hintText: 'Jhon dee',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Email Address",
                  value: controller.companyDetails.email,
                  errorText: controller.emailError.value,
                  textInputType: TextInputType.emailAddress,
                  width: width * 0.9,
                  onChange: (value) {
                    controller.emailError.value = '';
                    controller.email.value = value;
                  },
                  hintText: 'jhonedee123@gmail.com',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Contact Number",
                  maxLength: 10,
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.number,
                  width: width * 0.9,
                  errorText: controller.contactError.value,
                  onChange: (value) {
                    controller.contactError.value = '';
                    controller.contact.value = value;
                  },
                  hintText: '9876543210',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Address 1",
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.text,
                  width: width * 0.9,
                  errorText: controller.address1Error.value,
                  onChange: (value) {
                    controller.address1Error.value = '';
                    controller.address1.value = value;
                  },
                  hintText: 'Street 105, colombia road',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Address 2",
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.text,
                  width: width * 0.9,
                  errorText: controller.address2Error.value,
                  onChange: (value) {
                    controller.address2Error.value = '';
                    controller.address2.value = value;
                  },
                  hintText: 'opp. Star moon restaurant',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "City",
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.text,
                  width: width * 0.9,
                  errorText: controller.cityError.value,
                  onChange: (value) {
                    controller.cityError.value = '';
                    controller.city.value = value;
                  },
                  hintText: 'Ahmedabad',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "State",
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.text,
                  width: width * 0.9,
                  errorText: controller.stateError.value,
                  onChange: (value) {
                    controller.stateError.value = '';
                    controller.state.value = value;
                  },
                  hintText: 'Gujrat',
                ),
              ),
              Obx(
                () => CustomEditText(
                  label: "Pincode",
                  maxLength: 6,
                  value: controller.companyDetails.contactNumber,
                  textInputType: TextInputType.number,
                  width: width * 0.9,
                  errorText: controller.pincodeError.value,
                  onChange: (value) {
                    controller.pincodeError.value = '';
                    controller.pincode.value = value;
                  },
                  hintText: '382350',
                ),
              ),
              // CustomEditText(
              //   label: "Designation",
              //   width: width * 0.9,
              //   onChange: (value) {
              //     print(value);
              //   },
              // ),
              ImagePickerCustom(
                width: width,
                imageError: controller.imageError.value,
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
                        controller.onClickAdd(context);
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

class ImagePickerCustom extends StatefulWidget {
  final double width;
  final String imageError;
  const ImagePickerCustom(
      {Key? key, required this.width, required this.imageError})
      : super(key: key);

  @override
  State<ImagePickerCustom> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            try {
              final image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) return;
              final imageTemp = File(image.path);
              setState(() {
                imageData = imageTemp;
              });
            } catch (e) {
              print(e.toString());
            }

            // this.controller.imageData = imageTemp;
          },
          child: Container(
            width: widget.width * 0.9,
            height: 130,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: widget.imageError == '' ? grayLight : colorPrimary),
            ),
            child: Builder(
              builder: (context) {
                if (imageData != null) {
                  return Image.file(imageData!);
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: gray2,
                          child:  Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 50,
                            color: gray,
                          ),
                        ),
                      ),
                       CustomText(
                        text: "Select Company Logo",
                        size: 16,
                        color: gray,
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
        CustomText(text: widget.imageError),
      ],
    );
  }
}
