import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


final databaseReference = FirebaseDatabase.instance.reference();
void getData(){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

Widget image1 = Container(
  padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/VietNam.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Viet Nam", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),   
);

Widget image2 = Container(
 padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Japan.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Japan", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image3 = Container(
 padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/China.png')),
        ),
        SizedBox(height: 40.0,),
        Text("China", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image4 = Container(
  padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Korea.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Korea", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image5 = Container(
 padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Thailand.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Thailand", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image6 = Container(
   padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Brazil.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Brazil", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image7 = Container(
  padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Canada.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Cananda", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image8 = Container(
   padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Germany.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Germany", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image9 = Container(
   padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/France.png')),
        ),
        SizedBox(height: 40.0,),
        Text("France", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

Widget image10 = Container(
   padding: EdgeInsets.only(top: 80.0),
  height: 400,
  width: 300,
  alignment: Alignment.topCenter,
  decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
  child:
    Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Image(image: AssetImage('assets/images/Voca/Country/Japan.png')),
        ),
        SizedBox(height: 40.0,),
        Text("Japan", style: 
          TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ), 
);

ImageProvider avatar1 = new ExactAssetImage('assets/avatars/avatar-1.jpg');
ImageProvider avatar2 = new ExactAssetImage('assets/avatars/avatar-2.jpg');
ImageProvider avatar3 = new ExactAssetImage('assets/avatars/avatar-3.jpg');
ImageProvider avatar4 = new ExactAssetImage('assets/avatars/avatar-4.jpg');
ImageProvider avatar5 = new ExactAssetImage('assets/avatars/avatar-5.jpg');
ImageProvider avatar6 = new ExactAssetImage('assets/avatars/avatar-6.jpg');
