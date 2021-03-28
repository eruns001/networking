import 'package:flutter/material.dart';

import 'Team.dart';

class User {
  User({
  this.imageUrl,
  this.nickName,
  this.name,
  this.phoneNum,
  this.email,
  this.career,
  this.birth,
  this.roll,
  this.position,
  this.address,
  });

  ///이미지
  final String imageUrl;
  ///닉네임
  final String nickName;
  ///이름
  final String name;
  ///전화
  final String phoneNum;
  ///이메일
  final String email;
  ///경력
  final String career;
  ///생일
  final String birth;
  ///역할
  final String roll;
  ///분야
  final String position;
  ///주소
  final String address;
  /// 포트폴리오 추가 필요
  /// 한줄 평 추가 필요 Post 를 확장해서 사용하면 될 듯.

  /*
  /// setter
  set setProfileImage(String imageUrl) => {_imageUrl = imageUrl};
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
   */

  /// getter
  get getImageUrl => imageUrl;
  get getNickName => nickName;
  get getName => name;
  get getPhoneNum => phoneNum;
  get getEmail => email;
  get getCareer => career;
  get getBirth => birth;
  get getRoll => roll;
  get getPosition => position;
  get getAddress => address;
}