import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/data.dart';
import 'package:networking/page/SearchPage.dart';
import 'package:networking/page/UploadQuestionPage.dart';

// ignore: non_constant_identifier_names
AppBar NetworkingAppBar({
  @required BuildContext context,
  @required double deviceHeight,
  @required double deviceWidth,
  @required String title,
  @required int stackIndex,
  Function onPressedBurger,
  Function onPressedAlarm,
  Widget rightButtonIcon,
  Widget leftButton,
}) {

  rightButtonIcon = rightButtonIcon != null ?
  rightButtonIcon :
  CupertinoButton(
    padding: EdgeInsets.zero,
    child: Image.asset('images/appbar_btn_alarm.png'),
    onPressed: onPressedAlarm,
  );

  leftButton = leftButton != null ?
  leftButton :
  IconButton(
      padding: EdgeInsets.only(left: 30, right: 25),
      icon: Icon(
        CupertinoIcons.bars,
        color: const Color(0xff46abdb),
        size: 50,
      ),
      onPressed: (){
        Scaffold.of(context).openDrawer();
      }
  );

  ///searchPage일 경우 Appbar
  if(stackIndex == 0){
    return AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        titleSpacing: -5,
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 500,
          child: Row(
            children: <Widget>[
              ///선 세개
              IconButton(
                  padding: EdgeInsets.only(left: 30, right: 25),
                  icon: Icon(
                    CupertinoIcons.bars,
                    color: const Color(0xff46abdb),
                    size: 50,
                  ),
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }
              ),
              ///검색창
              new Flexible(
                child: TextFormField(
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                    hintText: '$searchPageCounter', //'검색어를 입력해 주세요.',
                    hintStyle: TextStyle(
                      color: const Color(0xffa2d5ed),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: const Color(0xff46abdb))),
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      color: const Color(0xff46abdb),
                      size: 30,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xffa2d5ed),
                  ),
                  onFieldSubmitted: null,
                ),
              ),
              ///새글
              IconButton(
                  padding: EdgeInsets.only(left: deviceWidth * 0.02, right: deviceWidth * 0.05),
                  icon: Icon(
                    CupertinoIcons.doc,
                    color: const Color(0xff46abdb),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadQuestionPage()),
                    );
                  }),
            ],
          ),
        ));
  }
  else{
    return AppBar(
      brightness: Brightness.light,
      centerTitle: true,
      titleSpacing: -5,
      backgroundColor: Colors.white.withOpacity(0.0),
      elevation: 0,
      automaticallyImplyLeading: false,
      /*
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0.0,
      leading: null,
      automaticallyImplyLeading: false,
      toolbarHeight: deviceHeight * 0.073,
      centerTitle: true,
      titleSpacing: 0,
      */
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leftButton,
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: const Color(0xff46abdb),
                ),
              ),
            ),
          ),
          Container(
            /*EdgeInsets.fromLTRB(
                deviceWidth * 0.02, 0, deviceWidth * 0.111, 0),
             */
            height: deviceHeight * 0.041,
            width: deviceWidth * 0.15,
            child: rightButtonIcon
          ),
        ],
      ),
    );
  }
}
