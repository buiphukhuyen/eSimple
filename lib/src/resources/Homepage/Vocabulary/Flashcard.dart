import 'dart:io';

import 'package:english_app/src/resources/model/Vocabluary.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Flashcard extends StatefulWidget {
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  FlutterTts flutterTts = new FlutterTts();
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

  Widget _buildBottomCard(double width, double height) {
    return Container(
      width: width,
      height: height / 3,
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
      decoration: BoxDecoration(
          color: Colors.blue[500],
          borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(32.0, 10.0),
              topLeft: Radius.elliptical(32.0, 10.0))),
      //child: _buildBottomCardChildren(),
    );
  }

  Widget _buildBottomCardChildren(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.radio_button_checked),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.home),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.settings),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //appBar: TopBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCard(width, height)),
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCardChildren(context)),
            TopBar('COUNTRY'),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 230.0, 30.0, 210.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return FlipCard(
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2.5, color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 1)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.network(items[index].image),
                          ),
                          Text(
                            items[index].name,
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2.5, color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 1)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: RaisedButton(
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 60.0,
                                color: Colors.blue,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                flutterTts.speak(items[index].name);
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                                child: Text(items[index].name,
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text('/' + items[index].phonetic + '/',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(items[index].translate,
                              style: TextStyle(
                                fontSize: 28.0,
                              )),
                        ],
                      ),
                    ),
                  );
                },
                loop: false,
                pagination: new SwiperPagination(),
                itemCount: items.length,
                viewportFraction: 0.8,
                scale: 0.6,
              ),
            ),
          ],
        ),
      ),
    );

    /*Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: 
    ); */
  }
}
