import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPwPage extends StatefulWidget {
  const NewPwPage({
    Key key,
  }) : super(key: key);

  @override
  _NewPwPageState createState() => _NewPwPageState();
}

class _NewPwPageState extends State<NewPwPage> {
  TextEditingController _pwController = new TextEditingController();
  TextEditingController _pwConfirmController = new TextEditingController();

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(_deviceWidth * 0.145, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                /// 새로운 패스워드를 작성해주세요
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.12, 0, 0),
                child: Text(
                  '새로운 패스워드를 작성해주세요.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              NewPwTemplate(
                /// 비밀번호
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.035,
                controller: _pwController,
                hint: '******',
                text: '비밀번호',
                onSubmitted: (String string) {},
                maxLength: 6,
              ),
              NewPwTemplate(
                /// 비밀번호 확인
                deviceHeight: _deviceHeight,
                deviceWidth: _deviceWidth,
                topMarginRatio: 0.03,
                controller: _pwConfirmController,
                hint: '******',
                text: '비밀번호 확인',
                onSubmitted: (String string) {},
                maxLength: 6,
              ),
              Container(
                /// 설명
                margin: EdgeInsets.fromLTRB(0, _deviceHeight * 0.04, 0, 0),
                width: _deviceWidth * 0.725,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('비밀번호는 6자리입니다.\n계정이 기억나지 않으시면, 위의 글을 클릭해주세요.\n도용이나 프로그림상의 문제가 발생 시 [메뉴] - [고객센터]를이용바랍니다.\n\n6자리의 영문/숫자 조합으로 만드세요. (대/소문자 구분, 공백은입력불가)\n\n다른사람이 쉽게 알아낼 수 없는 아이디, 비밀번호, 개인정보와 관련된 것들, 연속된 숫자/문자 등은 사용하지 않는 것을 권장합니다.\n\n비밀번호에 특수문자를 추가하지면 비밀번호가 더욱 안전해집니다.',
                      style: TextStyle(
                        fontSize: 10,
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
          Container(
            margin: EdgeInsets.fromLTRB(_deviceWidth * 0.03, 0, 0, 0),
            width: _deviceWidth * 0.045,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/newPw_btn_close.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            height: _deviceHeight * 0.019,
            width: _deviceWidth * 0.083,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Image.asset('images/newPw_btn_next.png'),
              onPressed: () {},
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
        elevation: 0.0,
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

class NewPwTemplate extends StatelessWidget {
  const NewPwTemplate({
    Key key,
    @required TextEditingController controller,
    @required this.deviceHeight,
    @required this.deviceWidth,
    @required this.topMarginRatio,
    @required this.text,
    @required this.hint,
    @required this.onSubmitted,
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
            margin: EdgeInsets.fromLTRB(0, deviceHeight * 0.015, 0, 0),
            height: deviceHeight * 0.08,
            width: deviceWidth * 0.725,
            child: TextField(
              controller: controller,
              inputFormatters: textInputFormatter,
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
