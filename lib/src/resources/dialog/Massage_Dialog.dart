import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MassageDialog {
  static void showMessageDialog(BuildContext context,String title, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Đồng ý'),
            onPressed: () {
              Navigator.of(context).pop(MassageDialog);
            })
        ],
      )
    );
  }

}