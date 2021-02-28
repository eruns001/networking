import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  var _signupimage;
  Widget _signupImageWidget = UQP_icon_1st;
  String _signupImageURL;
  TextEditingController _nickNameController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  String _addressController = '서울특별시';
  TextEditingController _emailController = new TextEditingController();

  TextEditingController _birthController = new TextEditingController();
  bool _agree = false;


  ///안쓰는 변수
  TextEditingController _pwController = new TextEditingController();
  TextEditingController _pwConfirmController = new TextEditingController();

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
              net_Container(
                child: IconButton(
                  icon: _signupImageWidget,
                  onPressed: () async{
                    network_function_getImage('SingIn', 0);
                  },
                ),
                margin: new EdgeInsets.symmetric(horizontal: _deviceWidth * (0.9/100)),
                net_width: _deviceWidth * (24.9/100),
                net_height: _deviceHeight * (12.1/100),
                radius: UQP_radius_picadd,
              ),
              /// 닉네임
              SignUpTemplate(
                controller: _nickNameController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.04,
                textInputType: TextInputType.text,
                text: '새 닉네임',
                hint: '닉네임을 작성해주세요',
                onSubmitted: (String string) {},
              ),
              /// 이름
              SignUpTemplate(
                controller: _nameController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.045,
                textInputType: TextInputType.text,
                text: '이름',
                hint: '이름을 작성해주세요',
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
              /// 생년월일
              SignUpTemplate(
                controller: _birthController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.04,
                textInputType: TextInputType.datetime,
                maxLength: 6,
                text: '생년월일',
                hint: 'EX) 951010',
                onSubmitted: (String string) {},
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
                IsLogIn = true;
                //firebase에 입력
                String document = "$uid";
                print("nickname : ${_nickNameController.text}");
                await Firestore.instance.collection('Account').document(document).setData({
                  'nickName': _nickNameController.text,
                  'name': _nameController.text,
                  'birth':_birthController.text,
                  'address':_addressController,
                  'e_mail':_emailController.text,
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
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
                fontSize: 10,
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
