import 'package:english_app/src/blocs/Auth_Bloc.dart';
import 'package:english_app/src/resources/widgets/TopBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'PageLogin.dart';

class ProfileSetting extends StatelessWidget {
  AuthBloc bloc = new AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 160.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 4.0, color: Colors.white),
                              color: Colors.purple,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://scontent-hkg3-1.xx.fbcdn.net/v/t1.0-9/12341533_459361484264388_7894916608898433832_n.jpg?_nc_cat=103&_nc_oc=AQme9LkboGz8e7bdKl9J4IEXyGLg-VwTCRiWJ-M7UvyEPHa6UpESz4gwfz-FL9tJHtw&_nc_ht=scontent-hkg3-1.xx&oh=563b46dd16d935eb829c1a7910527269&oe=5D6AA9B1"))),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        StreamBuilder<FirebaseUser>(
                            stream: FirebaseAuth.instance.onAuthStateChanged,
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return Column(
                                  children: <Widget>[
                                    Text(
                                      '${snapshot.data.displayName}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'UID: ${snapshot.data.uid}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ],
                                );
                            })
                      ]),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(Icons.cached, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Cập nhật\nTài khoản',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(Icons.show_chart, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Tiến trình học',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(Icons.settings_backup_restore, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Thiết lập\nPhần mềm',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(Icons.phonelink_ring, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Liên hệ &\nHỗ trợ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(Icons.lightbulb_outline, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Góp ý',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(Icons.help_outline, size: 30.0),
                            SizedBox(height: 5.0),
                            Text(
                              'Hướng dẫn\nTrợ giúp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SFUIText-Medium",
                                  fontSize: 15.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: InkWell(
                  child: Container(
                    width: 200.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFFF5252), Color(0xFFD50000)]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFFFEBEE).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              bloc.signOut();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PageLogin()));
                            },
                            child: Center(
                                child: Text(
                              "Đăng xuất",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFUIText-Bold",
                                  fontSize: 18.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold),
                            )))),
                  ),
                ),
              )
            ],
          ),
        ),
        TopBar('THÔNG TIN TÀI KHOẢN')
      ]),
    );
  }
}
