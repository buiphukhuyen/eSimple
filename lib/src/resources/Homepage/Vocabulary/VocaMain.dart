import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/Homepage/Vocabulary/Flashcard.dart';
import 'package:english_app/src/resources/model/TopicVoca.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:shimmer/shimmer.dart';

class VocaMainPage extends StatefulWidget {
  @override
  _VocaMainPageState createState() => _VocaMainPageState();
}

class _VocaMainPageState extends State<VocaMainPage> {
  List<TopicVoca> items = List();
  TopicVoca item;
  DatabaseReference itemRef;
  bool load = true;

  bool playmusic = false;

  AudioPlayer audioPlayer = AudioPlayer();

  play() async {
    int result = await audioPlayer.play(
        "https://firebasestorage.googleapis.com/v0/b/english-app-4b4c8.appspot.com/o/audio%2Fbackground.mp3?alt=media&token=01b876f2-e6d2-430a-87c9-67624e7893a2");
    if (result == 1) {
      print('Đã phát nhạc!');
    }
  }

  stop() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      print('Đã tắt nhạc!');
    }
  }

  Future<void> getdata() async {
    item = TopicVoca("", 0, "", "", 0, 0);
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('vocabulary');
    itemRef.onChildAdded.listen(_onEntryAdded);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(TopicVoca.fromSnapshot(event.snapshot));
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
                  if (playmusic == false) {
                    setState(() {
                      play();
                      playmusic = true;
                    });
                  } else {
                    setState(() {
                      stop();
                      playmusic = false;
                    });
                  }
                },
                icon:
                    playmusic ? Icon(Icons.volume_up) : Icon(Icons.volume_mute),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemCardChild(TopicVoca item, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Flashcard(
                  topic: item.topic,
                  name: item.name,
                )));
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.pie_chart),
                    color: Colors.blue,
                  ),
                ]),
            CachedNetworkImage(
              imageUrl: item.image,
              fit: BoxFit.scaleDown,
              height: 140,
              width: 200,
              placeholder: (_, str) => Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item.length.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.percent.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCart(TopicVoca item, BuildContext context) {
    return Container(
      // width: 100.0,
      //height: 185.0,
      padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
      child: _buildItemCardChild(item, context),
    );
  }

  Widget _buildCardList(BuildContext context) {
    return load
        ? Padding(
            padding: EdgeInsets.only(top: 180.0),
            child: ShimmerList(),
          )
        : Container(
            padding: EdgeInsets.only(bottom: 90.0, top: 150.0),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items.elementAt(index);
                  return _buildItemCart(item, context);
                }),
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
            _buildCardList(context),
            TopBar('HỌC TỪ VỰNG - FLASHCARD'),
          ],
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
