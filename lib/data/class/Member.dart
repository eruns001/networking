import 'package:flutter/material.dart';

/// 팀에 들어갈 멤버들을 저장할 클래스
class Member {
  /// 멤버 이름
  String name;

  /// 멤버 연락처
  String phoneNum;

  /// 멤버 포지션
  String position;

  /// 멤버 이메일
  String email;

  Member({
    @required this.name,
    @required this.phoneNum,
    @required this.position,
    @required this.email,
  });
}
