import 'package:flutter/material.dart';
import 'package:networking/data/class/User.dart';
import 'package:networking/widget/NetworkingAppBar.dart';

import 'EditProfilePage.dart';

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
      padding: EdgeInsets.all(_deviceWidth * 0.052),
      child: ListView(
        children: <Widget>[
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return EditProfilePage(
                                          user: widget._user);
                                    },
                                  ),
                                );
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
        ],
      ),
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
        title: '내 프로필',
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}
