import 'package:english_app/src/resources/SwipeAnimation/Data/data.dart';
import 'package:english_app/src/resources/SwipeAnimation/gesture_card_deck.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    GestureCardDeck(
      isButtonFixed: true,
      fixedButtonPosition: Offset(50, 580),
      data: imageData,
      animationTime: Duration(milliseconds: 500),
      showAsDeck: true,
      velocityToSwipe: 1200,

      leftSwipeButton: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          child:
              Center(child: Text("Bỏ qua", style: TextStyle(color: Colors.white))),
        ),
      ),
      
      rightSwipeButton: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          child:
              Center(child: Text("Tiếp theo", style: TextStyle(color: Colors.white))),
        ),
      ),
      onSwipeLeft: (index) {
        print("on swipe left");
        print(index);
      },
      onSwipeRight: (index) {
        print("on swipe right");
        print(index);
      },
      onCardTap: (index) {
        print("on card tap");

        print(index);
      },
      leftPosition: 50,
      topPosition: 90,
      leftSwipeBanner: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Transform.rotate(
          angle: 0.5,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tiếp theo",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      rightSwipeBanner: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Transform.rotate(
          angle: -0.5,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Bỏ qua",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
