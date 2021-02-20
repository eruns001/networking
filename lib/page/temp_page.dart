import 'package:flutter/material.dart';

class ClassName extends StatefulWidget {
  @override
  _classStateName createState() => _classStateName();
}

class _classStateName extends State<ClassName> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold();
  }
}