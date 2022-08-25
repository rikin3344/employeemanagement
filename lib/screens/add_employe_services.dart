import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AddEmployeeServices extends StatefulWidget {
  const AddEmployeeServices({Key? key}) : super(key: key);

  @override
  State<AddEmployeeServices> createState() => _AddEmployeeServicesState();
}

class _AddEmployeeServicesState extends State<AddEmployeeServices> {
  bool transportation = false;
  bool hotel = false;
  bool school = false;
  bool pickup = false;
  bool other = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Services",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide.none),
                      activeColor: colorPrimary,
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                                color: colorPrimary,
                              )),
                      value: transportation,
                      onChanged: (value) {
                        setState(() {
                          transportation = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: transportation ? colorPrimary : black,
                          fontfamily: transportation ? 'semiBold' : 'medium',
                          text: "Transportation"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide.none),
                      activeColor: colorPrimary,
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                                color: colorPrimary,
                              )),
                      value: hotel,
                      onChanged: (value) {
                        setState(() {
                          hotel = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: hotel ? colorPrimary : black,
                          fontfamily: hotel ? 'semiBold' : 'medium',
                          text: "Hotel / House Check"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide.none),
                      activeColor: colorPrimary,
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                                color: colorPrimary,
                              )),
                      value: school,
                      onChanged: (value) {
                        setState(() {
                          school = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: school ? colorPrimary : black,
                          fontfamily: school ? 'semiBold' : 'medium',
                          text: "School"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide.none),
                      activeColor: colorPrimary,
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(
                                color: colorPrimary,
                              )),
                      value: pickup,
                      onChanged: (value) {
                        setState(() {
                          pickup = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: pickup ? colorPrimary : black,
                          fontfamily: pickup ? 'semiBold' : 'medium',
                          text: "Pickup"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide.none),
                          activeColor: colorPrimary,
                          checkColor: Colors.white,
                          side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                    color: colorPrimary,
                                  )),
                          value: other,
                          onChanged: (value) {
                            setState(() {
                              other = value!;
                            });
                          },
                        ),
                        CustomText(
                            size: 16,
                            color: other ? colorPrimary : black,
                            fontfamily: other ? 'semiBold' : 'medium',
                            text: "Other"),
                      ],
                    ),
                    Visibility(
                      visible: other,
                      child: CustomEditText(
                        label: "Service",
                        width: width * 0.4,
                        wantPadding: false,
                        textInputType: TextInputType.text,
                        onChange: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
