import 'package:english_app/src/resources/Homepage/Vocabulary/VocaFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';

class VocaMainPage extends StatelessWidget {
  List<itemModel> items = [
    itemModel(
        1, "Các Quốc gia", 'assets/images/Voca/Voca_Country.png', 12, 1830),
    itemModel(2, "Thời tiết", 'assets/images/Voca/Voca_Weather.png', 4, 883),
    itemModel(3, "Gia đình", 'assets/images/Voca/Voca_Family.png', 2, 326),
    itemModel(4, "Nghề nghiệp", 'assets/images/Voca/Voca_Job.png', 2, 326),
    itemModel(5, "Các hoạt động thường ngày",
        'assets/images/Voca/Voca_Activity.png', 2, 326),
    itemModel(6, "Đồ ăn", 'assets/images/Voca/Voca_Food.png', 2, 326),
  ];

  Widget _buildTitle() {
    return Text(
      'HỌC TỪ VỰNG - FLASHCARD',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontFamily: "SFUIText-Bold",
      ),
    );
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

  Widget _buildItemCardChild(itemModel item, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VocaFlashcard()));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(item.image),
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
                    item.title,
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
                  item.numOne.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.numTwo.toString(),
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

  Widget _buildItemCart(itemModel item, BuildContext context) {
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

class itemModel {
  final int index;
  final String title;
  final String image;
  final int numOne;
  final int numTwo;
  itemModel(this.index, this.title, this.image, this.numOne, this.numTwo);
}
