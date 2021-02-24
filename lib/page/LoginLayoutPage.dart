import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FindIdPwPage.dart';
import 'SignUpPage.dart';


class LoginLayoutPage extends StatefulWidget {
  const LoginLayoutPage({Key key}) : super(key: key);

  @override
  _LoginLayoutPageState createState() => _LoginLayoutPageState();
}

class _LoginLayoutPageState extends State<LoginLayoutPage> {
  /// 페이지 내용 빌드 메서드
  Widget _buildPage() {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            /// 로고
            width: _deviceWidth * 0.571,
            child: Image.asset('images/loginLayout_logo.png'),
          ),
          Container(
            /// 로그인 버튼
            margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.114, 0, 0),
            height: _deviceHeight * 0.062,
            width: _deviceWidth * 0.728,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 67, 164, 210),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {},
            ),
          ),
          Container(
            /// 새 계정 만들기 버튼
            margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
            height: _deviceHeight * 0.062,
            width: _deviceWidth * 0.728,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromARGB(255, 67, 164, 210),
              ),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '새 계정 만들기',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SignUpPage();
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            /// 계정 찾기 버튼
            margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                '계정을 잊으셨나요?',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 67, 164, 210),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return FindIdPwPage();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
    );
  }
}
