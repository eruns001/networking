import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:networking/data/data.dart';
import 'package:networking/data/function.dart';
import 'package:networking/widget/net_Container.dart';

import '../main.dart';

///구글 연계 로그인 후 firebase에 집어넣을 개인정보 입력하는 페이지
///프로필사진
///닉네임
///이름
///연락처
///주소
///이메일
///분야
///역활

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key key,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // TextEditingController _emailController = new TextEditingController();
  // TextEditingController _pwController = new TextEditingController();
  // TextEditingController _pwConfirmController = new TextEditingController();

  Widget _signupImageWidget = ClipOval(
    child: Image(image:  NetworkImage(basicImageUrl)),
  );

  ///프로필 이미지 url
  String _imageUrlController = basicImageUrl;
  ///닉네임
  TextEditingController _nickNameController = new TextEditingController();
  ///이름
  TextEditingController _nameController = new TextEditingController();
  ///연락처
  TextEditingController _contactController = new TextEditingController();
  ///주소
  String _addressController = '서울특별시';
  ///역할
  String _roleController = 'SW 개발';
  ///분야
  String positionController = "모든분야";
  ///email
  TextEditingController _emailController = new TextEditingController();
  ///커리어
  TextEditingController _careerController = new TextEditingController();

  TextEditingController _birthController = new TextEditingController();
  bool _agree = false;


  //TextEditingController temp = new TextEditingController();
  ///안쓰는 변수
  TextEditingController _pwController = new TextEditingController();
  TextEditingController _pwConfirmController = new TextEditingController();


  ///빈 란이 있는지 채크
  bool _toastSignUpIsNull() {
    String nullCase;
    bool SignUpNull = false;
    if(_nickNameController.text.length == 0) {nullCase = "닉네임"; SignUpNull = true;}
    else if(_nameController.text.length == 0) {nullCase = "이름"; SignUpNull = true;}
    else if(_contactController.text.length == 0) {nullCase = "연락처"; SignUpNull = true;}
    else if(_emailController.text.length == 0) {nullCase = "이메일"; SignUpNull = true;}

    ///비었을때 Toast
    if(SignUpNull){
      Fluttertoast.showToast(
          msg: "$nullCase을(를) 입력해주세요",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    return SignUpNull;
  }

  ///업로드
  Future _SignUpPageUpload() async{
    IsLogIn = true;
    ///firebase에 입력
    String document = "$uid";
    await Firestore.instance.collection('Account').document(document).setData({
      'imageUrl' : _imageUrlController,
      'nickName': _nickNameController.text,
      'name': _nameController.text,
      'contact' : _contactController.text,
      'birth':_birthController.text,
      'address':_addressController,
      'e_mail':_emailController.text,
      'career': _careerController.text,
      'roll':_roleController,
      'position':positionController,
    });

  }
  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(_deviceWidth * 0.115, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// 회원가입
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.052, 0, 0),
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              /*
              SignUpTemplate(
                /// 비밀번호
                controller: _pwController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.04,
                textInputType: TextInputType.text,
                text: '패스워드(6자리)',
                hint: '********',
                onSubmitted: (String string) {},
              ),
              SignUpTemplate(
                /// 비밀번호 확인
                controller: _pwConfirmController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.04,
                textInputType: TextInputType.text,
                text: '패스워드 확인',
                hint: '********',
                onSubmitted: (String string) {},
              ),
              */

              ///프로필사진
              Container(
                margin: EdgeInsets.only(top: _deviceHeight * 0.03),
                child: Text(
                  '프로필사진',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: _deviceHeight * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _signupImageWidget,
                          Container(
                            margin: EdgeInsets.only(right: _deviceHeight * 0.02),
                            child: FlatButton(
                                minWidth: 20,
                                child: Text(
                                  '수정',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: null
                            ),
                          ),
                        ],
                      )
                  ),

                  /// 닉네임
                  Container(
                    margin: EdgeInsets.only(right: _deviceHeight * 0.02),
                    child: SignUpTemplate(
                      controller: _nickNameController,
                      deviceHeight: _deviceHeight,
                      deviceWidth: _deviceWidth * 0.7,
                      topMarginRatio: 0.03,
                      textInputType: TextInputType.text,
                      text: '새 닉네임',
                      hint: '닉네임을 작성해주세요',
                      onSubmitted: (String string) {},
                    ),
                  )
                ],
              ),

              /// 이름
              SignUpTemplate(
                controller: _nameController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.03,
                textInputType: TextInputType.text,
                text: '이름',
                hint: '이름을 작성해주세요',
                onSubmitted: (String string) {},
              ),
              /// 연락처
              SignUpTemplate(
                controller: _contactController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.03,
                textInputType: TextInputType.phone,
                maxLength: 11,
                text: '연락처',
                hint: 'EX) 01012345067',
                onSubmitted: (String string) {},
              ),
              /// 이메일
              SignUpTemplate(
                controller: _emailController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.03,
                textInputType: TextInputType.emailAddress,
                text: '이메일',
                hint: 'Ex) @GMAIL.COM',
                onSubmitted: (String string) {},
              ),
              ///경력
              SignUpTemplate(
                controller: _careerController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth * 0.4,
                topMarginRatio: 0.03,
                textInputType: TextInputType.number,
                maxLength: 3,
                text: '경력 (단위 : 년)',
                hint: 'ex) 1',
                onSubmitted: (String string) {},
              ),
              /// 생년월일
              SignUpTemplate(
                controller: _birthController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.03,
                textInputType: TextInputType.datetime,
                maxLength: 6,
                text: '생년월일',
                hint: 'EX) 951010',
                onSubmitted: (String string) {},
              ),
              ///역할
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.014, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('역할'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(_deviceWidth * 0.05, 0, 0, 0),
                      child: DropdownButton(
                        value: _roleController,
                        items: roleList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _roleController = newValue;
                            positionController = "모든분야";
                            positionList = setPositionList(_roleController);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ///분야
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.014, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('분야'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(_deviceWidth * 0.05, 0, 0, 0),
                      child: DropdownButton<String>(
                        value: positionController,
                        onChanged: (String newValue) {
                          setState(() {
                            positionController = newValue;
                          });
                        },
                        items: positionList
                            .map<DropdownMenuItem<String>>((String newValue) {
                          return DropdownMenuItem<String>(
                            value: newValue,
                            child: Text(newValue),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              /// 주소
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.014, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('주소'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(_deviceWidth * 0.05, 0, 0, 0),
                      child: DropdownButton(
                        value: _addressController,
                        items: addressList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _addressController = newValue;
                          });
                        },
                      ),
                    ),
                    Container(
                        child: Text('시/도')
                    ),
                    /*
                    Container(
                      margin: EdgeInsets.fromLTRB(_deviceWidth * 0.05, 0, 0, 0),
                      child: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('test'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
                      child: Text('도'),
                    ),*/
                  ],
                ),
              ),
              /// 약관
              Container(
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.03, 0, 0),
                height: _deviceHeight * 0.12,
                width: _deviceWidth * 0.725,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
              /// 개인정보 수집 동의
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, _deviceHeight * 0.08),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '개인정보수집 동의',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Checkbox(
                        value: _agree,
                        onChanged: (bool value) {
                          setState(
                            () {
                              _agree = value;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 앱바 빌드 메서드
  Widget _buildAppBarTitle(double _deviceHeight, double _deviceWidth) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          ///X버튼
          Container(
            margin: EdgeInsets.fromLTRB(_deviceWidth * 0.03, 0, 0, 0),
            width: _deviceWidth * 0.045,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/signUp_btn_close.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          ///다음 버튼
          Container(
            height: _deviceHeight * 0.019,
            width: _deviceWidth * 0.083,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/signUp_btn_next.png'),
              onPressed: () async {

                bool isNull = _toastSignUpIsNull();
                if(!isNull){
                  await _SignUpPageUpload();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: null,
        automaticallyImplyLeading: false,
        toolbarHeight: _deviceHeight * 0.075,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: null,
          child: Container(
            height: 0.5,
            color: Color.fromARGB(255, 67, 164, 210),
          ),
        ),
        title: _buildAppBarTitle(_deviceHeight, _deviceWidth),
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

class SignUpTemplate extends StatelessWidget {
  const SignUpTemplate({
    Key key,
    @required TextEditingController controller,
    @required this.deviceHeight,
    @required this.deviceWidth,
    @required this.topMarginRatio,
    @required this.text,
    @required this.hint,
    @required this.onSubmitted,
    @required this.textInputType,
    this.maxLength,
    this.textInputFormatter,
  })  : controller = controller,
        super(key: key);

  final TextEditingController controller;
  final double deviceHeight;
  final double deviceWidth;
  final double topMarginRatio;
  final String text;
  final String hint;
  final Function onSubmitted;
  final TextInputType textInputType;
  final int maxLength;
  final List<TextInputFormatter> textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, deviceHeight * topMarginRatio, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, deviceHeight * 0.01, 0, 0),
            height: deviceHeight * 0.08,
            width: deviceWidth * 0.725,
            child: TextField(
              controller: controller,
              keyboardType: textInputType,
              inputFormatters: textInputFormatter,
              maxLength: maxLength,
              style: TextStyle(
                fontSize: 15,
              ),
              decoration: InputDecoration(
                counterText: '',
                contentPadding:
                    EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, 0, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: hint,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
