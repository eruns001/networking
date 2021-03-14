import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/data.dart';
import 'package:networking/data/function.dart';

import '../main.dart';

// ignore: non_constant_identifier_names
Drawer NetworkingDrawer({
  @required BuildContext context,
}) {
  final double _deviceHeight = MediaQuery.of(context).size.height;
  final double _deviceWidth = MediaQuery.of(context).size.width;

  return Drawer(
    child: Container(
      margin: EdgeInsets.only(
          right: _deviceWidth * 0.055, left: _deviceWidth * 0.055),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// 로고 및 메뉴 아이콘
          AppBar(
            leading: null,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
            elevation: 0,
            titleSpacing: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// 로고
                Container(
                  width: _deviceWidth * 0.3,
                  child: Image.asset('images/loginLayout_logo.png'),
                ),

                /*
                /// 메뉴 아이콘
                Container(
                  height: _deviceHeight * 0.041,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Image.asset('images/appbar_btn_menu.png'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                 */
              ],
            ),
          ),

          /// 분할선
          Divider(),

          /// 내 팀
          NetworkingDrawerMenu(
            deviceHeight: _deviceHeight,
            deviceWidth: _deviceWidth,
            title: '내 팀',
            imageDirectory: Image.asset('images/drawer_icon_myTeam.png'),
            onPressed: () {},
          ),

          /// 분할선
          Divider(),

          /// 알림
          NetworkingDrawerMenu(
            deviceHeight: _deviceHeight,
            deviceWidth: _deviceWidth,
            title: '알림',
            imageDirectory: Icon(
              Icons.add_alert,
              color: const Color(0xff5d9023),
              size: 30,
            ),
            onPressed: () {},
          ),

          /// 공지사항
          NetworkingDrawerMenu(
            deviceHeight: _deviceHeight,
            deviceWidth: _deviceWidth,
            title: '공지사항',
            imageDirectory: Image.asset('images/drawer_icon_notice.png'),
            onPressed: () {},
          ),

          /// 분할선
          Divider(),

          /// 설정
          NetworkingDrawerMenu(
            deviceHeight: _deviceHeight,
            deviceWidth: _deviceWidth,
            title: '설정',
            imageDirectory: Image.asset('images/drawer_icon_setting.png'),
            onPressed: () {},
          ),

          /// 고객센터
          NetworkingDrawerMenu(
            deviceHeight: _deviceHeight,
            deviceWidth: _deviceWidth,
            title: '고객센터',
            imageDirectory: Image.asset('images/drawer_icon_service.png'),
            onPressed: () {},
          ),

          /// 분할선
          Divider(),

          /// TUNE IN 정보
          //NetworkingDrawerMenu(),

          /// 테스트용으로 넣은 로그아웃
          Container(
            height: 50,
            child: CupertinoButton(
              child: Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    gooleSignIn.signOut().whenComplete(
                      () {
                        FirebaseAuth.instance.signOut().whenComplete(
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );

                    return AlertDialog(
                      content: CupertinoActivityIndicator(),
                    );
                  },
                );
              },
            ),
          ),

          /// 분할선
          Divider(),

          /// 테스트용으로 넣은 회원탈퇴
          Container(
            height: 50,
            child: CupertinoButton(
              child: Text(
                '회원탈퇴',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                await WithdrawalUser();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class NetworkingDrawerMenu extends StatelessWidget {
  NetworkingDrawerMenu({
    Key key,
    @required double deviceHeight,
    @required double deviceWidth,
    @required Widget imageDirectory,
    @required String title,
    @required Function onPressed,
  })  : _deviceHeight = deviceHeight,
        _deviceWidth = deviceWidth,
        _imageDirectory = imageDirectory,
        _title = title,
        _onPressed = onPressed,
        super(key: key);

  final double _deviceHeight;
  final double _deviceWidth;
  final Widget _imageDirectory;
  final String _title;
  final Function _onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Container(
            height: _deviceWidth * 0.1,
            width: _deviceWidth * 0.1,
            child: (_imageDirectory == null) ? null : _imageDirectory,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(_deviceWidth * 0.025, 0, 0, 0),
            child: Text(
              _title,
              textScaleFactor: 0.82,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      onPressed: _onPressed,
    );
  }
}
