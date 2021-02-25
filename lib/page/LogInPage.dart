import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:networking/data/function.dart';
import 'package:networking/page/SignUpPage.dart';
import 'package:networking/page/SigninTaskPage.dart';

import '../main.dart';

///로그인화면

class LogInPage extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogInPage> {

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: _device_height,
        width:  _device_width,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/loginpage_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: new EdgeInsets.only(bottom: _device_height*(2/100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_Login.png",
                  width: _device_width * (62.8/100),
                  height: _device_height * (6.2/100),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(bottom: _device_height*(2/100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_NewAccount.png",
                  width: _device_width * (62.8/100),
                  height: _device_height * (6.2/100),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(bottom: _device_height*(2/100)),
              child: SignInButton(
                Buttons.Google,
                onPressed: () async{
                  var booltemp = false;
                  googleSingIn().whenComplete(() async {
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    if(user != null)
                      {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
                      }
                    else{
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
                    }
                  });
                },
              ),
            ),
            Container(
              margin: new EdgeInsets.only(bottom: _device_height*(10/100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_FindAccount.png",
                  width: _device_width * (35.5/100),
                  height: _device_height * (2.2/100),
                  fit: BoxFit.contain,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
