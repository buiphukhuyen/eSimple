import 'package:english_app/src/resources/Homepage/Vocabulary/VocaFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class GrammarMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      //appBar: TopBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            TopBar('HỌC NGỮ PHÁP QUA VÍ DỤ'),
          ],
        ),
      ),
    );
  }
}
