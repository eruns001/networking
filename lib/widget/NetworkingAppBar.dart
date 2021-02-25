import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar NetworkingAppBar({
  @required double deviceHeight,
  @required double deviceWidth,
  @required String title,
  Function onPressedBurger,
  Function onPressedAlarm,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    elevation: 0.0,
    leading: null,
    automaticallyImplyLeading: false,
    toolbarHeight: deviceHeight * 0.073,
    centerTitle: true,
    titleSpacing: 0,
    title: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(deviceWidth * 0.105, 0, 0, 0),
          height: deviceHeight * 0.041,
          width: deviceWidth * 0.101,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset('images/appbar_btn_menu.png'),
            onPressed: onPressedBurger,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.02, 0, deviceWidth * 0.111, 0),
          height: deviceHeight * 0.041,
          width: deviceWidth * 0.075,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset('images/appbar_btn_alarm.png'),
            onPressed: onPressedAlarm,
          ),
        ),
      ],
    ),
  );
}
