import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_edit_text.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEmployeeOther extends StatefulWidget {
  const AddEmployeeOther({Key? key}) : super(key: key);

  @override
  State<AddEmployeeOther> createState() => _AddEmployeeOtherState();
}

class _AddEmployeeOtherState extends State<AddEmployeeOther> {
  var travelBy = [
    'Travel By',
    'Airplane',
    'Bus',
    'Train',
    'Car',
    'Taxi',
  ];
  String selectedTravel = 'Travel By';

  bool wifeOrHusband = false;
  bool mother = false;
  bool father = false;
  bool children = false;
  bool other = false;
  String noOfChildren = '';

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
                text: "Other Details",
                size: 18,
                fontfamily: "bold",
                color: colorPrimary,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(bottom: 20.0),
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
                      text: "Company",
                    ),
                    value: selectedTravel,
                    onChanged: (newValue) async {
                      setState(() {
                        selectedTravel = newValue!;
                      });
                    },
                    items: travelBy.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: CustomText(
                          text: items,
                          color: items == "Travel By" ? gray : black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              CustomEditText(
                label: "Arrival Place",
                width: width * 0.9,
                onChange: (value) {
                  print(value);
                },
              ),
              const CustomText(
                text: "Family Members",
                size: 14,
              ),
              SizedBox(
                width: width * 0.88,
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
                      value: wifeOrHusband,
                      onChanged: (value) {
                        setState(() {
                          wifeOrHusband = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: wifeOrHusband ? colorPrimary : black,
                          fontfamily: wifeOrHusband ? 'semiBold' : 'medium',
                          text: "Wife / Husband"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.88,
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
                      value: mother,
                      onChanged: (value) {
                        setState(() {
                          mother = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: mother ? colorPrimary : black,
                          fontfamily: mother ? 'semiBold' : 'medium',
                          text: "Mother"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.88,
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
                      value: father,
                      onChanged: (value) {
                        setState(() {
                          father = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: CustomText(
                          size: 16,
                          color: father ? colorPrimary : black,
                          fontfamily: father ? 'semiBold' : 'medium',
                          text: "Father"),
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
                          value: children,
                          onChanged: (value) {
                            setState(() {
                              children = value!;
                            });
                          },
                        ),
                        CustomText(
                            size: 16,
                            color: children ? colorPrimary : black,
                            fontfamily: children ? 'semiBold' : 'medium',
                            text: noOfChildren == ''
                                ? "Child"
                                : int.parse(noOfChildren) <= 1
                                    ? "Child"
                                    : "Children"),
                      ],
                    ),
                    Visibility(
                      visible: children,
                      child: CustomEditText(
                        label: "Number of children",
                        width: width * 0.25,
                        value: noOfChildren,
                        wantPadding: false,
                        textInputType: TextInputType.number,
                        onChange: (value) {
                          setState(() {
                            noOfChildren = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: children && other ? 10.0 : 0.0),
                child: SizedBox(
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
                          label: "Relation",
                          textAlign: TextAlign.center,
                          width: width * 0.4,
                          wantPadding: false,
                          value: noOfChildren,
                          textInputType: TextInputType.text,
                          onChange: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                height: 100.0,
                width: width,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: colorSecondary,
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Other Details",
                      labelStyle: const TextStyle(color: gray),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: colorSecondary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: grayLight))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
