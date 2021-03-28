
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/data/data.dart';
import 'package:networking/data/function.dart';
import 'package:networking/widget/NetworkingAppBar.dart';

import 'UploadQuestionPage.dart';

/// 2021-02-24 21:45
/// main.dart 파일의 정리를 위해서 검색 페이지 분리

//전역변수
//searchTextEditingController
TextEditingController searchTextEditingController = TextEditingController();

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      searchPageCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //화면 크기 체크
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: NetworkingAppBar(context: context, deviceHeight: _device_height, deviceWidth: _device_width, title: null, stackIndex: 0),
      /*
      PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
            brightness: Brightness.light,
            centerTitle: true,
            titleSpacing: -5,
            backgroundColor: Colors.white.withOpacity(0.0),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 500,
              child: Row(
                children: <Widget>[
                  ///선 세개
                  IconButton(
                      padding: EdgeInsets.only(left: 30, right: 25),
                      icon: Icon(
                        CupertinoIcons.bars,
                        color: const Color(0xff46abdb),
                        size: 50,
                      ),
                      onPressed: (){
                        //Scaffold.of(context).openDrawer();
                      }),
                  ///검색창
                  new Flexible(
                    child: TextFormField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: '$searchPageCounter', //'검색어를 입력해 주세요.',
                        hintStyle: TextStyle(
                          color: const Color(0xffa2d5ed),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: const Color(0xff46abdb))),
                        suffixIcon: Icon(
                          CupertinoIcons.search,
                          color: const Color(0xff46abdb),
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
                  ///새글
                  IconButton(
                      padding: EdgeInsets.only(left: 20, right: 25),
                      icon: Icon(
                        CupertinoIcons.doc,
                        color: const Color(0xff46abdb),
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadQuestionPage()),
                        );
                      }),
                ],
              ),
            )),
      ),
      */
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///Dropdown - 위치
                  DropdownButton<String>(
                    value: dropdownValueAddress,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValueAddress = newValue;
                      });
                    },
                    items: searchAddressList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ///Dropdown - 역할
                  DropdownButton<String>(
                    value: dropdownValueRole,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValueRole = newValue;
                        positionList = setPositionList(dropdownValueRole);
                      });
                    },
                    items: searchRoleList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  /*
                  ///Dropdown - 분야
                  DropdownButton<String>(
                    value: dropdownValuePosition,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValuePosition = newValue;
                      });
                    },
                    items: positionList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                   */
                  ///Dropdown - 갯수
                  DropdownButton<String>(
                    value: dropdownValueNumber,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValueNumber = newValue;
                      },
                      );
                    },
                    items: <String>['10', '20', '30', '40']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                ],
              ),
              for (var a = 0; a < searchPageCounter; a++)
                temp(_device_width, _device_height),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
      ),
    );
  }
}

Widget temp(_device_width, _device_height) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: _device_width * (38.4 / 100),
          height: _device_height * (18.4 / 100),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff46abdb), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x80cacaca),
                    offset: Offset(0, -1),
                    blurRadius: 16,
                    spreadRadius: 2)
              ],
              color: Colors.white),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: _device_width * (38.4 / 100),
          height: _device_height * (18.4 / 100),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff46abdb), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x80cacaca),
                    offset: Offset(0, -1),
                    blurRadius: 16,
                    spreadRadius: 2)
              ],
              color: Colors.white),
        ),
        //Image.asset('images/search_btn_home.png'),
      ],
    ),
  );
}
/*
Widget searchItem(String dropdownValueNumber, int limitNum) {
  int dropDownVal = int.parse(dropdownValueNumber);
  CollectionReference postRef = Firestore.instance.collection('uqpPost');
  Query first = postRef.orderBy('Time').limit(limitNum);

  //first.getDocuments().asStream();
  //Query next =  first.startAfter(first.getDocuments()); //postRef.orderBy('Time').startAfter(first.snapshots().last);

  DocumentSnapshot documentSnapshot;

  return StreamBuilder(
    stream: first.snapshots(),
    builder: ( context, snapshot){
      if(!snapshot.hasData){
        return CircularProgressIndicator();
      }
      List<DocumentSnapshot> documents = snapshot.data.documents;
      return ListView(
        padding:EdgeInsets.only(top: 20.0),
        children: documents.map((e) => null),
      );
      //children: documents.map((eachDocument) => DocumentView(eachDocument)).toList(),);
    },
  );

}

 */