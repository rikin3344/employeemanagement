import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final String label;
  final String prefixText;
  final String value;
  final String suffixWidget;
  final String errorText;
  final String hintText;
  final double width;
  final int maxLength;
  final Function onChange;
  final TextAlign textAlign;
  final bool wantPadding;
  final bool isEnable;
  final TextInputType textInputType;
  CustomEditText({
    Key? key,
    required this.label,
    required this.width,
    required this.onChange,
    this.textInputType = TextInputType.text,
    this.prefixText = '',
    this.value = '',
    this.textAlign = TextAlign.start,
    this.wantPadding = true,
    this.suffixWidget = '',
    this.maxLength = 10000,
    this.isEnable = true,
    this.errorText = '',
    required this.hintText,
  }) : super(key: key);

  get nullFunction {}

  @override
  Widget build(BuildContext context) {
    String valueString = '';
    return Padding(
      padding: EdgeInsets.only(bottom: wantPadding ? 20.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            height: 50.0,
            width: width,
            child: TextFormField(
              onChanged: (value) {
                onChange(value);
                valueString = value;
              },
              initialValue: value,
              keyboardType: textInputType,
              cursorColor: colorSecondary,
              maxLength: maxLength,
              textAlign: textAlign,
              enabled: isEnable,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixText: "$prefixText ",
                  labelText: label,
                  hintText: hintText,
                  counterText: '',
                  errorText: null,
                  suffix: InkWell(
                    child: CustomText(text: suffixWidget),
                  ),
                  labelStyle: TextStyle(color: gray),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: colorSecondary)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: colorSecondary)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: colorPrimary)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: valueString != ''
                          ? BorderSide(color: colorSecondary)
                          : BorderSide(color: grayExtraLight)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: valueString != ''
                          ? BorderSide(color: colorSecondary)
                          : errorText == ''
                              ? BorderSide(color: grayLight)
                              : BorderSide(color: colorPrimary))),
            ),
          ),
          Visibility(
            visible: errorText == '' ? false : true,
            child: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: CustomText(
                text: errorText,
                color: colorPrimary,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
