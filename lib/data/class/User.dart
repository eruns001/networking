import 'package:flutter/material.dart';

import 'Team.dart';

class User {
  /// 프로필 사진
  Image _image;

  /// 닉네임
  String _nickName;

  /// 별점
  double _rate;

  /// 이름
  String _name;

  /// 연락처
  String _phoneNum;

  /// 이메일
  String _email;

  /// 분야
  String _major;

  /// 경력
  String _career;

  /// 역할
  String _position;

  /// 주소 시, 군
  String _address;

  /// 팀에 속해 있는지
  bool _isJoinedTeam = false;

  /// 팀을 만든 사람인지
  bool _isMaster = false;

  /// 팀에 대한 정보
  Team _team;

  /// 포트폴리오 추가 필요
  /// 한줄 평 추가 필요 Post 를 확장해서 사용하면 될 듯.

  /// setter
  set setProfileImage(Image image) => {_image = image};
  set setNickName(String nickName) => {_nickName = nickName};
  set setRate(double rate) => {_rate = rate};
  set setName(String name) => {_name = name};
  set setPhoneNum(String phoneNum) => {_phoneNum = phoneNum};
  set setEmail(String email) => {_email = email};
  set setMajor(String major) => {_major = major};
  set setCareer(String career) => {_career = career};
  set setPosition(String position) => {_position = position};
  set setAddress(String address) => {_address = address};
  set setIsJoinedTeam(bool isJoinedTeam) => {_isJoinedTeam = isJoinedTeam};
  set setIsMaster(bool isMaster) => {_isMaster = isMaster};
  set setTeam(Team team) => {_team = team};

  /// getter
  get getProfileImage => _image;
  get getNickName => _nickName;
  get getRate => _rate;
  get getName => _name;
  get getPhoneNum => _phoneNum;
  get getEmail => _email;
  get getMajor => _major;
  get getCareer => _career;
  get getPosition => _position;
  get getAddress => _address;
  get getIsJoinedTeam => _isJoinedTeam;
  get getIsMaster => _isMaster;
  get getTeam => _team;
}