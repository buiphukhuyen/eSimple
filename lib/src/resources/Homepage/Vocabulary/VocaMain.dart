import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/Homepage/Vocabulary/Flashcard.dart';
import 'package:english_app/src/resources/model/TopicVoca.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class VocaMainPage extends StatefulWidget {
  @override
  _VocaMainPageState createState() => _VocaMainPageState();
}

class _VocaMainPageState extends State<VocaMainPage> {
  List<TopicVoca> items = List();
  TopicVoca item;
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();
    item = TopicVoca("", 0, "", "", 0, 0);
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('vocabulary');
    itemRef.onChildAdded.listen(_onEntryAdded);
    print('${item.name}');
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

  Widget _buildItemCardChild(TopicVoca item, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Flashcard()));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(item.image),
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      width: 100.0,
      height: 185.0,
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
    return Container(
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
