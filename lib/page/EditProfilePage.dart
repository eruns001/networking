import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:networking/data/class/User.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';
/*
class EditProfilePage extends StatefulWidget {
  EditProfilePage({
    Key key,
    @required User user,
  })  : _user = user,
        super(key: key);

  final User _user;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nickNameController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  /// 갤러리에서 이미지를 가져오는 메서드
  Future _getImage() async {
    PickedFile image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(
        () {
          widget._user.setProfileImage = Image.file(File(image.path));
        },
      );
    }
  }

  /// 페이지 내용을 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    EdgeInsets _contentPadding =
        EdgeInsets.fromLTRB(_deviceWidth * 0.035, 0, 0, 0);

    return Container(
      padding:
          EdgeInsets.fromLTRB(_deviceWidth * 0.052, 0, _deviceWidth * 0.052, 0),
      child: ListView(
        children: <Widget>[
          /// 닫기 및 저장 버튼
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: _deviceHeight * 0.105,
                  width: _deviceWidth,
                ),

                /// 닫기 버튼
                Positioned(
                  bottom: _deviceHeight * 0.037,
                  left: _deviceWidth * 0.019,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: _deviceHeight * 0.022,
                      child: Icon(Icons.close),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),

                /// 저장 버튼
                Positioned(
                  bottom: _deviceHeight * 0.033,
                  right: _deviceWidth * 0.009,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text('저장'),
                    onPressed: () {
                      widget._user.setNickName = _nickNameController.text;
                      widget._user.setName = _nameController.text;
                      widget._user.setPhoneNum = _phoneNumController.text;
                      widget._user.setEmail = _emailController.text;

                      /// 변경된 내용을 서버로 업로드하는 과정 필요

                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ),

          /// 프로필 사진, 닉네임, 별점, 비밀번호 변경 버튼
          Row(
            children: <Widget>[
              /// 프로필 사진
              Container(
                height: _deviceWidth * 0.373,
                width: _deviceWidth * 0.373,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: widget._user.getProfileImage,
                  onPressed: () async {
                    await _getImage();
                  },
                ),
              ),

              /// 닉네임, 별점, 비밀번호 변경 버튼
              Container(
                margin: EdgeInsets.fromLTRB(_deviceWidth * 0.036, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// 닉네임
                    Container(
                      height: _deviceHeight * 0.04,
                      width: _deviceWidth * 0.40,
                      child: TextField(
                        controller: _nickNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: _contentPadding,
                          hintText: '닉네임을 입력해주세요.',
                        ),
                      ),
                    ),

                    /// 별점
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

                    /// 비밀번호 변경
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(0, _deviceHeight * 0.024, 0, 0),
                      height: _deviceHeight * 0.039,
                      width: _deviceWidth * 0.188,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('비밀번호 변경'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// 이름, 연락처, 분야, 경력, 역할 변경
          Container(
            margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.047, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// 이름, 연락처
                Column(
                  children: <Widget>[
                    EditProfileStringInput(
                      title: '이름',
                      hint: '이름을 입력해주세요.',
                      controller: _nameController,
                      contentPadding: _contentPadding,
                    ),
                    EditProfileStringInput(
                      margin:
                          EdgeInsets.fromLTRB(0, _deviceHeight * 0.04, 0, 0),
                      title: '연락처',
                      hint: '연락처를 입력해주세요.',
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumController,
                      contentPadding: _contentPadding,
                    ),
                  ],
                ),

                /// 분야, 경력, 역할
                Column(
                  children: <Widget>[
                    Container(
                      height: _deviceHeight * 0.03,
                      width: _deviceWidth * 0.3,
                      color: Colors.blue,
                    ),
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(0, _deviceHeight * 0.026, 0, 0),
                      height: _deviceHeight * 0.03,
                      width: _deviceWidth * 0.3,
                      color: Colors.blue,
                    ),
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(0, _deviceHeight * 0.026, 0, 0),
                      height: _deviceHeight * 0.03,
                      width: _deviceWidth * 0.3,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 이메일 변경
          EditProfileStringInput(
            margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.03, 0, 0),
            title: '이메일',
            hint: '이메일을 입력해주세요.',
            keyboardType: TextInputType.emailAddress,
            textFieldWidthRatio: 0.7,
            controller: _emailController,
            contentPadding: _contentPadding,
          ),

          /// 주소 변경
          Container(),

          /// 포트폴리오
          Container(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _nickNameController.text = widget._user.getNickName;
    _nameController.text = widget._user.getName;
    _phoneNumController.text = widget._user.getPhoneNum;
    _emailController.text = widget._user.getEmail;
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
        title: '내 프로필 수정',
        stackIndex: 1,
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

/// 이름, 연락처, 이메일 입력받는 곳을 위한 위젯
class EditProfileStringInput extends StatelessWidget {
  const EditProfileStringInput({
    Key key,
    EdgeInsets margin,
    @required String title,
    @required TextEditingController controller,
    TextInputType keyboardType,
    double textFieldWidthRatio,
    @required EdgeInsets contentPadding,
    String hint,
  })  : _margin = margin,
        _title = title,
        _controller = controller,
        _keyboardType = keyboardType,
        _textFieldWidthRatio = textFieldWidthRatio,
        _contentPadding = contentPadding,
        _hint = hint,
        super(key: key);

  final EdgeInsets _margin;
  final String _title;
  final TextEditingController _controller;
  final TextInputType _keyboardType;
  final double _textFieldWidthRatio;
  final EdgeInsets _contentPadding;
  final String _hint;

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: _margin,
      height: _deviceHeight * 0.039,
      width: _deviceWidth * 0.55,
      child: Row(
        children: <Widget>[
          Container(
            width: _deviceWidth * 0.1,
            child: Text(_title),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: _deviceHeight * 0.039,
            width: _deviceWidth * (_textFieldWidthRatio ?? 0.405),
            child: TextField(
              controller: _controller,
              keyboardType: _keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: _contentPadding,
                hintText: _hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */
