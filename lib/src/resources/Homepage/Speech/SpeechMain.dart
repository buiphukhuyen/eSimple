import 'package:english_app/src/resources/Homepage/Speech/LessionsUI.dart';
import 'package:english_app/src/resources/Homepage/Speech/SpeechTopic.dart';
import 'package:english_app/src/resources/Homepage/Speech/TestSpeech.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class SpeechMainPage extends StatelessWidget {
  List<LessionsUI> items = [
    LessionsUI(
      lesson: 'Bài học 1',
      title: '/s/ /sh/ /z/',
      image: 'assets/images/Speech/Numbers/1.png',
      color: 0xFFFFc1392b,
      percent: 0.1,
    ),
    LessionsUI(
      lesson: 'Bài học 2',
      title: 'Ending sounds',
      image: 'assets/images/Speech/Numbers/2.png',
      color: 0xFFFF7e8c8d,
      percent: 0.2,
    ),
    LessionsUI(
      lesson: 'Bài học 3',
      title: '/p/ /t/ /k/',
      image: 'assets/images/Speech/Numbers/3.png',
      color: 0xFFFF2d3e50,
      percent: 0.3,
    ),
    LessionsUI(
      lesson: 'Bài học 4',
      title: 'Schwa sound',
      image: 'assets/images/Speech/Numbers/4.png',
      color: 0xFFFFc8f44ad,
      percent: 0.4,
    ),
    LessionsUI(
      lesson: 'Bài học 5',
      title: '/p/ /t/ /k/',
      image: 'assets/images/Speech/Numbers/5.png',
      color: 0xFFFF16a086,
      percent: 0.5,
    ),
    LessionsUI(
      lesson: 'Bài học 6',
      title: 'The /r/ sound',
      image: 'assets/images/Speech/Numbers/6.png',
      color: 0xFFFF2a80b9,
      percent: 0.6,
    ),
    LessionsUI(
      lesson: 'Bài học 7',
      title: '/L/ /R/',
      image: 'assets/images/Speech/Numbers/7.png',
      color: 0xFFFF27ae61,
      percent: 0.7,
    ),
    LessionsUI(
      lesson: 'Bài học 8',
      title: '/w/ /v/ /b/',
      image: 'assets/images/Speech/Numbers/8.png',
      color: 0xFFFFf39c11,
      percent: 0.8,
    ),
    LessionsUI(
      lesson: 'Bài học 9',
      title: '/ʃ/ /ʒ/ /tʃ/ /dʒ/',
      image: 'assets/images/Speech/Numbers/9.png',
      color: 0xFFFFd25400,
      percent: 0.9,
    ),
  ];

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

  Widget _buildItemCardChild(LessionsUI item, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: LessionsUI(
            lesson: item.lesson,
            title: item.title,
            image: item.image,
            color: item.color,
          ),
        ));
  }

  Widget _buildCardList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 90.0, top: 150.0),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items.elementAt(index);
            return _buildItemCardChild(item, context);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            TopBar('LUYỆN PHÁT ÂM CHUẨN'),
          ],
        ),
      ),
    );
  }
}
