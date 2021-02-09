import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget networking_scaffold(searchTextEditingController, body_widget){
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
          centerTitle: true,
          titleSpacing: -5,
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
          automaticallyImplyLeading: false,
          title:SizedBox(
            height: 500,
            child: Row(
              children: <Widget>[
                IconButton(
                    padding: EdgeInsets.only(left: 30, right: 25),
                    icon: Icon(
                      CupertinoIcons.bars,
                      color:  const Color(0xff46abdb),
                      size: 50,
                    ),
                    onPressed: null
                ),
                new Flexible(
                  child:
                  TextFormField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      hintText: '검색어를 입력해 주세요.',
                      hintStyle:TextStyle(
                        color: const Color(0xffa2d5ed),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xff46abdb))
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.search,
                        color:  const Color(0xff46abdb),
                        size: 30,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xffa2d5ed),
                    ),
                    onFieldSubmitted: null,
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.only(left: 20, right: 25),
                    icon: Icon(
                      CupertinoIcons.doc,
                      color:  const Color(0xff46abdb),
                      size: 40,
                    ),
                    onPressed: null
                ),
              ],
            ),
          )
      ),
    ),
    body: body_widget,
    bottomNavigationBar: Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              iconSize: 50,
              color: const Color(0xff46abdb),
              icon: new Image.asset('images/search_btn_home.png'),
              onPressed: null),
          IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_insert_user.png'),
              onPressed: null),
          IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_search.png'),
              onPressed: null),
          IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_mypage.png'),
              onPressed: null),
        ],
      ),
    ),// This trailing comma makes auto-formatting nicer for build methods.
  );
}