import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Custom_Dialog.dart';

class MassageDialog {
  static void showMessageDialog(
      BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomDialog(
              title: title,
              description: msg,
              buttonText: "Đồng ý",
            ));
  }
}
