import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                Container(
                  width: _deviceWidth * 0.3,
                  child: Image.asset('images/loginLayout_logo.png'),
                ),
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
        ],
      ),
    ),
  );
}
