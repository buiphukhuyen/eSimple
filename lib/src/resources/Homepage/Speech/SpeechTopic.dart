import 'dart:io';

import 'package:english_app/src/resources/Homepage/Speech/LessionsUI.dart';
import 'package:english_app/src/resources/Homepage/Vocabulary/VocaFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechTopicPage extends StatefulWidget {
  @override
  _SpeechTopicPageState createState() => _SpeechTopicPageState();
}

class _SpeechTopicPageState extends State<SpeechTopicPage> {
  LessionsUI item = new LessionsUI();
  FlutterTts flutterTts = new FlutterTts();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String textvoice = 'test';
  String resultText = "";

  @override
  initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _speechRecognition.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 200.0, 20.0, 200.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Text('Nhấn Play để nghe từ và Micro để phát âm',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800])),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    inputSection(),
                    SizedBox(
                      height: 20.0,
                    ),
                    btnSection(),
                    SizedBox(height: 30.0),
                    Text(
                      'Kết quả',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[500]),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.only(bottom: 150.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                  ]),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.cancel),
                      mini: true,
                      backgroundColor: Colors.deepOrange,
                      onPressed: () {
                        if (_isListening)
                          _speechRecognition.cancel().then(
                                (result) => setState(() {
                                      _isListening = result;
                                      resultText = "";
                                    }),
                              );
                      },
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.mic),
                      onPressed: () {
                        if (_isAvailable && !_isListening)
                          _speechRecognition
                              .listen(locale: "en_US")
                              .then((result) => print('$result'));
                      },
                      backgroundColor: Colors.pink,
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.stop),
                      mini: true,
                      backgroundColor: Colors.deepPurple,
                      onPressed: () {
                        if (_isListening)
                          _speechRecognition.stop().then(
                                (result) =>
                                    setState(() => _isListening = result),
                              );
                      },
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent[100],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Text(
                    resultText,
                    style: TextStyle(fontSize: 24.0),
                  ),
                )
              ],
            ),
            TopBar('BÀI HỌC 1'),
          ],
        ),
      ),
    );
  }

  Widget inputSection() => Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0, top: 30.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              textvoice,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            )),
      );

  Widget btnSection() => Container(
      child: _buildButtonColumn(Colors.green, Colors.greenAccent,
          Icons.play_arrow, 'PLAY', textvoice));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, String textvoice) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              child: Icon(
                icon,
                color: Colors.white,
              ),
              color: color,
              splashColor: splashColor,
              onPressed: () {
                print('Vao day');
                flutterTts.speak(textvoice);
              }),
          Container(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: color)))
        ]);
  }
}
