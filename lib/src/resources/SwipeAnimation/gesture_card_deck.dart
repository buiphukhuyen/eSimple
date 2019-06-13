import 'dart:math';
import 'package:english_app/src/resources/SwipeAnimation/current_deck_card.dart';
import 'package:flutter/material.dart';

class GestureCardDeck extends StatefulWidget {
  final List data;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final Function onCardTap;
  final double velocityToSwipe;
  final Duration animationTime;
  final double leftPosition;
  final double topPosition;
  final Widget leftSwipeButton;
  final Widget rightSwipeButton;
  final Widget leftSwipeBanner;
  final Widget rightSwipeBanner;
  final bool showAsDeck;
  final bool isButtonFixed;
  final Offset fixedButtonPosition;
  final bool showDiagoinaly;

  const GestureCardDeck({
    Key key,
    this.velocityToSwipe = 1000,
    this.animationTime = const Duration(milliseconds: 100),
    this.leftPosition = 0,
    this.topPosition = 0,
    this.rightSwipeButton,
    this.leftSwipeButton,
    this.leftSwipeBanner,
    this.rightSwipeBanner,
    this.showAsDeck = true,
    this.isButtonFixed = false,
    this.fixedButtonPosition,
    this.showDiagoinaly = false,
    @required this.onCardTap,
    @required this.data,
    @required this.onSwipeRight,
    @required this.onSwipeLeft,
  }) : super(key: key);
  @override
  GestureCardDeckState createState() => new GestureCardDeckState();
}

class GestureCardDeckState extends State<GestureCardDeck>
    with TickerProviderStateMixin {
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  List data;
  List showData;
  List selectedData = [];
  static int i = 0;
  void initState() {
    super.initState();
    data = widget.data;
    showData = data.take(5).toList();
  }

  onGestureSwipeLeft() {
    setState(() {
      widget.onSwipeLeft(data.indexOf(showData[0]));
      showData.removeAt(0);
      i++;
    });
    if (showData.length != 0) if (data.length >=
        5 + data.indexOf(showData[0])) {
      var j = data[4 + data.indexOf(showData[0])];
      showData.add(j);
    }
  }

  onGestureSwipeRight() {
    setState(() {
      widget.onSwipeRight(data.indexOf(showData[0]));
      showData.removeAt(0);
      i++;
    });
    if (showData.length != 0) if (data.length >=
        5 + data.indexOf(showData[0])) {
      var j = data[4 + data.indexOf(showData[0])];
      showData.add(j);
    }
  }

  onCardTap() {
    widget.onCardTap(data.indexOf(showData[0]));
  }

  @override
  Widget build(BuildContext context) {
    String key = Random().nextDouble().toString();
    double backCardPosition = widget.topPosition;
    double backCardLeftPosition = widget.leftPosition;
    double backCardWidth = -10.0;
    return new Stack(
      key: Key(key),
      alignment: AlignmentDirectional.center,
      children: showData.reversed.map((item) {
        if (showData.indexOf(item) == 0) {
          return CurrentDeckCard(
            isActive: true,
            initialPosition: Offset(
                widget.showDiagoinaly
                    ? widget.leftPosition + showData.length * 10
                    : widget.leftPosition,
                widget.showAsDeck ? backCardPosition + 10 : backCardPosition),
            singleData: item,
            cardWidth: backCardWidth + 10,
            context: context,
            onGestureSwipeLeft: onGestureSwipeLeft,
            onGestureSwipeRight: onGestureSwipeRight,
            onCardTap: onCardTap,
            velocityToSwipe: widget.velocityToSwipe,
            animationTime: widget.animationTime,
            leftSwipeButton: widget.leftSwipeButton,
            rightSwipeButton: widget.rightSwipeButton,
            leftSwipeBanner: widget.leftSwipeBanner,
            rightSwipeBanner: widget.rightSwipeBanner,
            fixedButtonPosition: widget.fixedButtonPosition,
            isButtonFixed: widget.isButtonFixed,
          );
        } else {
          if (widget.showAsDeck) {
            backCardPosition = backCardPosition + 10;
            if (widget.showDiagoinaly)
              backCardLeftPosition = backCardLeftPosition + 10;
          }
          if (widget.showAsDeck)
            //  backCardLeftPosition = backCardLeftPosition + 10;
            return CurrentDeckCard(
              isActive: false,
              fixedButtonPosition: widget.fixedButtonPosition,
              initialPosition: Offset(backCardLeftPosition, backCardPosition),
              singleData: item,
              cardWidth: backCardWidth,
              context: context,
              onGestureSwipeLeft: onGestureSwipeLeft,
              onGestureSwipeRight: onGestureSwipeRight,
              onCardTap: widget.onCardTap,
              leftSwipeButton: widget.leftSwipeButton,
              rightSwipeButton: widget.rightSwipeButton,
              isButtonFixed: widget.isButtonFixed,
            );
        }
      }).toList(),
    );
  }
}
