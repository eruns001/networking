
import 'package:flutter/material.dart';

class uqpContainer extends StatelessWidget {
  uqpContainer ({
    @required this.deviceWidth,
    @required this.deviceHeight,
    @required this.radius,
    @required this.textEditingController,
    this.margin,
    this.textInputType,
    this.hintText,
  }) : assert(margin == null || margin.isNonNegative);

  final double deviceWidth;
  final double deviceHeight;
  final double radius;
  final EdgeInsetsGeometry margin;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  String hintText;


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
        margin: margin,
        width: deviceWidth * 0.688,
        height: deviceHeight * 0.05,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color(0xff46abdb),
              width: 1),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x80cacaca),
                offset: Offset(0, -1),
                blurRadius: 16,
                spreadRadius: 2)
          ],
          color: const Color(0xffe3f3fa),
      ),
      child: Center(
        child: TextField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
            EdgeInsets.fromLTRB(deviceWidth * 0.05, 0, 0, 0),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      )
    );
  }
}