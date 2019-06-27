import 'package:audioplayers/audio_cache.dart';
import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/model/Vocabluary.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:transparent_image/transparent_image.dart';

class Flashcard extends StatefulWidget {
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  FlutterTts flutterTts = new FlutterTts();
  List<Vocabulary> items = List();
  Vocabulary item;
  DatabaseReference itemRef;
  bool test = false;
  AudioCache audioCache = new AudioCache();

  @override
  void initState() {
    //MassageDialog.showMessageDialog(context, 'Đang tải dữ liệu', "Vui lòng đợi");

    super.initState();

    item = Vocabulary("", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('vocabulary').child('country');
    itemRef.onChildAdded.listen(_onEntryAdded);
    //LoadingDialog.hideLoadingDialog(context);

    //PlayMusic
    audioCache.play("audio/background.mp3");
  }

  @override
  void dispose() {
    audioCache.clear("audio/background.mp3");
    audioCache.clearCache();
    super.dispose();
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
      child: test
          ? Container(
              padding: EdgeInsets.only(
                  top: 120.0, bottom: 60.0, right: 70.0, left: 70.0),
              child: RaisedButton(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      size: 60.0,
                      color: Colors.blue,
                    ),
                    Text(
                      'Kiểm tra từ vựng',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                color: Colors.white,
                onPressed: () {},
              ),
            )
          : Container(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
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
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: items[index].image,
                            ),
                          ),
                          Text(
                            items[index].name,
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text('/' + '${items.length}')
                            ],
                          )
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
                    onFlip: () {
                      audioCache.play("audio/flipcard.mp3", volume: 0.2);
                    },
                  );
                },
                control: new SwiperControl(),
                loop: false,
                pagination: new SwiperPagination(),
                itemCount: items.length,
                viewportFraction: 0.8,
                scale: 0.6,
                onIndexChanged: (int index) {
                  print('$index');
                  if (index == items.length - 1) {
                    setState(() {
                      test = true;
                    });
                  } else {
                    setState(() {
                      test = false;
                    });
                  }
                },
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
