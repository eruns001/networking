import 'package:flutter/material.dart';
import 'package:networking/widget/NetworkingAppBar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return Container(
      child: Center(
        child: Container(
          width: _deviceWidth * 0.7,
          child: Image.asset('images/loginLayout_logo.png'),
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
        title: '홈',
        stackIndex: 1,
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}