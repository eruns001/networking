import 'package:flutter/material.dart';
import 'package:networking/data/function.dart';
import 'package:networking/main.dart';

class SinginTaskPage extends StatefulWidget {
  @override
  SigninTask createState() => SigninTask();
}

class SigninTask extends State<SinginTaskPage> {

  @override
  Widget build(BuildContext context) {

    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Image.asset(
                "images/loginpage_btn_Login.png",
                width: _device_width * (62.8/100),
                height: _device_height * (6.2/100),
                fit: BoxFit.contain,
              ),
              onPressed: () => WithdrawalUser().then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                        (Route<dynamic> route) => false);
              }),
            )
          ],
        ),
      )
    );
  }
}