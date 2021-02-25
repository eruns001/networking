import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NewPwPage.dart';

/// 비밀번호 찾는 과정에서 이메일 인증하는 페이지

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    Key key,
    @required this.userName,
    //@required this.userId,
  }) : super(key: key);

  final String userName;

  //final String userId;

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _authenticationNumController =
      new TextEditingController();

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(_deviceWidth * 0.141, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                /// 인증번호
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.146, 0, 0),
                child: Text(
                  '인증번호',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                /// 안내 문구 1
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
                child: Text(
                  '가입 시 기입하였던 이메일로 인증번호를\n발송하였습니다.',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              Container(
                /// 안내 문구 2
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.06, 0, 0),
                child: Text(
                  '인증번호를 입력해주세요.',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              Container(
                /// 인증번호 입력
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
                height: _deviceHeight * 0.08,
                width: _deviceWidth * 0.725,
                child: TextField(
                  controller: _authenticationNumController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: '인증번호',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        EdgeInsets.fromLTRB(_deviceWidth * 0.05, 0, 0, 0),
                  ),
                ),
              ),
              Container(
                /// 인증번호 재발송 버튼
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.05, 0, 0),
                height: _deviceHeight * 0.08,
                width: _deviceWidth * 0.725,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 67, 164, 210),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '인증번호 재발송',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 앱바 빌드 메서드
  Widget _buildAppBarTitle(double _deviceHeight, double _deviceWidth) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(_deviceWidth * 0.03, 0, 0, 0),
            width: _deviceWidth * 0.045,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/authentication_btn_close.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            height: _deviceHeight * 0.019,
            width: _deviceWidth * 0.083,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/authentication_btn_next.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NewPwPage();
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
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: null,
        automaticallyImplyLeading: false,
        toolbarHeight: _deviceHeight * 0.075,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: null,
          child: Container(
            height: 0.5,
            color: Color.fromARGB(255, 67, 164, 210),
          ),
        ),
        title: _buildAppBarTitle(_deviceHeight, _deviceWidth),
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}
