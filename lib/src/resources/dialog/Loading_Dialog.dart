import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.all(Radius.circular(
                              15.0) //                 <--- border radius here
                          )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitCubeGrid(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                        child: Text(
                          msg,
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ));
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}
