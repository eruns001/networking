import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/class/Post.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/NetworkingDrawer.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({
    Key key,
  }) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _initPostNum = 50; // 처음에 화면을 로드할 때 불러올 게시글 수
  final _morePostNum = 40; // 더보기 버튼을 눌렀을 때 불러올 게시글 수

  List<Post> _postList = new List<Post>(); // 게시글들을 저장할 리스트
  bool _isLoadingInit = false; // 페이지를 처음 불러올 때 true 가 되는 변수
  bool _isLoadingMore = false; // 더보기에서 데이터를 불러오는 중일 때 true 가 되는 변수
  int i = 0; // 테스트용으로 넣은 변수. 실제 데이터를 사용할 떄에는 삭제.

  /// 첫 데이터 로드하는 메서드
  void _loadInitData() async {
    int nowI = i; //  실제 데이터를 사용할 때에는 없어도 되는 구문.

    _isLoadingInit = true;

    await Future.delayed(Duration(seconds: 1));

    // 읽어들인 데이터에서 mapping을 해주는 구문.
    while (i < nowI + _initPostNum) {
      _postList.add(
        Post(
          profilePhoto: Image.asset('images/community_img_profile.png'),
          nickName: 'test',
          commentNum: 999,
          likeNum: 999,
          content: '이것은 테스트용 입니다. ${2000 - i++} 번째 글',
          postDate: DateTime(2021, 02, 17, 03, 20),
        ),
      );
    }

    setState(() {
      _isLoadingInit = false;
    });
  }

  /// 더보기 버튼을 눌렀을 때 데이터 로드하는 메서드
  void _loadMoreData() async {
    int nowI = i; //  실제 데이터를 사용할 때에는 없어도 되는 구문.

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(Duration(seconds: 2));

    // 읽어들인 데이터에서 mapping을 해주는 구문.
    while (i < nowI + _morePostNum) {
      _postList.add(
        Post(
          profilePhoto: Image.asset('images/community_img_profile.png'),
          nickName: 'test',
          commentNum: 999,
          likeNum: 999,
          content: '이것은 테스트용 입니다. ${2000 - i++} 번째 글',
          postDate: DateTime(2021, 02, 17, 03, 20),
        ),
      );
    }

    setState(() {
      _isLoadingMore = false;
    });
  }

  /// DateTime을 받아서 필요한 형식의 문자열을 반환하는 메서드
  String _returnDateTimeString(DateTime _dateTime) {
    return '${_dateTime.year}/${_dateTime.month}/${_dateTime.day}';
  }

  /// 처음에 페이지가 게시글들을 불러오는 동안 보일 화면을 빌드하는 메서드
  Widget _buildLoading(double _deviceHeight, double _deviceWidth) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          _deviceWidth * 0.055,
          _deviceHeight * 0.03,
          _deviceWidth * 0.055,
          0,
        ),
        controller: PrimaryScrollController.of(context),
        itemCount: _postList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index <= _postList.length - 1) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: _deviceHeight * 0.04,
                    //width: _deviceWidth * 0.891,
                    child: Row(
                      children: <Widget>[
                        Container(
                          /// 프로필 사진
                          width: _deviceWidth * 0.113,
                          child: _postList.elementAt(index).profilePhoto,
                        ),
                        Expanded(
                          child: Container(
                            /// 작성자 닉네임
                            //width: _deviceWidth * 0.782,
                            child: Text(
                              '${_postList.elementAt(index).nickName}',
                            ),
                          ),
                        ),
                        Container(
                          /// 댓글 수 및 좋아요 수
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(
                              0, 0, _deviceWidth * 0.02, 0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Icon(Icons.comment,
                                    size: _deviceHeight * 0.016),
                              ),
                              Container(
                                child: Text(
                                    ' ${_postList.elementAt(index).commentNum}'),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    _deviceWidth * 0.01, 0, 0, 0),
                                child: Icon(Icons.favorite,
                                    size: _deviceHeight * 0.016),
                              ),
                              Container(
                                child: Text(
                                    ' ${_postList.elementAt(index).likeNum}'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: _deviceHeight * 0.192,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            /// 게시글 내용
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(
                              _deviceWidth * 0.033,
                              _deviceHeight * 0.014,
                              _deviceWidth * 0.033,
                              0,
                            ),
                            child: Text(
                              _postList.elementAt(index).content,
                            ),
                          ),
                        ),
                        Container(
                          /// 게시글 작성일
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.fromLTRB(
                            0,
                            0,
                            _deviceWidth * 0.033,
                            _deviceHeight * 0.007,
                          ),
                          child: Text(_returnDateTimeString(
                              _postList.elementAt(index).postDate)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              /// 더보기 버튼
              height: 50,
              width: 30,
              child: (_isLoadingMore)
                  ? CupertinoActivityIndicator()
                  : FlatButton(
                child: Text('터치하여 더 불러오기'),
                onPressed: () {
                  _loadMoreData();
                },
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NetworkingAppBar(
        deviceHeight: _deviceHeight,
        deviceWidth: _deviceWidth,
        context: context,
        title: '커뮤니티',
        stackIndex: 1,
      ),
      body: (_isLoadingInit)
          ? _buildLoading(_deviceHeight, _deviceWidth)
          : _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}
