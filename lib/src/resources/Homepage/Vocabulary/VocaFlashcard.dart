import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:english_app/src/resources/SwipeAnimation/example2.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class VocaFlashcard extends StatefulWidget {
  @override
  _VocaFlashcardState createState() => _VocaFlashcardState();
}

class _VocaFlashcardState extends State<VocaFlashcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(216, 245, 255, 1),
      body: Center(
        child: Example2(),
      ),
    );
  }
}
