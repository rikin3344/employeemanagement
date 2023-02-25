import 'package:flutter/material.dart';

class Loading {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator.adaptive(),
    ),
  );
  start(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  stopDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  dispose() {
    Loading().dispose();
  }
}
