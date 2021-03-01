import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:networking/data/function.dart';
import 'package:networking/page/SignUpPage.dart';

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
        width: _device_width,
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
            /*
            ///로그인 버튼
            Container(
              margin: new EdgeInsets.only(bottom: _device_height * (2 / 100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_Login.png",
                  width: _device_width * (62.8 / 100),
                  height: _device_height * (6.2 / 100),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ///새계정 만들기 버튼
            Container(
              margin: new EdgeInsets.only(bottom: _device_height * (2 / 100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_NewAccount.png",
                  width: _device_width * (62.8 / 100),
                  height: _device_height * (6.2 / 100),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            */
            Container(
              //margin: new EdgeInsets.only(bottom: _device_height * (2 / 100)),
              child: SignInButton(
                Buttons.Google,
                onPressed: () async {
                  var booltemp = false;

                  /// 원본을 놔두고 따로 테스트해보기 위해서 플랫폼을 나누에서 진행
                  if (Platform.isIOS) {
                    /// 로딩화면용 context
                    /// 그냥 Navigator.pop(context) 를 사용하면 로딩화면이 사라지지 않아서
                    /// 이 방법으로 진행했습니다.
                    /// 출처 https://stackoverflow.com/questions/50683524/how-to-dismiss-flutter-dialog
                    BuildContext _dialogContext;

                    /// 로딩화면 출력
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        _dialogContext = context;
                        return AlertDialog(
                          content: CupertinoActivityIndicator(),
                        );
                      },
                    );

                    /// 구글 로그인 실행
                    bool _logInResult = await googleSingIn();

                    /// 로그인을 하지 않았을 경우를 대비한 구문
                    if(_logInResult != true) {
                      Navigator.pop(_dialogContext);
                      return;
                    }

                    /// 로그인 한 것을 바탕으로 유저 정보 불러옴
                    FirebaseUser _user =
                        await FirebaseAuth.instance.currentUser();
                    String _uid = _user.uid;

                    /// 해당 유저의 폴더가 존재하는지 판별할 변수
                    DocumentSnapshot _result;

                    /// 해당 유저의 폴더를 가져옴
                    await Firestore.instance
                        .collection('Account')
                        .document(_uid)
                        .get()
                        .then(
                      (DocumentSnapshot documentSnapshot) {
                        _result = documentSnapshot;
                        Navigator.pop(_dialogContext);
                      },
                    );

                    /// test 용 구문
                    log('${_result.data.length}');

                    /// 해당 유저의 폴더가 존재할 경우 가입을 했던 것으로 간주.
                    if (_result.exists) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                    }
                    /// 해당 유저의 폴더가 존재하지 않을 경우 가입을 하지 않은 것으로 간주.
                    /// 가입하는 페이지에 닫기 버튼이 있어서 로그인 화면을 남겨뒀습니다.
                    else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                    }
                  } else {
                    googleSingIn().whenComplete(
                      () async {
                        FirebaseUser user =
                            await FirebaseAuth.instance.currentUser();

                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        } else {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        }
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              margin: new EdgeInsets.only(bottom: _device_height * (10 / 100)),
              child: FlatButton(
                onPressed: null,
                child: Image.asset(
                  "images/loginpage_btn_FindAccount.png",
                  width: _device_width * (35.5 / 100),
                  height: _device_height * (2.2 / 100),
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
