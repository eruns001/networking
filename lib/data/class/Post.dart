import 'package:flutter/material.dart';

/// 게시글에 대한 클래스
class Post {
  /// 프로필 사진
  Image profilePhoto;

  /// 사용자 닉네임
  String nickName;

  /// 댓글 수
  int commentNum;

  /// 좋아요 수
  int likeNum;

  /// 게시글 내용
  String content;

  /// 게시글 작성일
  DateTime postDate;

  Post({
    @required this.profilePhoto,
    @required this.nickName,
    @required this.commentNum,
    @required this.likeNum,
    @required this.content,
    @required this.postDate,
  });
}