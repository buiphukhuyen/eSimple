import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/User/PageLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: PageLogin(),
      debugShowCheckedModeBanner: false, //Hide Debug Mode in Simulator
    ));
