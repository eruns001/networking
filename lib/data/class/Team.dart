import 'Member.dart';

/// 팀의 정보를 담을 클래스
class Team {
  /// 팀 이름
  String teamName;

  /// 주제
  String subject;

  /// 기획
  List<Member> planning = new List<Member>();

  /// 디자인
  List<Member> design = new List<Member>();

  /// 마케팅
  List<Member> marketing = new List<Member>();

  /// 개발
  List<Member> development = new List<Member>();

  /// 생성일
  DateTime anniversary;
}