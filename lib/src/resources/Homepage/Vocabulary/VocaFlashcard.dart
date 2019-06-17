import 'package:english_app/src/resources/model/Vocabluary.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocaFlashcard extends StatefulWidget {
  @override
  _VocaFlashcardState createState() => _VocaFlashcardState();
}

class _VocaFlashcardState extends State<VocaFlashcard> {
  List<Vocabulary> items = List();
  Vocabulary item;
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();
    item = Vocabulary("", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('vocabulary').child('country');
    itemRef.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Vocabulary.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FB example'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          items.length == 0
              ? Container()
              : Column(
                  children: List.generate(items.length, (index) {
                  return Row(
                    children: <Widget>[
                      Text(items[index].name),
                      Text('[' + items[index].phonetic + ']')
                    ],
                  );
                })
                )
        ],
      ),
    );
  }
}
