
import 'package:flutter/material.dart';

class net_Container extends StatelessWidget {
  net_Container ({
    @required this.net_width,
    @required this.net_height,
    @required this.radius,
    this.child,
    this.margin,
  }) : assert(margin == null || margin.isNonNegative);

  final double net_width;
  final double net_height;
  final double radius;
  final Widget child;
  final EdgeInsetsGeometry margin;


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      margin: margin,
      height: net_height,
      width: net_width,
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
      child: child
    );
  }
}