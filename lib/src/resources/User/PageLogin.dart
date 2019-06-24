import 'package:english_app/src/blocs/Auth_Bloc.dart';
import 'package:english_app/src/resources/User/ForgotPassword.dart';
import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/dialog/Loading_Dialog.dart';
import 'package:english_app/src/resources/dialog/Massage_Dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_app/src/resources/User/PageRegister.dart';
import 'package:english_app/src/resources/widgets/SocialIcon.dart';
import 'package:english_app/src/resources/widgets/customIcon.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => new _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  AuthBloc bloc = new AuthBloc();

  bool _isSelected = false;

  bool _showpass = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(120),
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      ));

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true, //Wait
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .end, //Căn chỉnh trục, các text nằm từ phải sang
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/images/Banner_Top_LoginSocial.png",
                      gaplessPlayback: true),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset("assets/images/Banner_Bot.png")
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/LogoApp.png",
                      width: ScreenUtil.getInstance().setWidth(80),
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    Text("Simple",
                        style: TextStyle(
                          color: Colors.blue[500],
                          fontFamily: "SVN-Poky's", //Style
                          fontSize: ScreenUtil.getInstance().setSp(46), //Font
                          letterSpacing: .10,
                        ))
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 100.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(230),
                    ),
                    //Form Dang nhap
                    Container(
                      margin: EdgeInsets.all(1.0),
                      padding: EdgeInsets.only(bottom: 9.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 20.0)
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Đăng nhập",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(45),
                                      fontFamily: "SFUIText-Bold",
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                              StreamBuilder(
                                stream: bloc.emailStream,
                                builder: (context, snapshot) => TextField(
                                      onChanged: bloc.changeEmail,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: "Địa chỉ Email",
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        prefixIcon: snapshot.hasError
                                            ? Icon(
                                                Icons.email,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffCED0D2),
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              SizedBox(
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: <Widget>[
                                    StreamBuilder(
                                      stream: bloc.passStream,
                                      builder: (context, snapshot) => TextField(
                                            obscureText:
                                                !_showpass, //Security password
                                            controller: _passController,

                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                                labelText: "Mật khẩu",
                                                errorText: snapshot.hasError
                                                    ? snapshot.error
                                                    : null,
                                                prefixIcon: snapshot.hasError
                                                    ? Icon(
                                                        Icons.lock,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(Icons.lock),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xffCED0D2),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                ),
                                                suffixIcon: GestureDetector(
                                                    onTap: onToggleShowPass,
                                                    child: Icon(_showpass
                                                        ? Icons.visibility
                                                        : Icons
                                                            .visibility_off))),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(35),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassword()));
                                      },
                                      child: Text(
                                        "Quên mật khẩu",
                                        style: TextStyle(
                                            fontSize: ScreenUtil.getInstance()
                                                .setSp(32),
                                            color: Colors.blue,
                                            fontFamily: "SFUIText-Bold"),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text("Ghi nhớ Đăng nhập",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "SFUIText-Medium"))
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(80),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      _submitLogin();
                                    },
                                    child: Center(
                                        child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "SFUIText-Bold",
                                          fontSize: 18.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold),
                                    )))),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Mạng xã hội",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "SFUIText-Bold")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8),
                          ],
                          iconData: CustomIcons.facebook,
                          onPressed: _loginFacebook,
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconData: CustomIcons.googlePlus,
                          onPressed: _loginGoogle,
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea),
                          ],
                          iconData: CustomIcons.twitter,
                          onPressed: _loginTwitter,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Chưa có tài khoản? ",
                          style: TextStyle(
                              fontFamily: "SFUIText-Bold", fontSize: 16.0),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageRegister()));
                            },
                            child: Text(
                              "Đăng ký",
                              style: TextStyle(
                                  fontFamily: "SFUIText-Bold",
                                  color: Colors.blue[700],
                                  fontSize: 17.0),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void onToggleShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }

  void _submitLogin() async {
    if (bloc.isValueInfo(_emailController.text, _passController.text)) {
      LoadingDialog.showLoadingDialog(context, 'Đang Đăng nhập');
      // print('${_emailController.text} , ${_passController.text}');
      bloc.signIn(_emailController.text, _passController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MassageDialog.showMessageDialog(context, 'Đăng nhập', msg);
      });

      /*try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text);
        print("User ${user.uid}");
        if(user!=null) {
          LoadingDialog.hideLoadingDialog(context);
          showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  content: new Text('Đăng nhập thành công!'),
                )); 
        }
      }
      catch(e)
      {
        print("$e");
        LoadingDialog.hideLoadingDialog(context);
        //Massage_Dialog.showMessageDialog(context, 'Đăng nhập', e);
        showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  content: new Text('Đăng nhập thất bại!'),
                )); */
    }
  }

  void _loginGoogle() async {
    // print('${_emailController.text} , ${_passController.text}');
    bloc.signInGoogle(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      MassageDialog.showMessageDialog(context, 'Đăng nhập', msg);
    });
  }

  void _loginFacebook() async {
    // print('${_emailController.text} , ${_passController.text}');
    bloc.signInFacebook(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg) {
      MassageDialog.showMessageDialog(context, 'Đăng nhập', msg);
    });
  }

  void _loginTwitter() async {
    MassageDialog.showMessageDialog(
        context, 'Đăng nhập', "Tính năng đang phát triển");
  }
}
