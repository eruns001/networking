import 'package:flutter/material.dart';

class Nullpage extends StatefulWidget {
  @override
  nullstate createState() => nullstate();
}

class nullstate extends State<Nullpage> {
  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Text(
          "준비중입니다."
        ),
      ),
    );
  }
}