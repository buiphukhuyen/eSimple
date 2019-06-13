import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class FunctionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0, right: 25.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/LogoApp.png",
                      width: 60.0,
                      height: 60.0,
                    ),
                    Text("Simple",
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontFamily: "SVN-Poky's", //Style
                          fontSize: 36.0, //Font
                          letterSpacing: .10,
                        ))
                  ],
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://scontent-hkg3-1.xx.fbcdn.net/v/t1.0-9/12341533_459361484264388_7894916608898433832_n.jpg?_nc_cat=103&_nc_oc=AQme9LkboGz8e7bdKl9J4IEXyGLg-VwTCRiWJ-M7UvyEPHa6UpESz4gwfz-FL9tJHtw&_nc_ht=scontent-hkg3-1.xx&oh=563b46dd16d935eb829c1a7910527269&oe=5D6AA9B1"))),
                ),
              ]),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Trang chủ',
            style: TextStyle(
                fontFamily: 'SFUIText-Bold',
                color: Colors.black,
                fontSize: 30.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: TextField(
                    style: TextStyle(fontSize: 18.5),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Tìm kiếm',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Stack(
                children: <Widget>[
                  Icon(
                    Icons.notifications_none,
                    size: 27.0,
                  ),
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 70.0,
          ),
          Container(
            height: 310.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FuncCard('assets/images/Study_Voca.png', 'HỌC TỪ VỰNG',
                    'THÔNG QUA FLASHCARD', Colors.blue[400], context, 0),
                FuncCard('assets/images/Study_Grammar.png', 'HỌC NGỮ PHÁP',
                    'QUA VÍ DỤ', Colors.green[400], context, 1),
                FuncCard(
                    'assets/images/Study_Speaking.png',
                    'LUYỆN NÓI\nTIẾNG ANH',
                    'CHUẨN',
                    Colors.grey[400],
                    context,
                    2),
                FuncCard('assets/images/Study_Music.png', 'HỌC\nTIẾNG ANH',
                    'BẰNG BÀI HÁT', Colors.pink[400], context, 3),
                FuncCard('assets/images/Study_Gaming.png', 'TƯƠNG TÁC\nBẠN BÈ',
                    '', Colors.red[400], context, 4),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(image: AssetImage("assets/images/Bot_Support.gif"), height: 169.0, width: 169.0,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
