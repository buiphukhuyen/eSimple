import 'package:english_app/src/blocs/Auth_Bloc.dart';
import 'package:english_app/src/resources/Homepage/HomePage.dart';
import 'package:english_app/src/resources/dialog/Loading_Dialog.dart';
import 'package:english_app/src/resources/dialog/Massage_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_app/src/resources/User/PageRegister.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => new _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = new TextEditingController();

  AuthBloc bloc = new AuthBloc();

  bool _isSelected = false;

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
                    "assets/images/Banner_Top_ForgotPassword.png",
                    gaplessPlayback: true,
                    width: ScreenUtil.getInstance().setWidth(680),
                    height: ScreenUtil.getInstance().setHeight(500),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset("assets/images/Banner_Bot.png")
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 0.0),
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
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
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
                              Text("Khôi phục Mật khẩu",
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
                                height: ScreenUtil.getInstance().setHeight(35),
                              ),
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
                            Text("Xác nhận khôi phục",
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
                                    onTap: _submitLogin,
                                    child: Center(
                                        child: Text(
                                      "Khôi phục",
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
                        Text("LƯU Ý",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "SFUIText-Bold")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),

                    Text(
                      '1. Bạn chỉ có thể Khôi phục Mật khẩu nếu Địa chỉ Email tồn tại trên hệ thống.',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(10),
                    ),
                    Text(
                      '2. Kiểm tra lại Email và Xác nhận Đường dẫn để tiến hành thay đổi Mật khẩu.',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(70),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Chưa có tài khoản? ",
                          style: TextStyle(
                              fontFamily: "SFUIText-Bold", fontSize: 18.0),
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
                                  fontSize: 19.0),
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

  void _submitLogin() async {
    if (bloc.isValueEmail(_emailController.text)) {
      LoadingDialog.showLoadingDialog(context, 'Đang Xử lý');
      bloc.forgotPassword(_emailController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MassageDialog.showMessageDialog(context, 'Khôi phục mật khẩu', msg);
      });
    }
  }
}
