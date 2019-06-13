import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LessionsUI extends StatelessWidget {
  final String title;
  final String image;
  final String percent;
  LessionsUI({this.title, this.image, this.percent}); // Listview.builder()

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          width: width,
          height: 175,
          //color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(left: 40),
            width: width,
            child: Card(
              elevation: 10,
              color: Colors.green,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 30, // (200 -120) /2
          child: CircularPercentIndicator(
            radius: 110.0,
            lineWidth: 10.0,
            animation: true,
            percent: 0.7,
            center:
                CircleAvatar(maxRadius: 40, backgroundImage: AssetImage(image)),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
