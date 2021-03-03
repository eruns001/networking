import 'package:flutter/material.dart';
import 'package:networking/data/class/Member.dart';
import 'package:networking/data/class/Team.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';

/// 팀 프로필에서 본인이 팀에 속해있지만, 팀의 개설자가 아닌 경우 출력할 페이지
/// 팀페이지 팀원 ver.
class MyTeamMemberVer extends StatefulWidget {
  MyTeamMemberVer({
    Key key,
    @required Team team,
  })  : _team = team,
        super(key: key);

  final Team _team;

  @override
  _MyTeamMemberVerState createState() => _MyTeamMemberVerState();
}

class _MyTeamMemberVerState extends State<MyTeamMemberVer> {
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

            /// 생성일자
            Container(
              margin: EdgeInsets.fromLTRB(
                  _deviceWidth * 0.055, _deviceHeight * 0.03, 0, 0),
              child: Text(
                '생성일자  ${widget._team.anniversary.year}/${widget._team.anniversary.month}/${widget._team.anniversary.day}',
              ),
            ),

            /// 분할선
            Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
              child: Divider(),
            ),

            /// 기획
            MyTeamMemberVerTemplate(
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
            MyTeamMemberVerTemplate(
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
            MyTeamMemberVerTemplate(
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
            MyTeamMemberVerTemplate(
              deviceHeight: _deviceHeight,
              deviceWidth: _deviceWidth,
              title: '개발',
              memberList: widget._team.development,
            ),

            /// 팀 나가기 버튼
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
                  '팀 나가기',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('경고'),
                        content: Text('정말로 이 팀에서 나가시겠습니까?'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              '예',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pop(true);

                              /// 이 팀원을 팀에서 빼는 작업 추가 필요
                            },
                          ),
                          FlatButton(
                            child: Text('아니오'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
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

class MyTeamMemberVerTemplate extends StatelessWidget {
  MyTeamMemberVerTemplate({
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
