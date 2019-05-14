import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FirAuth {

//  static final FacebookLogin facebookSignIn = new FacebookLogin();
  static final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name,
      Function onSuccess, Function(String) onRegisterError) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.uid, name, onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignInErr(err.code, onSignInError);
    });
  }

  void forgotPassword(String email, Function onSuccess, Function(String) forgotPassword) {
    _fireBaseAuth
      .sendPasswordResetEmail(email: email)
      .then((_) {
        print('Đã gửi mail!');
        onSuccess(); 
      })
      .catchError((err) {
        print("err: " + err.toString());
        _forgotPasswordErr(err.code, forgotPassword);
    });
  }

  void signInWithGoogle(Function onSuccess, Function(String) onLoginSocialError)  async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

    final FirebaseUser user = await _fireBaseAuth
      .signInWithCredential(credential);
    if(user!=null) {
      onSuccess();
    }
    print("signed in " + user.displayName);
  }

  void signOutWithGoogle() async {
    await _fireBaseAuth
      .signOut()
      .then((_) {
        googleSignIn.signOut();
        print('Sign out!');
    });
  }


  /*final FacebookLogin loginFacebook = new FacebookLogin();
  void signInFacebook() async {
   final FacebookLoginResult facebookLoginResult = await loginFacebook.logInWithReadPermissions(['email']);
   /*final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: facebookLoginResult.accessToken.token
    ); 
     final FirebaseUser user = await _fireBaseAuth.signInWithCredential(credential);
     print("signed in " + user.displayName); */
  } 
  */
  

  _createUser(String userId, String name, Function onSuccess,
      Function(String) onRegisterError) {
    var user = Map<String, String>();
    user["name"] = name;
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((vl) {
      print("Thêm dữ liệu thành công!");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    }).whenComplete(() {
      print("Xong!");
    });
  }

  ///

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Email không hợp lệ!");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email đã tồn tại trên hệ thống!");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("Mật khẩu quá yếu!");
        break;
      default:
        onRegisterError("Đăng ký thất bại!");
        break;
    }
  }

  void _onSignInErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_TOO_MANY_REQUESTS":
        onRegisterError("Bạn nhập sai mật khẩu quá nhiều lần\n Vui lòng thử lại sau!");
        break;
      case "ERROR_USER_NOT_FOUND":
        onRegisterError("Email không tồn tại trên hệ thống!");
        break;  
      case "ERROR_WRONG_PASSWORD":
        onRegisterError("Mật khẩu không chính xác!");
        break;
      default:
        onRegisterError("Đăng nhập thất bại!");
        break;
    }
  }
  void _forgotPasswordErr(String code, Function(String) forgotPasswordErr) {
    print(code);
    switch (code) {
      case "ERROR_USER_NOT_FOUND":
        forgotPasswordErr("Email không tồn tại trên hệ thống!");
        break;
      case "ERROR_INVALID_EMAIL":
        forgotPasswordErr("Email không hợp lệ!");
        break;  
      default:
        forgotPasswordErr("Đăng ký thất bại!");
        break;
    }
  }
  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}
