import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/class/Team.dart';
import 'package:networking/data/class/User.dart';
import 'package:networking/data/data.dart';
import 'package:networking/page/MyTeamMemberVer.dart';
import 'package:networking/page/TeamConfigPage.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';

import 'EditProfilePage.dart';
import 'MyTeamAdminVer.dart';

/// 네비게이션에서 MY 누를 경우 나오는 화면
class MyProfilePage extends StatefulWidget {
  MyProfilePage({
    Key key,
    @required User user,
  })  : _user = user,
        super(key: key);

  final User _user;

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return Container(
      child: Scrollbar(
        child: ListView(
          controller: PrimaryScrollController.of(context),
          padding: EdgeInsets.all(_deviceWidth * 0.052),
          children: <Widget>[
            /// 프로필 사진 및 닉네임, 별점, 프로필 수정 버튼
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// 프로필 사진
                Container(
                  height: _deviceWidth * 0.373,
                  width: _deviceWidth * 0.373,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: widget._user.getProfileImage,
                ),

                /// 닉네임 표시, 프로필 수정버튼, 별점
                Container(
                  margin: EdgeInsets.fromLTRB(_deviceWidth * 0.036, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: _deviceHeight * 0.04,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: _deviceHeight * 0.04,
                              width: _deviceWidth * 0.15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Text(widget._user.getNickName),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  _deviceWidth * 0.02, 0, 0, 0),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                child: Text('프로필 수정'),
                                onPressed: () async {
                                  /// 변동사항이 있는지 isChanged 변수를 통해 확인
                                  bool isChanged = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return EditProfilePage(
                                            user: widget._user);
                                      },
                                    ),
                                  );

                                  /// 변동사항이 있을 경우 알림을 표시
                                  if (isChanged) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("정보가 저장되었습니다."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );

                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(0, _deviceHeight * 0.024, 0, 0),
                        height: _deviceHeight * 0.042,
                        width: _deviceWidth * (0.088 * 5),
                        child: Row(
                          children: List.generate(
                            5,
                            (int index) {
                              return Container(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: _deviceWidth * 0.088,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// 이름
            MyProfileInfo(title: '이름', content: widget._user.getName),

            /// 연락처
            MyProfileInfo(title: '연락처', content: widget._user.getPhoneNum),

            /// 주소
            MyProfileInfo(title: '주소', content: widget._user.getAddress),

            /// 이메일
            MyProfileInfo(title: '이메일', content: widget._user.getEmail),

            /// 경력
            MyProfileInfo(title: '경력', content: widget._user.getCareer + '년'),

            /// 분야
            MyProfileInfo(title: '분야', content: widget._user.getMajor),

            /// 역할
            MyProfileInfo(title: '역할', content: widget._user.getPosition),

            /// 포트폴리오
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.05, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '포트폴리오',
                    textScaleFactor: 0.82,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// 열기 버튼
                  Container(
                    margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
                    height: _deviceHeight * 0.04,
                    width: _deviceWidth * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Text('열기'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            /// 팀 프로필
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
              alignment: Alignment.centerRight,
              height: _deviceHeight * 0.04,
              width: _deviceWidth * 0.2,
              child: Container(
                alignment: Alignment.centerRight,
                height: _deviceHeight * 0.04,
                width: _deviceWidth * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text('팀 프로필'),
                  onPressed: () async {
                    /// 서버에서 속한 팀이 있는지 다시 데이터를 불러오는 작업 필요.

                    if (widget._user.getIsJoinedTeam) {
                      /// 속한 팀이 있을 경우

                      if (widget._user.getIsMaster) {
                        /// 그 팀의 개설자일 경우
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MyTeamAdminVer(team: widget._user.getTeam);
                            },
                          ),
                        );
                      } else {
                        /// 그 팀의 개설자가 아닐 경우
                        bool getOut = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MyTeamMemberVer(
                                  team: widget._user.getTeam);
                            },
                          ),
                        );

                        /// 유저가 팀에서 나가기를 선택했을 경우 실행
                        if (getOut) {
                          widget._user.setIsJoinedTeam = false;
                          widget._user.setIsMaster = false;
                          widget._user.setTeam = new Team();

                          /// 이 정보를 서버에 전송하는 과정 필요.
                        }
                      }
                    } else {
                      /// 속한 팀이 없을 경우

                      /// 팀을 만들 것인지 물어보는 Dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('알림'),
                            content: Text('현재 속한 팀이 없습니다.\n새로 팀을 만드시겠습니까?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('예'),
                                onPressed: () async {
                                  /// Dialog 지우기
                                  Navigator.of(context).pop();

                                  /// 팀 생성 페이지로 연결
                                  Team _team = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return TeamConfigPage();
                                      },
                                    ),
                                  );

                                  if (_team != null) {
                                    widget._user.setTeam = _team;
                                    widget._user.setIsJoinedTeam = true;
                                    widget._user.setIsMaster = true;

                                    setState(() {});
                                  }
                                },
                              ),
                              FlatButton(
                                child: Text('아니오'),
                                onPressed: () {
                                  /// Dialog 지우기
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            /// 한줄평 추가 필요
          ],
        ),
      ),
    );
  }

  Widget profilebuild(double _deviceHeight, double _deviceWidth){
    return FutureBuilder(
      future: Firestore.instance.collection('Account').document(uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

        Map<String, dynamic> data = snapshot.data.data;
        return ListView(
          controller: PrimaryScrollController.of(context),
          padding: EdgeInsets.all(_deviceWidth * 0.052),
          children: <Widget>[
            /// 프로필 사진 및 닉네임, 별점, 프로필 수정 버튼
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// 프로필 사진
                Container(
                  height: _deviceWidth * 0.373,
                  width: _deviceWidth * 0.373,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: widget._user.getProfileImage,
                ),

                /// 닉네임 표시, 프로필 수정버튼, 별점
                Container(
                  margin: EdgeInsets.fromLTRB(_deviceWidth * 0.036, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: _deviceHeight * 0.04,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: _deviceHeight * 0.04,
                              width: _deviceWidth * 0.15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Text(data["nickName"]),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  _deviceWidth * 0.02, 0, 0, 0),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                child: Text('프로필 수정'),
                                onPressed: () async {
                                  /// 변동사항이 있는지 isChanged 변수를 통해 확인
                                  /// 프로필 수정 있다 건드리기
                                  bool isChanged = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return EditProfilePage(
                                            user: widget._user);
                                      },
                                    ),
                                  );

                                  /// 변동사항이 있을 경우 알림을 표시
                                  if (isChanged) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("정보가 저장되었습니다."),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );

                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.fromLTRB(0, _deviceHeight * 0.024, 0, 0),
                        height: _deviceHeight * 0.042,
                        width: _deviceWidth * (0.088 * 5),
                        child: Row(
                          children: List.generate(
                            5,
                                (int index) {
                              return Container(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: _deviceWidth * 0.088,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// 이름
            MyProfileInfo(title: '이름', content: data["name"]),

            /// 연락처
            MyProfileInfo(title: '연락처', content: data["nickName"]),

            /// 주소
            MyProfileInfo(title: '주소', content: data["address"]),

            /// 이메일
            MyProfileInfo(title: '이메일', content: data["e_mail"]),

            /// 경력
            MyProfileInfo(title: '경력', content: data["career"] + '년'),

            /// 역할
            MyProfileInfo(title: '역할', content: data["roll"]),

            /// 분야
            MyProfileInfo(title: '분야', content: data["position"]),

            /// 포트폴리오
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.05, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '포트폴리오',
                    textScaleFactor: 0.82,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// 열기 버튼
                  Container(
                    margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
                    height: _deviceHeight * 0.04,
                    width: _deviceWidth * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      child: Text('열기'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            /// 팀 프로필
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
              alignment: Alignment.centerRight,
              height: _deviceHeight * 0.04,
              width: _deviceWidth * 0.2,
              child: Container(
                alignment: Alignment.centerRight,
                height: _deviceHeight * 0.04,
                width: _deviceWidth * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text('팀 프로필'),
                  onPressed: () async {
                    /// 서버에서 속한 팀이 있는지 다시 데이터를 불러오는 작업 필요.

                    if (widget._user.getIsJoinedTeam) {
                      /// 속한 팀이 있을 경우

                      if (widget._user.getIsMaster) {
                        /// 그 팀의 개설자일 경우
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MyTeamAdminVer(team: widget._user.getTeam);
                            },
                          ),
                        );
                      } else {
                        /// 그 팀의 개설자가 아닐 경우
                        bool getOut = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MyTeamMemberVer(
                                  team: widget._user.getTeam);
                            },
                          ),
                        );

                        /// 유저가 팀에서 나가기를 선택했을 경우 실행
                        if (getOut) {
                          widget._user.setIsJoinedTeam = false;
                          widget._user.setIsMaster = false;
                          widget._user.setTeam = new Team();

                          /// 이 정보를 서버에 전송하는 과정 필요.
                        }
                      }
                    } else {
                      /// 속한 팀이 없을 경우

                      /// 팀을 만들 것인지 물어보는 Dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('알림'),
                            content: Text('현재 속한 팀이 없습니다.\n새로 팀을 만드시겠습니까?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('예'),
                                onPressed: () async {
                                  /// Dialog 지우기
                                  Navigator.of(context).pop();

                                  /// 팀 생성 페이지로 연결
                                  Team _team = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return TeamConfigPage();
                                      },
                                    ),
                                  );

                                  if (_team != null) {
                                    widget._user.setTeam = _team;
                                    widget._user.setIsJoinedTeam = true;
                                    widget._user.setIsMaster = true;

                                    setState(() {});
                                  }
                                },
                              ),
                              FlatButton(
                                child: Text('아니오'),
                                onPressed: () {
                                  /// Dialog 지우기
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            /// 한줄평 추가 필요
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NetworkingAppBar(
        deviceHeight: _deviceHeight,
        deviceWidth: _deviceWidth,
        context: context,
        title: '내 프로필',
      ),
      body: profilebuild(_deviceHeight, _deviceWidth),
    );
  }
}

class MyProfileInfo extends StatelessWidget {
  const MyProfileInfo({
    Key key,
    @required String title,
    @required String content,
  })  : _title = title,
        _content = content,
        super(key: key);

  final String _title;
  final String _content;

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.03, 0, 0),
      child: Row(
        children: <Widget>[
          Container(
            width: _deviceWidth * 0.15,
            child: Text(
              _title,
              textScaleFactor: 0.82,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(
              _content,
              textScaleFactor: 0.82,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
