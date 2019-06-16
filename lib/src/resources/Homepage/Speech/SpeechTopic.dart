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

enum TtsState { playing, stopped }

class _SpeechTopicPageState extends State<SpeechTopicPage> {
  LessionsUI item = new LessionsUI();
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  List<String> items = ['please'];

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
    initSpeechRecognizer();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
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

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print(language);
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getVoiceDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in voices) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language);
    });
  }

  void changedVoiceDropDownItem(String selectedType) {
    setState(() {
      voice = selectedType;
      flutterTts.setVoice(voice);
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
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
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0, top: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
        child: Center(
          child: TextField(
            onChanged: (String value) {
              _onChange(value);
            },
          ),
        ),
      );

  Widget btnSection() => Container(
      child: _buildButtonColumn(
          Colors.green, Colors.greenAccent, Icons.play_arrow, 'PLAY', _speak));

  Widget languageDropDownSection() => Text('en-ZA');

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: color)))
        ]);
  }
}
