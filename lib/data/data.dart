
//radius
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'class/User.dart';

//로그인 유저
User userNow;

//UploadQuestionPage - uqp
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
FirebaseAuth auth;
final gooleSignIn = GoogleSignIn();
bool IsLogIn = false;

//datetime
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

///List
//시, 도
final List<String> addressList = ["서울특별시","부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"
  , "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"];
final List<String> searchAddressList = ["모든지역", "서울특별시","부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시"
  , "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"];
//역활
final List<String> roleList = ["SW 개발", "기획/PM/운영", "마케팅", "일러스트/디자인", "영상/인터넷 방송", "음악"];
final List<String> searchRoleList = ["모든역할", "SW 개발", "기획/PM/운영", "마케팅", "일러스트/디자인", "영상/인터넷 방송", "음악"];
//분야
final List<String> positionDeveloperList = ["모든분야", "서버/백엔드", "프론트엔드", "웹 풀스택", "안드로이드 앱", "아이폰 앱", "머신러닝"
  , "인공지능(AI)", "데이터 엔지니어", "모바일 게임", "게임 클라이언트", "게임 서비", "시스템/네트워크", "시스템 소프트웨어"
  , "인터넷 보안", "QA", "사물인터넷(IoT)", "응용 프로그램", "블록체인", "HW 개발"];
final List<String> positionPlannerList = ["모든분야", "사업기획", "서비스기획", "프로젝트관리", "서비스 운영", "고객관리", "데이터분석", "인사"];
final List<String> positionMarketingList = ["모든분야", "온라인 마케팅", "콘텐츠 마케팅", "디지털 마케팅", "소셜 마케팅", "바이럴 마케팅", "브랜드 마케팅"];
final List<String> positionDesignerList = ["모든분야", "게임 원화", "3D 디자인", "앱 디자인", "웹 디자인", "애니메이터", "웹툰 작가", "어시스턴트"];
final List<String> positionVideoList = ["모든분야", "BJ/스트리머", "유튜버", "편집자"];
final List<String> positionMusicList = ["모든분야", "작곡/프로듀서", "믹싱 엔지니어", "마스터링 엔지니어", "싱어송라이터", "작사가", "보컬/랩", "악기"];
final List<String> positionNullList = ["모든분야"];
List<String> positionList = positionNullList;

//didinit
Future<bool> didinit = Future<bool>.value(false);
GoogleSignIn _googleSignIn = new GoogleSignIn();

//SearchPage
String dropdownValueAddress = '모든지역';
String dropdownValueRole = '모든역할';
String dropdownValuePosition = '모든분야';
String dropdownValueNumber = '10';
int searchPageCounter = 0;

//url
String imageUrl = '';
String basicImageUrl ;

//TextStyle
TextStyle uqpHintTextStyle = TextStyle(
  color: const Color(0xff999999),
  fontWeight: FontWeight.w500,
  fontFamily: "NotoSansKR",
  fontStyle:  FontStyle.normal,
  fontSize: 16,
);