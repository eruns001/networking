import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/class/Member.dart';
import 'package:networking/data/class/Team.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';

import 'TeamConfigPage.dart';

/// 팀 프로필에서 본인이 팀에 속해있고, 그 팀의 관리자일 경우 출력되는 페이지
/// 팀페이지 관리자 Ver.
class MyTeamAdminVer extends StatefulWidget {
  MyTeamAdminVer({
    Key key,
    Team team,
  })  : _team = team,
        super(key: key);

  final Team _team;

  @override
  _MyTeamAdminVerState createState() => _MyTeamAdminVerState();
}

class _MyTeamAdminVerState extends State<MyTeamAdminVer> {
  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return Container(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            /// 팀 이름
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.021, 0, 0),
              alignment: Alignment.center,
              child: Text('팀 이름'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('${widget._team.teamName}'),
            ),

            /// 프로젝트 주제
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.011, 0, 0),
              alignment: Alignment.center,
              child: Text('프로젝트 주제'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('${widget._team.subject}'),
            ),

            /// 생성일자 및 수정버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// 생성일자
                Container(
                  margin: EdgeInsets.fromLTRB(
                      _deviceWidth * 0.055, _deviceHeight * 0.03, 0, 0),
                  child: Text(
                    '생성일자  ${widget._team.anniversary.year}/${widget._team.anniversary.month}/${widget._team.anniversary.day}',
                  ),
                ),

                /// 수정버튼
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, _deviceWidth * 0.055, 0),
                  height: _deviceWidth * 0.088,
                  width: _deviceWidth * 0.088,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Image.asset('images/myTeamAdminVer_btn_change.png'),
                    onPressed: () async {
                      Team _newTeam = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return TeamConfigPage(team: widget._team);
                          },
                        ),
                      );

                      if(_newTeam != null) {
                        widget._team.teamName = _newTeam.teamName;
                        widget._team.subject = _newTeam.subject;
                        widget._team.anniversary = _newTeam.anniversary;
                        widget._team.planning = _newTeam.planning;
                        widget._team.design = _newTeam.design;
                        widget._team.marketing = _newTeam.marketing;
                        widget._team.development = _newTeam.development;

                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),

            /// 분할선
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
              child: Divider(),
            ),

            /// 기획
            MyTeamAdminVerTemplate(
              deviceHeight: _deviceHeight,
              deviceWidth: _deviceWidth,
              title: '기획',
              memberList: widget._team.planning,
            ),

            /// 분할선
            Container(
              margin: EdgeInsets.fromLTRB(
                _deviceWidth * 0.055,
                _deviceHeight * 0.037,
                _deviceWidth * 0.055,
                0,
              ),
              child: Divider(),
            ),

            /// 디자인
            MyTeamAdminVerTemplate(
              deviceHeight: _deviceHeight,
              deviceWidth: _deviceWidth,
              title: '디자인',
              memberList: widget._team.design,
            ),

            /// 분할선
            Container(
              margin: EdgeInsets.fromLTRB(
                _deviceWidth * 0.055,
                _deviceHeight * 0.037,
                _deviceWidth * 0.055,
                0,
              ),
              child: Divider(),
            ),

            /// 마케팅
            MyTeamAdminVerTemplate(
              deviceHeight: _deviceHeight,
              deviceWidth: _deviceWidth,
              title: '마케팅',
              memberList: widget._team.marketing,
            ),

            /// 분할선
            Container(
              margin: EdgeInsets.fromLTRB(
                _deviceWidth * 0.055,
                _deviceHeight * 0.037,
                _deviceWidth * 0.055,
                0,
              ),
              child: Divider(),
            ),

            /// 개발
            MyTeamAdminVerTemplate(
              deviceHeight: _deviceHeight,
              deviceWidth: _deviceWidth,
              title: '개발',
              memberList: widget._team.development,
            ),

            /// 프로젝트 완료 버튼
            Container(
              margin: EdgeInsets.fromLTRB(
                _deviceWidth * 0.3925,
                _deviceHeight * 0.037,
                _deviceWidth * 0.3925,
                _deviceHeight * 0.055,
              ),
              height: _deviceHeight * 0.025,
              width: _deviceWidth * 0.264,
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: Text(
                  '프로젝트 완료',
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NetworkingAppBar(
        deviceHeight: _deviceHeight,
        deviceWidth: _deviceWidth,
        context: context,
        title: 'MY TEAM',
        stackIndex: 1,
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

class MyTeamAdminVerTemplate extends StatelessWidget {
  MyTeamAdminVerTemplate({
    Key key,
    double deviceHeight,
    double deviceWidth,
    String title,
    List<Member> memberList,
  })  : _deviceHeight = deviceHeight,
        _deviceWidth = deviceWidth,
        _title = title,
        _memberList = memberList,
        super(key: key);

  final double _deviceHeight;
  final double _deviceWidth;
  final String _title;
  final List<Member> _memberList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        _deviceWidth * 0.055,
        0,
        _deviceWidth * 0.055,
        0,
      ),
      height: (_deviceHeight * 0.05) +
          ((_memberList.length) * _deviceHeight * 0.135),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: _memberList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.fromLTRB(
                0,
                _deviceHeight * 0.012,
                0,
                _deviceHeight * 0.007,
              ),

              /// 제목
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          } else {
            /// 멤버의 정보가 표시될 공간
            return Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.013, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Container(
                padding: EdgeInsets.all(_deviceHeight * 0.011),
                child: Column(
                  children: <Widget>[
                    Row(
                      /// 이름
                      children: <Widget>[
                        Container(
                          width: _deviceWidth * 0.2,
                          child: Text('이름'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _deviceWidth * 0.05),
                          child:
                              Text('${_memberList.elementAt(index - 1).name}'),
                        ),
                      ],
                    ),
                    Divider(),

                    /// 연락처
                    Row(
                      children: <Widget>[
                        Container(
                          width: _deviceWidth * 0.2,
                          child: Text('연락처'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _deviceWidth * 0.05),
                          child: Text(
                              '${_memberList.elementAt(index - 1).phoneNum}'),
                        ),
                      ],
                    ),

                    /// 포지션
                    Row(
                      children: <Widget>[
                        Container(
                          width: _deviceWidth * 0.2,
                          child: Text('포지션'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _deviceWidth * 0.05),
                          child: Text(
                              '${_memberList.elementAt(index - 1).position}'),
                        ),
                      ],
                    ),
                    Row(
                      /// 이메일
                      children: <Widget>[
                        Container(
                          width: _deviceWidth * 0.2,
                          child: Text('이메일'),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _deviceWidth * 0.05),
                          child:
                              Text('${_memberList.elementAt(index - 1).email}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
