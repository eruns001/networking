import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogInPage> {
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
              margin: new EdgeInsets.only(bottom: _device_height*(15/100)),
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