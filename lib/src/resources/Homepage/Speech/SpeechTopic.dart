import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:english_app/src/resources/Homepage/Speech/LessionsUI.dart';
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
  List<String> textlist = [
    'please',
    'excuse me',
    'sorry',
    'should',
    'you should take some time off'
  ];
  int indexs = 0;
  String resultText = "";
  int result = 0;
  bool finish = false;
  AudioCache audioCache = new AudioCache();

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

  Widget checkResult() {
    if (result == 0) {
      return Container();
    } else if (result == 2) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/images/Correct.png",
            height: 90,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Phát âm đúng!',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    } else
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/images/Wrong.png",
            height: 90,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Phát âm sai!',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red)),
          SizedBox(
            height: 10,
          ),
        ],
      );
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        btnSection(),
                        if (result == 2 && finish==false) btnNext(),
                        if (finish == true) btnFinish(),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Kết quả',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[500]),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        padding: EdgeInsets.only(right: 100.0, left: 100.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.0)),
                        child: checkResult()),
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
                        setState(() {
                          result = 0;
                        });
                      },
                      backgroundColor: Colors.pink,
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.check),
                      mini: true,
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        if (_isListening)
                          setState(() {
                            result = 0;
                          });
                        _speechRecognition.stop().then(
                              (result) => setState(() => _isListening = result),
                            );

                        if (resultText.toUpperCase() ==
                            textlist[indexs].toUpperCase()) {
                          print('Phát âm đúng');
                          setState(() {
                            result = 2;
                            audioCache.play("audio/correct.mp3");
                          });
                        } else {
                          print('Phát âm sai');
                          setState(() {
                            result = 3;
                            audioCache.play("audio/wrong.mp3");
                          });
                        }
                        print('$indexs' + '${textlist.length}');
                        if (indexs == textlist.length - 1 && result == 2) {
                          setState(() {
                            finish = true;
                          });
                        }
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
            textlist[indexs],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
        ),
      );

  void SpeakTest() {
    print('Đã phát âm');
    flutterTts.speak(textlist[indexs]);
  }

  void NextWord() {
    setState(() {
      indexs++;
      inputSection();
      checkResult();
      result = 0;
    });
  }

  void Finish() {}

  Widget btnSection() => Container(
      child: _buildButtonColumn(Colors.green, Colors.greenAccent,
          Icons.play_arrow, 'Phát âm', SpeakTest));
  Widget btnNext() => Container(
      child: _buildButtonColumn(Colors.blue, Colors.blueAccent, Icons.skip_next,
          'Tiếp tục', NextWord));
  Widget btnFinish() => Container(
      child: _buildButtonColumn(
          Colors.red, Colors.redAccent, Icons.receipt, 'Hoàn thành', Finish));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
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
              onPressed: func),
          Container(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: color)))
        ]);
  }
}
