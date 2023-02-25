import 'package:addrec_employee_management/app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PopUp {
  start(BuildContext context, title, message, height, titleColor,
      Function function) {
    AlertDialog alertDialog = AlertDialog(
      elevation: 0,
      content: SizedBox(
        height: height,
        child: Center(
            child: Column(
          children: [
            CustomText(
              text: title,
              size: 22,
              fontfamily: 'bold',
              color: titleColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: CustomText(
                text: message,
                size: 14,
              ),
            ),
          ],
        )),
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // print("object");
        Navigator.of(context, rootNavigator: true).pop('dialog');
        function();
      },
    );
  }

  stopDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}
