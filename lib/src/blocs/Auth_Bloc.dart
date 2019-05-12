import 'dart:async';
import 'package:english_app/src/firebase/Firebase_Auth.dart';
import 'package:english_app/src/validators/Validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  

  //static final FacebookLogin facebookSignIn = new FacebookLogin();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _confirmController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get confirmStream => _confirmController.stream;

bool isValueInfo(String email, String password) {
    
    if (!Validations.isValidEmpty(email)) {
      _emailController.sink.addError("Nhập địa chỉ Email");
      return false;
    }

    if(!Validations.isValidEmail(email)) {
      _emailController.sink.addError('Email không đúng định dạng!');
      return false;
    }

    _emailController.sink.add('OK');
    if(!Validations.isValidPassword(password)) {
      _passController.sink.addError('Mật khẩu phải ít nhất 6 ký tự!');
      return false;
    }
    
    _passController.sink.add('OK');
    return true;
  }

  bool isValueEmail(String email) {
    if (!Validations.isValidEmpty(email)) {
      _emailController.sink.addError("Nhập Email");
      return false;
    }
    if(!Validations.isValidEmail(email)) {
      _emailController.sink.addError('Email không đúng định dạng!');
      return false;
    }
    _emailController.sink.add("OK");
    return true;
  }

  bool isValid(String name, String email, String pass, String confirm) {
    if (!Validations.isValidEmpty(name)) {
      _nameController.sink.addError("Nhập Họ và tên");
      return false;
    }
    _nameController.sink.add('OK');

    if (!Validations.isValidEmpty(email)) {
      _emailController.sink.addError("Nhập Email");
      return false;
    }
    if(!Validations.isValidEmail(email)) {
      _emailController.sink.addError('Email không đúng định dạng!');
      return false;
    }
    _emailController.sink.add("OK");

    if (!Validations.isValidPassword(pass)) {
      _passController.sink.addError("Mật khẩu phải trên 6 ký tự");
      return false;
    }
    _passController.sink.add("OK");

  if (!Validations.isValidPassword(confirm)) {
      _confirmController.sink.addError("Mật khẩu phải trên 6 ký tự");
      return false;
    }
  else if(confirm != pass) {
    _confirmController.sink.addError('Mật khẩu không trùng khớp!');
    return false;
  }
  else  
    _confirmController.sink.add("OK");
    return true;
  }

  void signUp(String email, String pass, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void signInFacebook() {
    //_firAuth.signInFacebook();
  }

  void signInGoogle() {
    _firAuth.signInWithGoogle();
  }

  void forgotPassword(String email, Function onSuccess, Function(String) onError) {
    _firAuth.forgotPassword(email, onSuccess, onError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _confirmController.close();
  }
}
