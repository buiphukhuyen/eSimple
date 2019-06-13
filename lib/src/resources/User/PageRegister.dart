import 'package:english_app/src/blocs/Auth_Bloc.dart';
import 'package:english_app/src/resources/User/PageLogin.dart';
import 'package:english_app/src/resources/dialog/Loading_Dialog.dart';
import 'package:english_app/src/resources/dialog/Massage_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageRegister extends StatefulWidget {
  @override
  _PageRegisterState createState() => new _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _confirmPassController = new TextEditingController();

  AuthBloc bloc = new AuthBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  bool _showPass = false;
  bool _showConfirmPass = false;

  bool _autoValidate = false;
  double height = 450;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true, //Wait
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff3277D8)),
          elevation: 0,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .end, //Căn chỉnh trục, các text nằm từ phải sang
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0.0, right: 10.0),
                  child: Image.asset(
                    "assets/images/Banner_Top_Register.png",
                    gaplessPlayback: true,
                    width: ScreenUtil.getInstance().setWidth(680),
                    height: ScreenUtil.getInstance().setHeight(500),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                //Image.asset("assets/images/Banner_Bot.png")
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/LogoApp.png",
                      width: ScreenUtil.getInstance().setWidth(80),
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    Text("Simple",
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontFamily: "SVN-Poky's", //Style
                          fontSize: ScreenUtil.getInstance().setSp(46), //Font
                          letterSpacing: .10, //Spacing Text
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
                      height: ScreenUtil.getInstance().setHeight(180),
                    ),

                    //Form Register
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
                          autovalidate: _autoValidate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Đăng ký",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(45),
                                      fontFamily: "SFUIText-Bold",
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              StreamBuilder(
                                stream: bloc.nameStream,
                                builder: (context, snapshot) => TextField(
                                      style: TextStyle(
                                          fontSize: 17.5, color: Colors.black),
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                          labelText: "Họ và tên",
                                          prefixIcon: Icon(Icons.account_box),
                                          errorText: snapshot.hasError
                                              ? snapshot.error
                                              : null,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffCED0D2),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)))),
                                      keyboardType: TextInputType.text,
                                    ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              StreamBuilder(
                                stream: bloc.emailStream,
                                builder: (context, snapshot) => TextField(
                                      style: TextStyle(
                                          fontSize: 17.5, color: Colors.black),
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          labelText: "Địa chỉ Email",
                                          errorText: snapshot.hasError
                                              ? snapshot.error
                                              : null,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffCED0D2),
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                          )),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              StreamBuilder(
                                stream: bloc.passStream,
                                builder: (context, snapshot) => TextField(
                                      controller: _passController,
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          color: Colors.black87),
                                      obscureText:
                                          !_showPass, //Security password
                                      decoration: InputDecoration(
                                          labelText: "Mật khẩu",
                                          errorText: snapshot.hasError
                                              ? snapshot.error
                                              : null,
                                          prefixIcon: Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          suffixIcon: GestureDetector(
                                              onTap: onToggleShowPass,
                                              child: Icon(_showPass
                                                  ? Icons.visibility
                                                  : Icons.visibility_off))),
                                    ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              StreamBuilder(
                                stream: bloc.confirmStream,
                                builder: (context, snapshot) => TextField(
                                      style: TextStyle(
                                          fontSize: 17.5, color: Colors.black),
                                      controller: _confirmPassController,
                                      obscureText:
                                          !_showConfirmPass, //Security password
                                      decoration: InputDecoration(
                                          labelText: "Xác thực Mật khẩu",
                                          errorText: snapshot.hasError
                                              ? snapshot.error
                                              : null,
                                          prefixIcon: Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          suffixIcon: GestureDetector(
                                              onTap: onToggleShowConfirmPass,
                                              child: Icon(_showConfirmPass
                                                  ? Icons.visibility
                                                  : Icons.visibility_off))),
                                    ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                      "Đăng ký",
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
                        Text(
                          "Đã có Tài khoản? ",
                          style: TextStyle(
                              fontFamily: "SFUIText-Bold", fontSize: 16.0),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Đăng nhập",
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
      _showPass = !_showPass;
    });
  }

  void onToggleShowConfirmPass() {
    setState(() {
      _showConfirmPass = !_showConfirmPass;
    });
  }

  void _submitLogin() async {
    var isValid = bloc.isValid(_nameController.text, _emailController.text,
        _passController.text, _confirmPassController.text);
    print('$isValid');
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      bloc.signUp(
          _emailController.text, _passController.text, _nameController.text,
          () {
        LoadingDialog.hideLoadingDialog(context);
        MassageDialog.showMessageDialog(context, "Đăng ký",
            'Đăng ký thành công!\n Vui lòng đăng nhập hệ thống!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PageLogin()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MassageDialog.showMessageDialog(context, "Đăng ký", msg);
      });
    }
  }
}
