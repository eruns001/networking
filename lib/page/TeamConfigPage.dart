import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 위젯을 하나 만들었는데, Stateful 로 하는것이 귀찮아서 Function 을 받아서 거기에
/// setState 를 넣는쪽으로 했는데, 불필요한 반복이 너무 많아서 Stateful 로 바꿀까 고민중.

class TeamConfigPage extends StatefulWidget {
  const TeamConfigPage({Key key}) : super(key: key);

  @override
  _TeamConfigPageState createState() => _TeamConfigPageState();
}

class _TeamConfigPageState extends State<TeamConfigPage> {
  Team _team = new Team();

  TextEditingController _teamNameController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();

  ScrollController _listViewScrollController = new ScrollController();

  int _planningMemberNum = 1;
  int _designMemberNum = 1;
  int _marketingMemberNum = 1;
  int _developmentMemberNum = 1;

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: Container(
        child: Scrollbar(
          controller: _listViewScrollController,
          child: ListView(
            controller: _listViewScrollController,
            children: <Widget>[
              Container(
                /// 팀 이름
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.021, 0, 0),
                alignment: Alignment.center,
                child: Text('팀 이름'),
              ),
              TeamConfigTextField(
                /// 팀 이름 입력 공간
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                controller: _teamNameController,
                onSubmitted: (String string) {
                  _team.teamName = string;
                },
              ),
              Container(
                /// 프로젝트 주제
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.011, 0, 0),
                alignment: Alignment.center,
                child: Text('프로젝트 주제'),
              ),
              TeamConfigTextField(
                /// 프로젝트 주제 입력 공간
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                controller: _subjectController,
                onSubmitted: (String string) {
                  _team.subject = string;
                },
              ),
              Container(
                /// 분할선
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
                child: Divider(),
              ),
              TeamConfigTemplate(
                /// 기획
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '기획',
                memberNum: _planningMemberNum,
                memberList: _team.planning,
                editMember: () {},
                addMember: () {
                  _team.planning.add(
                    Member(
                      name: 'test',
                      phoneNum: '000-0000-0000',
                      position: 'null',
                      email: 'test@naver.com',
                    ),
                  );

                  setState(() {
                    _planningMemberNum += 1;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  _deviceWidth * 0.055,
                  _deviceHeight * 0.037,
                  _deviceWidth * 0.055,
                  0,
                ),
                child: Divider(),
              ),
              TeamConfigTemplate(
                /// 디자인
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '디자인',
                memberNum: _designMemberNum,
                memberList: _team.design,
                editMember: () {},
                addMember: () {
                  _team.design.add(
                    Member(
                      name: 'test',
                      phoneNum: '000-0000-0000',
                      position: 'null',
                      email: 'test@naver.com',
                    ),
                  );

                  setState(() {
                    _designMemberNum += 1;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  _deviceWidth * 0.055,
                  _deviceHeight * 0.037,
                  _deviceWidth * 0.055,
                  0,
                ),
                child: Divider(),
              ),
              TeamConfigTemplate(
                /// 마케팅
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '마케팅',
                memberNum: _marketingMemberNum,
                memberList: _team.marketing,
                editMember: () {},
                addMember: () {
                  _team.marketing.add(
                    Member(
                      name: 'test',
                      phoneNum: '000-0000-0000',
                      position: 'null',
                      email: 'test@naver.com',
                    ),
                  );

                  setState(() {
                    _marketingMemberNum += 1;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  _deviceWidth * 0.055,
                  _deviceHeight * 0.037,
                  _deviceWidth * 0.055,
                  0,
                ),
                child: Divider(),
              ),
              TeamConfigTemplate(
                /// 개발
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '개발',
                memberNum: _developmentMemberNum,
                memberList: _team.development,
                editMember: () {},
                addMember: () {
                  _team.development.add(
                    Member(
                      name: 'test',
                      phoneNum: '000-0000-0000',
                      position: 'null',
                      email: 'test@naver.com',
                    ),
                  );

                  setState(() {
                    _developmentMemberNum += 1;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  _deviceWidth * 0.3925,
                  _deviceHeight * 0.037,
                  _deviceWidth * 0.3925,
                  _deviceHeight * 0.055,
                ),
                height: _deviceHeight * 0.03,
                width: _deviceWidth * 0.217,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text('저장'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 앱바 빌드 메서드
  Widget _buildTitle(double _deviceHeight, double _deviceWidth) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(_deviceWidth * 0.105, 0, 0, 0),
          height: _deviceHeight * 0.041,
          width: _deviceWidth * 0.101,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset('images/community_btn_menu.png'),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'MY TEAM',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              _deviceWidth * 0.02, 0, _deviceWidth * 0.111, 0),
          height: _deviceHeight * 0.041,
          width: _deviceWidth * 0.075,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset('images/community_btn_alarm.png'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        leading: null,
        automaticallyImplyLeading: false,
        toolbarHeight: _deviceHeight * 0.073,
        centerTitle: true,
        titleSpacing: 0,
        title: _buildTitle(_deviceHeight, _deviceWidth),
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

/// 팀 이름 및 프로젝트 주제를 입력받을 텍스트 필드
class TeamConfigTextField extends StatelessWidget {
  const TeamConfigTextField({
    Key key,
    @required TextEditingController controller,
    @required double deviceHeight,
    @required double deviceWidth,
    @required Function onSubmitted,
  })  : _controller = controller,
        _deviceHeight = deviceHeight,
        _deviceWidth = deviceWidth,
        _onSubmitted = onSubmitted,
        super(key: key);

  final TextEditingController _controller;
  final double _deviceHeight;
  final double _deviceWidth;
  final Function _onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        _deviceWidth * 0.36,
        _deviceHeight * 0.02,
        _deviceWidth * 0.36,
        0,
      ),
      alignment: Alignment.center,
      height: _deviceHeight * 0.025,
      child: TextField(
        controller: _controller,
        style: TextStyle(
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '내용 입력',
          hintStyle: TextStyle(
            fontSize: 12,
          ),
        ),
        onSubmitted: _onSubmitted,
      ),
    );
  }
}

class TeamConfigTemplate extends StatelessWidget {
  const TeamConfigTemplate({
    Key key,
    @required double deviceHeight,
    @required double deviceWidth,
    @required int memberNum,
    @required List<Member> memberList,
    @required String title,
    @required Function addMember,
    @required Function editMember,
  })  : _deviceHeight = deviceHeight,
        _deviceWidth = deviceWidth,
        _memberNum = memberNum,
        _memberList = memberList,
        _title = title,
        _addMember = addMember,
        _editMember = editMember,
        super(key: key);

  final double _deviceHeight;
  final double _deviceWidth;
  final int _memberNum;
  final List<Member> _memberList;
  final String _title;
  final Function _addMember;
  final Function _editMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        _deviceWidth * 0.055,
        0,
        _deviceWidth * 0.055,
        0,
      ),
      height: _deviceHeight * 0.055 + _memberNum * _deviceHeight * 0.18,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: _memberNum + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.012, 0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    /// 중간 맞추기용
                    height: _deviceHeight * 0.019,
                    width: _deviceWidth * 0.217,
                  ),
                  Expanded(
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
                  ),
                  Container(
                    /// 포지션 변경 버튼
                    height: _deviceHeight * 0.04,
                    width: _deviceWidth * 0.217,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                          'images/teamConfig_btn_changePosition.png'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          } else {
            // 정보가 입력되었는지 판단할 변수
            return Container(
              /// 멤버의 정보가 표시될 공간
              margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.013, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
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
                              margin:
                                  EdgeInsets.only(left: _deviceWidth * 0.05),
                              child: (_memberNum > index)
                                  ? Text(_memberList.elementAt(index - 1).name)
                                  : null,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          /// 연락처
                          children: <Widget>[
                            Container(
                              width: _deviceWidth * 0.2,
                              child: Text('연락처'),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: _deviceWidth * 0.05),
                              child: (_memberNum > index)
                                  ? Text(
                                      _memberList.elementAt(index - 1).phoneNum)
                                  : null,
                            ),
                          ],
                        ),
                        Row(
                          /// 포지션
                          children: <Widget>[
                            Container(
                              width: _deviceWidth * 0.2,
                              child: Text('포지션'),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: _deviceWidth * 0.05),
                              child: (_memberNum > index)
                                  ? Text(
                                      _memberList.elementAt(index - 1).position)
                                  : null,
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
                              margin:
                                  EdgeInsets.only(left: _deviceWidth * 0.05),
                              child: (_memberNum > index)
                                  ? Text(_memberList.elementAt(index - 1).email)
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    /// 멤버 추가 / 수정 버튼
                    bottom: _deviceHeight * 0.02,
                    right: _deviceHeight * 0.02,
                    child: Container(
                      height: _deviceWidth * 0.05,
                      width: _deviceWidth * 0.05,
                      child: (_memberNum > index)
                          ? CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.edit),
                              onPressed: _editMember,
                            )
                          : CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.add),
                              onPressed: _addMember,
                            ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

/// 팀의 정보를 담을 클래스
class Team {
  /// 팀 이름
  String teamName;

  /// 주제
  String subject;

  /// 기획
  List<Member> planning = new List<Member>();

  /// 디자인
  List<Member> design = new List<Member>();

  /// 마케팅
  List<Member> marketing = new List<Member>();

  /// 개발
  List<Member> development = new List<Member>();
}

/// 팀에 들어갈 멤버들을 저장할 클래스
class Member {
  /// 멤버 이름
  String name;

  /// 멤버 연락처
  String phoneNum;

  /// 멤버 포지션
  String position;

  /// 멤버 이메일
  String email;

  Member({
    @required this.name,
    @required this.phoneNum,
    @required this.position,
    @required this.email,
  });
}
