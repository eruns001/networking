import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/class/User.dart';
import 'page/CommunityPage.dart';
import 'page/EditProfilePage.dart';
import 'page/LogInPage.dart';
import 'page/LoginLayoutPage.dart';
import 'page/MyProfilePage.dart';
import 'page/SearchPage.dart';
import 'page/TeamConfigPage.dart';

//전역변수
int aa = 0;

void main() {
  if (aa == 0) {
    log("build test");
    aa++;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 네비게이션에 표시될 아이콘의 높이
  static const double ICON_HEIGHT = 30;

  /// 현재 표시 중인 페이지의 인덱스
  int _currentIndex = 0;

  User _user = new User();

  /// 네비게이션에 표시될 항목들
  List<BottomNavigationBarItem> _navigationList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Container(
        height: ICON_HEIGHT,
        child: Image.asset(
          'images/navigation_icon_searchUser.png',
          height: ICON_HEIGHT,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        height: ICON_HEIGHT,
        child: Image.asset(
          'images/navigation_icon_myPage.png',
          height: ICON_HEIGHT,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        height: ICON_HEIGHT,
        child: Image.asset(
          'images/navigation_icon_home.png',
          height: ICON_HEIGHT,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        height: ICON_HEIGHT,
        child: Image.asset(
          'images/navigation_icon_community.png',
          height: ICON_HEIGHT,
        ),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Container(
        height: ICON_HEIGHT,
        child: Image.asset(
          'images/navigation_icon_magazine.png',
          height: ICON_HEIGHT,
        ),
      ),
      label: '',
    ),
  ];

  /// 내비게이션을 터치했을 때 실행될 메서드
  _onTaped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// EditProfilePage 테스트용으로 만든 메서드
  _createUser() {
    _user.setProfileImage = Image.asset('images/appbar_btn_alarm.png');
    _user.setNickName = '바보';
    _user.setRate = 3.5;
    _user.setName = '장주환';
    _user.setPhoneNum = '010-1234-5678';
    _user.setEmail = 'example@gmail.com';
    _user.setMajor = 'null';
    _user.setCareer = '5';
    _user.setPosition = '청소부';
    _user.setAddressCi = '부산';
    _user.setAddressGoon = '금정구';
  }

  @override
  Widget build(BuildContext context) {
    _createUser();

    /// 페이지들
    List<Widget> _pageList = <Widget>[
      SearchPage(),
      MyProfilePage(user: _user),
      LogInPage(), // 임시
      // EditProfilePage(user: _user), // 임시
      // HomePage(),
      CommunityPage(),
      LoginLayoutPage(), // 임시
      // MagazinePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: _navigationList,
          onTap: _onTaped,
        ),
      ),
      /*
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //btn_home
            IconButton(
              iconSize: 50,
              color: const Color(0xff46abdb),
              icon: new Image.asset('images/search_btn_home.png'),
              onPressed: () {
                _currentIndex = 0;
                setState(() {});
              },
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_insert_user.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LogInPage()),
                );
              },
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_search.png'),
              onPressed: () {
                /// 계정찾기 페이지 테스트용으로 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginLayoutPage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_mypage.png'),
              onPressed: () {
                /*
                /// 커뮤니티 페이지 테스트용으로 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CommunityPage();
                    },
                  ),
                );
                 */

                /// 팀 설정 페이지 테스트용으로 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TeamConfigPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
       */
    );
  }
}
