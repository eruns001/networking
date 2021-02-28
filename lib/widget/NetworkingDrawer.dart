import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/data.dart';

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
              ],
            ),
          ),

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
                await showDialog(
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
        ],
      ),
    ),
  );
}
