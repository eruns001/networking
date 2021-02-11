import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordOrIdPage extends StatefulWidget {
  ForgotPasswordOrIdPage({
    Key key,
  }) : super(key: key);

  @override
  _ForgotPasswordOrIdPageState createState() => _ForgotPasswordOrIdPageState();
}

class _ForgotPasswordOrIdPageState extends State<ForgotPasswordOrIdPage> {
  TextEditingController _findAccountController = new TextEditingController();
  TextEditingController _findPWNameController = new TextEditingController();
  TextEditingController _findPWIdController = new TextEditingController();

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {

    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(_deviceWidth * 0.141, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                /// 계정찾기
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.032, 0, 0),
                //height: _deviceHeight * 0.016,
                //width: _deviceWidth * 0.133,
                child: Text(
                  '계정찾기',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ForgotPasswordOrIdInfo(
                /// 안내 문구
                deviceHeight: _deviceHeight,
                marginRatio: 0.021,
                text: '사용자의 이름이나, 이메일을 입력해주세요.',
              ),
              ForgotPasswordOrIdInputField(
                /// 입력 공간
                controller: _findAccountController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                hint: '사용자의 이름, 또는 이메일',
                onSubmitted: null,
              ),
              ForgotPasswordOrIdButton(
                /// 버튼
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.079, 0, 0),
          height: 0.5,
          color: Color.fromARGB(255, 55, 55, 55),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(_deviceWidth * 0.141, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                /// 비밀번호 찾기
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.051, 0, 0),
                //height: _deviceHeight * 0.016,
                //width: _deviceWidth * 0.215,
                child: Text(
                  '비밀번호 찾기',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ForgotPasswordOrIdInfo(
                /// 안내 문구 1
                deviceHeight: _deviceHeight,
                marginRatio: 0.021,
                text: '사용자의 이름이나, 이메일을 입력해주세요.',
              ),
              ForgotPasswordOrIdInputField(
                /// 입력 공간 1
                controller: _findPWNameController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                hint: '사용자의 이름, 또는 이메일',
                onSubmitted: null,
              ),
              ForgotPasswordOrIdInfo(
                /// 안내 문구2
                deviceHeight: _deviceHeight,
                marginRatio: 0.0,
                text: '사용하고 있는 아이디를 입력해주세요.',
              ),
              ForgotPasswordOrIdInputField(
                /// 입력 공간 2
                controller: _findPWIdController,
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                hint: '사용하고 있는 아이디',
                onSubmitted: null,
              ),
              ForgotPasswordOrIdButton(
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                onPressed: () {},
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
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(_deviceWidth * 0.03, 0, 0, 0),
      width: _deviceWidth * 0.045,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Image.asset(
            'images/forgotPasswordOrId/forgotPasswordOrId_btn_close.png'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: _deviceHeight * 0.075,
        elevation: 0,
        title: _buildAppBarTitle(_deviceHeight, _deviceWidth),
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

class ForgotPasswordOrIdInputField extends StatelessWidget {
  const ForgotPasswordOrIdInputField({
    Key key,
    @required this.controller,
    @required this.deviceHeight,
    @required this.deviceWidth,
    @required this.hint,
    @required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final double deviceHeight;
  final double deviceWidth;
  final String hint;
  final Function onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, deviceHeight * 0.01, 0, 0),
      height: deviceHeight * 0.08,
      width: deviceWidth * 0.725,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, 0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hint,
        ),
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}

class ForgotPasswordOrIdInfo extends StatelessWidget {
  const ForgotPasswordOrIdInfo({
    Key key,
    @required this.deviceHeight,
    @required this.marginRatio,
    @required this.text,
  }) : super(key: key);

  final double deviceHeight;
  final double marginRatio;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, deviceHeight * marginRatio, 0, 0),
      //height: deviceHeight * 0.013,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }
}

class ForgotPasswordOrIdButton extends StatelessWidget {
  const ForgotPasswordOrIdButton({
    Key key,
    @required this.deviceHeight,
    @required this.deviceWidth,
    @required this.onPressed,
  }) : super(key: key);

  final double deviceHeight;
  final double deviceWidth;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, deviceHeight * 0.032, 0, 0),
      height: deviceHeight * 0.08,
      width: deviceWidth * 0.725,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 67, 164, 210),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '다음',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
