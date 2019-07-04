import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class ListenMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TopBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            TopBar('LUYỆN NGHE TIẾNG ANH CHUẨN'),
          ],
        ),
      ),
    );
  }
}
