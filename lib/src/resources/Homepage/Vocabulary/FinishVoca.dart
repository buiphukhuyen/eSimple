import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FinishVoca extends StatelessWidget {
  Widget _buildBottomCard(double width, double height) {
    return Container(
      width: width,
      height: height / 7,
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 32.0),
      decoration: BoxDecoration(
          color: Colors.blue[500],
          borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(32.0, 10.0),
              topLeft: Radius.elliptical(32.0, 10.0))),
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
            Container(
              padding: EdgeInsets.all(200.0),
              child: CircularPercentIndicator(
                radius: 210.0,
                lineWidth: 10.0,
                animation: true,
                percent: 0.1,
                center: Text('RUNNING'),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.red,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCardChildren(context)),
            TopBar('HOÀN THÀNH PHẦN LUYỆN'),
          ],
        ),
      ),
    );
  }
}
