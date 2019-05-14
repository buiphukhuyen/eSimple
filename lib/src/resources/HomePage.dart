import 'package:english_app/src/resources/ProfileSetting.dart';
import 'package:english_app/src/resources/widgets/CardItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'FunctionPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State <HomePage> {
  int index = 0;
  final _pageOption = [
    FunctionPage(),
    ProfileSetting(),
    ProfileSetting(),
    ProfileSetting()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[index],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            index == 0 
            ? selectedMenuBottom(Icon(Icons.home),'Trang chủ')
            : 
            IconButton(icon: Icon(Icons.home), onPressed: () {
              setState(() {
                index=0;
              });
            },),
            index == 1 
            ? selectedMenuBottom(Icon(Icons.bookmark),'Tiến trình')
            : 
            IconButton(icon: Icon(Icons.bookmark), onPressed: () {
              setState(() {
                index=1;
              });
            },),

            index == 2 
            ? selectedMenuBottom(Icon(Icons.notifications_active),'Thông báo')
            : 
            IconButton(icon: Icon(Icons.notifications_active), onPressed: () {
              setState(() {
                index=2;
              });
            },), 

            index == 3 
            ? selectedMenuBottom(Icon(Icons.supervisor_account),'Người dùng')
            : 
            IconButton(icon: Icon(Icons.supervisor_account), onPressed: () {
              setState(() {
                index=3;
              });
            },), 
            
        ],),
      ),
    );
  }
}

Widget FuncCard(String image, String toptext, String bottext, Color colors) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 20), 
              width: 230.0,
              height: 320.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                     image: 
                     DecorationImage(image: AssetImage(image), 
                     fit:BoxFit.fitWidth), color: colors 
                    )    
                  ),
                  /*Positioned(
                      bottom: 1,
                      right: 1,
                      child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.chevron_right, color: Colors.white,), onPressed: () {},
                    ),
                  ), */
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(toptext,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SFUIText-Bold',
                        color: Colors.white,
                        fontSize: 20.0
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(bottext,
                      textAlign: TextAlign.center,
                      style: TextStyle( 
                        fontFamily: 'SFUIText-Bold',
                        color: Colors.white,
                        fontSize: 21.0
                      )),
                    ),
                  ),
                ],
              ),
            );
}
Widget selectedMenuBottom(Icon icon, String text) {
    return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)
                ),
                color: Colors.blue[300]
              ),
              child: Row(children: <Widget>[
                icon,
                Text(text, style: TextStyle(
                  fontFamily: 'SFUIText-Bold',
                ),)
              ],),
            );
  }