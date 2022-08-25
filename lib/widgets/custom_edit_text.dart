import 'package:employeemanagement/constants/style.dart';
import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final String label;
  final String prefixText;
  final String value;
  final double width;
  final Function onChange;
  final TextAlign textAlign;
  final bool wantPadding;
  final TextInputType textInputType;
  const CustomEditText(
      {Key? key,
      required this.label,
      required this.width,
      required this.onChange,
      this.textInputType = TextInputType.text,
      this.prefixText = '',
      this.value = '',
      this.textAlign = TextAlign.start,
      this.wantPadding = true})
      : super(key: key);

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
        textAlign: textAlign,
        decoration: InputDecoration(
            prefixText: "$prefixText ",
            labelText: label,
            labelStyle: const TextStyle(color: gray),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: colorSecondary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: valueString != ''
                    ? BorderSide(color: colorSecondary)
                    : BorderSide(color: grayLight))),
      ),
    );
  }
}
