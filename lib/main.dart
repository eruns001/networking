import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/widget/NetworkingDrawer.dart';

import 'data/class/Member.dart';
import 'data/class/Team.dart';
import 'data/class/User.dart';
import 'page/CommunityPage.dart';
import 'page/LogInPage.dart';
import 'page/LoginLayoutPage.dart';
import 'page/MyProfilePage.dart';
import 'page/SearchPage.dart';

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

  /// 임시로 팀을 생성하는 메서드
  Team _createTeam() {
    Team _team = new Team();
    _team.teamName = '이것은 이름';
    _team.subject = '이것은 주제';
    _team.anniversary = DateTime(2021, 02, 26, 19, 00);
    _team.planning = [
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
    ];
    _team.design = [
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
    ];
    _team.marketing = [
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
    ];
    _team.development = [
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
      Member(
        name: '멤버',
        phoneNum: '01012345678',
        position: '청소부',
        email: 'example@gamil.com',
      ),
    ];

    return _team;
  }

  /// EditProfilePage 테스트용으로 만든 메서드
  _createUser() {
    _user.setProfileImage = Image.asset('images/appbar_btn_alarm.png');
    _user.setNickName = '바보';
    _user.setRate = 3.5;
    _user.setName = '장주환';
    _user.setPhoneNum = '01012345678';
    _user.setEmail = 'example@gmail.com';
    _user.setMajor = 'null';
    _user.setCareer = '5';
    _user.setPosition = '청소부';
    _user.setAddress = '부산광역시';

    /// 팀 테스트 구문
    _user.setIsJoinedTeam = true;
    _user.setIsMaster = false;
    _user.setTeam = _createTeam();
  }

  @override
  Widget build(BuildContext context) {
    /// 테스트용
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
      drawer: NetworkingDrawer(context: context),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: _navigationList,
          onTap: _onTaped,
        ),
      ),
    );
  }
}
