
import 'dart:async';
import 'package:english_app/src/validators/Validations.dart';

class Login_Bloc {
  StreamController _emailcontroller = new StreamController();
  StreamController _passcontroller = new StreamController();

  Stream get emailStream => _emailcontroller.stream;
  Stream get passStream => _passcontroller.stream;

  bool isValueInfo(String username, String password) {
    if(!Validations.isValidEmail(username)) {
      _emailcontroller.sink.addError('Email không đúng định dạng!');
      return false;
    }
    _emailcontroller.sink.add('OK');
    if(!Validations.isValidPassword(password)) {
      _passcontroller.sink.addError('Mật khẩu phải ít nhất 6 ký tự!');
      return false;
    }
    
    _passcontroller.sink.add('OK');
    return true;
  }

  void dispose() {
    _emailcontroller.close();
    _passcontroller.close();
  }

}