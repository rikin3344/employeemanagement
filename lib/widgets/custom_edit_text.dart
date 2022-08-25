import 'package:employeemanagement/constants/style.dart';
import 'package:employeemanagement/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final String label;
  final String prefixText;
  final String value;
  final String suffixWidget;
  final double width;
  final int maxLength;
  final Function onChange;
  final TextAlign textAlign;
  final bool wantPadding;
  final bool isEnable;
  final TextInputType textInputType;
  const CustomEditText({
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
  }) : super(key: key);

  get nullFunction {}

  @override
  Widget build(BuildContext context) {
    String valueString = '';
    return Container(
      margin: EdgeInsets.only(bottom: wantPadding ? 20.0 : 0),
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
        decoration: InputDecoration(
            prefixText: "$prefixText ",
            labelText: label,
            counterText: '',
            suffix: InkWell(
              child: CustomText(text: suffixWidget),
            ),
            labelStyle: const TextStyle(color: gray),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: colorSecondary)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: valueString != ''
                    ? BorderSide(color: colorSecondary)
                    : BorderSide(color: grayExtraLight)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: valueString != ''
                    ? BorderSide(color: colorSecondary)
                    : BorderSide(color: grayLight))),
      ),
    );
  }
}
