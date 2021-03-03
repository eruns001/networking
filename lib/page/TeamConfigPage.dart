import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/class/Member.dart';
import 'package:networking/data/class/Team.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';
import 'package:rxdart/rxdart.dart';

/// 팀 설정 페이지
/// 속한 팀이 없을 경우 이 페이지에서 팀을 만들 수 있다.
class TeamConfigPage extends StatefulWidget {
  const TeamConfigPage({
    Key key,
    Team team,
  })  : _team = team,
        super(key: key);

  final Team _team;

  @override
  _TeamConfigPageState createState() => _TeamConfigPageState();
}

class _TeamConfigPageState extends State<TeamConfigPage> {
  BehaviorSubject<List<Member>> _planningController = new BehaviorSubject();
  BehaviorSubject<List<Member>> _designController = new BehaviorSubject();
  BehaviorSubject<List<Member>> _marketingController = new BehaviorSubject();
  BehaviorSubject<List<Member>> _developmentController = new BehaviorSubject();

  TextEditingController _teamNameController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();

  ScrollController _listViewScrollController = new ScrollController();

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
              /// 팀 이름
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.021, 0, 0),
                alignment: Alignment.center,
                child: Text('팀 이름'),
              ),

              /// 팀 이름 입력 공간
              TeamConfigTextField(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                controller: _teamNameController,
              ),

              /// 프로젝트 주제
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.011, 0, 0),
                alignment: Alignment.center,
                child: Text('프로젝트 주제'),
              ),

              /// 프로젝트 주제 입력 공간
              TeamConfigTextField(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                controller: _subjectController,
              ),

              /// 분할선
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
                child: Divider(),
              ),

              /// 기획
              TeamConfigTemplate(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '기획',
                controller: _planningController,
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
              TeamConfigTemplate(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '디자인',
                controller: _designController,
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
              TeamConfigTemplate(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '마케팅',
                controller: _marketingController,
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
              TeamConfigTemplate(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                title: '개발',
                controller: _developmentController,
              ),

              /// 저장버튼
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
                  onPressed: () {
                    Team _team = new Team();

                    _team.teamName = _teamNameController.text;
                    _team.subject = _subjectController.text;
                    if (_planningController.value != null)
                      _team.planning = _planningController.value;
                    if (_designController.value != null)
                      _team.design = _designController.value;
                    if (_marketingController.value != null)
                      _team.marketing = _marketingController.value;
                    if (_developmentController.value != null)
                      _team.development = _developmentController.value;
                    if(widget._team == null) {
                      _team.anniversary = DateTime.now();
                    }
                    else {
                      _team.anniversary = widget._team.anniversary;
                    }

                    print(_team.teamName);
                    print(_team.subject);
                    print('planning : ' + _team.planning.length.toString());
                    print('design : ' + _team.design.length.toString());
                    print('marketing : ' + _team.marketing.length.toString());
                    print(
                        'development : ' + _team.development.length.toString());
                    print('anniversary : ' + _team.anniversary.toString());

                    Navigator.of(context).pop(_team);

                    /// 서버에 데이터를 업로드하는 작업 필요.
                    /// 팀을 수정하는 경우와 새로 만드는 경우를 분리해서 해야할듯
                    /// 구분은 [widget._team] 이 null 인지 아닌지로 하면 된다.
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    if(widget._team != null) {
      _teamNameController.text = widget._team.teamName;
      _subjectController.text = widget._team.subject;
      _planningController.sink.add(widget._team.planning);
      _designController.sink.add(widget._team.design);
      _marketingController.sink.add(widget._team.marketing);
      _developmentController.sink.add(widget._team.development);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _planningController.close();
    _designController.close();
    _marketingController.close();
    _developmentController.close();
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
        title: 'My TEAM',
        stackIndex: 1,
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
    Function onSubmitted,
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

/// 멤버 구성 템플릿
class TeamConfigTemplate extends StatelessWidget {
  const TeamConfigTemplate({
    Key key,
    @required double deviceHeight,
    @required double deviceWidth,
    @required String title,
    @required StreamController<List<Member>> controller,
  })  : _deviceHeight = deviceHeight,
        _deviceWidth = deviceWidth,
        _title = title,
        _controller = controller,
        super(key: key);

  final double _deviceHeight;
  final double _deviceWidth;
  final String _title;
  final StreamController<List<Member>> _controller;

  ///*************************** 다이얼로그에 쓰이는 변수 ****************************

  static const double DIALOG_HEIGHT = 200;
  static const double DIALOG_WIDTH = 200;
  static const double DIALOG_TEXT_FIELD_HEIGHT = 30;
  static const double DIALOG_TEXT_FIELD_WIDTH = 150;

  ///***************************************************************************

  /// 멤버 수정 다이얼로그를 보여주는 메서드
  Future _showEditMemberDialog(
      BuildContext context, List<Member> memberList, int index) async {
    TextEditingController _nameController =
        new TextEditingController(text: memberList.elementAt(index).name);
    TextEditingController _phoneNumController =
        new TextEditingController(text: memberList.elementAt(index).phoneNum);
    TextEditingController _positionController =
        new TextEditingController(text: memberList.elementAt(index).position);
    TextEditingController _emailController =
        new TextEditingController(text: memberList.elementAt(index).email);

    ScrollController _dialogScrollController = new ScrollController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('멤버 수정'),
          content: Container(
            height: DIALOG_HEIGHT,
            width: DIALOG_WIDTH,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: Scrollbar(
                controller: _dialogScrollController,
                child: ListView(
                  controller: _dialogScrollController,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('이름'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('연락처'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _phoneNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('포지션'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _positionController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('이메일'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    memberList.removeAt(index);

                    _controller.sink.add(memberList);

                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(''),
                  onPressed: null,
                ),
                FlatButton(
                  child: Text('확인'),
                  onPressed: () {
                    memberList.removeAt(index);

                    memberList.insert(
                      index,
                      Member(
                        name: _nameController.text,
                        phoneNum: _phoneNumController.text,
                        position: _positionController.text,
                        email: _emailController.text,
                      ),
                    );

                    _controller.sink.add(memberList);

                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// 멤버 추가 다이얼로그를 보여주는 메서드
  Future _showAddMemberDialog(
      BuildContext context, List<Member> memberList) async {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _phoneNumController = new TextEditingController();
    TextEditingController _positionController = new TextEditingController();
    TextEditingController _emailController = new TextEditingController();

    ScrollController _dialogScrollController = new ScrollController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('멤버 추가'),
          content: Container(
            height: DIALOG_HEIGHT,
            width: DIALOG_WIDTH,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: Scrollbar(
                controller: _dialogScrollController,
                child: ListView(
                  controller: _dialogScrollController,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('이름'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('연락처'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _phoneNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('포지션'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _positionController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text('이메일'),
                          ),
                          Container(
                            height: DIALOG_TEXT_FIELD_HEIGHT,
                            width: DIALOG_TEXT_FIELD_WIDTH,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                memberList.add(
                  Member(
                    name: _nameController.text,
                    phoneNum: _phoneNumController.text,
                    position: _positionController.text,
                    email: _emailController.text,
                  ),
                );

                _controller.sink.add(memberList);

                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      initialData: new List<Member>(),
      builder: (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
        return Container(
          margin: EdgeInsets.fromLTRB(
            _deviceWidth * 0.055,
            0,
            _deviceWidth * 0.055,
            0,
          ),
          height: (_deviceHeight * 0.05) +
              ((snapshot.data.length + 1) * _deviceHeight * 0.135),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    _deviceHeight * 0.012,
                    0,
                    _deviceHeight * 0.007,
                  ),
                  child: Row(
                    children: <Widget>[
                      /// 중간 맞추기용
                      Container(
                        height: _deviceHeight * 0.019,
                        width: _deviceWidth * 0.217,
                      ),

                      /// 제목
                      Expanded(
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

                      /// 포지션 변경 버튼
                      Container(
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
                /// 멤버의 정보가 표시될 공간
                return Container(
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
                            /// 이름
                            Row(
                              children: <Widget>[
                                Container(
                                  width: _deviceWidth * 0.2,
                                  child: Text('이름'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: _deviceWidth * 0.05),
                                  child: (snapshot.data.length + 1 > index)
                                      ? Text(snapshot.data
                                          .elementAt(index - 1)
                                          .name)
                                      : null,
                                ),
                              ],
                            ),

                            /// 분할선
                            Divider(),

                            /// 연락처
                            Row(
                              children: <Widget>[
                                Container(
                                  width: _deviceWidth * 0.2,
                                  child: Text('연락처'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: _deviceWidth * 0.05),
                                  child: (snapshot.data.length + 1 > index)
                                      ? Text(snapshot.data
                                          .elementAt(index - 1)
                                          .phoneNum)
                                      : null,
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
                                  margin: EdgeInsets.only(
                                      left: _deviceWidth * 0.05),
                                  child: (snapshot.data.length + 1 > index)
                                      ? Text(snapshot.data
                                          .elementAt(index - 1)
                                          .position)
                                      : null,
                                ),
                              ],
                            ),

                            /// 이메일
                            Row(
                              children: <Widget>[
                                Container(
                                  width: _deviceWidth * 0.2,
                                  child: Text('이메일'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: _deviceWidth * 0.05),
                                  child: (snapshot.data.length + 1 > index)
                                      ? Text(snapshot.data
                                          .elementAt(index - 1)
                                          .email)
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// 멤버 수정 버튼
                      Visibility(
                        visible: snapshot.data.length + 1 > index,
                        child: Positioned(
                          bottom: _deviceHeight * 0.02,
                          right: _deviceHeight * 0.02,
                          child: Container(
                            height: _deviceWidth * 0.05,
                            width: _deviceWidth * 0.05,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.edit),
                              onPressed: () {
                                _showEditMemberDialog(
                                    context, snapshot.data, index - 1);
                              },
                            ),
                          ),
                        ),
                      ),

                      /// 멤버 추가 버튼
                      Visibility(
                        visible: snapshot.data.length + 1 == index,
                        child: Positioned(
                          bottom: _deviceHeight * 0.02,
                          right: _deviceHeight * 0.02,
                          child: Container(
                            height: _deviceWidth * 0.05,
                            width: _deviceWidth * 0.05,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.add),
                              onPressed: () {
                                _showAddMemberDialog(context, snapshot.data);
                              },
                            ),
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
      },
    );
  }
}
