import 'package:english_app/src/resources/Homepage/Speech/LessionsUI.dart';
import 'package:english_app/src/resources/Homepage/Vocabulary/VocaFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class SpeechMainPage extends StatelessWidget {
  List<LessionsUI> items = [
    /*LessionsUI(title: "Bài học 1", 'assets/images/Speech/Speech_Topic.png'),
    LessionsUI("Theo Mẫu câu", 'assets/images/Speech/Speech_Model.png'),
    LessionsUI("Bài học 1", 'assets/images/Speech/Speech_Topic.png'),
    LessionsUI("Theo Mẫu câu", 'assets/images/Speech/Speech_Model.png'),*/
    LessionsUI(
      title: 'Bài học 1',
      image: 'assets/images/Speech/Speech_Topic.png',
      percent: '0.1',
    )
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
              .push(MaterialPageRoute(builder: (context) => VocaFlashcard()));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: LessionsUI(title: item.title, image: item.image),
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
