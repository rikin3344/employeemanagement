import 'package:addrec_employee_management/app/data/constants/style.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final String fontfamily;
  final bool isUnderline;
  const CustomText({
    Key? key,
    required this.text,
    this.size = 18,
    this.color = black123,
    this.fontfamily = "regular",
    this.isUnderline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily: fontfamily,
          overflow: TextOverflow.visible,
          decoration:
              isUnderline ? TextDecoration.underline : TextDecoration.none),
    );
  }
}
