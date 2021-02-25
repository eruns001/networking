
//radius
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

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
bool IsLogIn = false;

//datetime
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

//시, 도
List<String> addressList = ["서울특별시","부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"
  , "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"];