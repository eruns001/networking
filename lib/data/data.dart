
//radius
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

final double UQP_radius_picadd = 20;
final double UQP_radius_textadd = 10;
final double UQP_radius_tag = 10;

//margin
final double UQP_margin_text = 5;

//height
final double UQP_height_text = 5;

//Icon
Widget UQP_icon_1st = Icon(
  CupertinoIcons.camera,
  color:  const Color(0xffffffff),
  size: 50,
);
var test_1st = CupertinoIcons.camera;
Widget test_temp = new Image.asset('images/search_btn_home.png');

//LogIn
String uid = "";
FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
