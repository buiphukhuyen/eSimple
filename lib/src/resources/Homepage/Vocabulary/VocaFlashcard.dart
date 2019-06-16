import 'package:english_app/src/resources/SwipeAnimation/Data/styles.dart';
import 'package:english_app/src/resources/model/Vocabluary.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:english_app/src/resources/SwipeAnimation/example2.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class VocaFlashcard extends StatefulWidget {
  @override
  _VocaFlashcardState createState() => _VocaFlashcardState();
}

final databaseReference = FirebaseDatabase.instance.reference();

class _VocaFlashcardState extends State<VocaFlashcard> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(216, 245, 255, 1),
      body: Center(
        child: //Example2()
            Text('Test'),
      ),
    );
  }

  void getData() {
    Vocabluary listitem;
    databaseReference
        .reference()
        .child('vocabulary')
        .orderByChild('country')
        .limitToFirst(10)
        .once()
        .then((DataSnapshot snapshot) {
      listitem = Vocabluary.fromJson(snapshot.value);
      print('Data: ${listitem.phonetic}');
      print('Data: ${listitem.text}');

      //print('Data : ${snapshot.value}');
    }).catchError((err) {
      print('$err');
    });
  }
}
