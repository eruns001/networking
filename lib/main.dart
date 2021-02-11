import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/UploadQuestionPage.dart';

import 'ForgotPasswordOrIdPage.dart';

//전역변수
//searchTextEditingController
TextEditingController searchTextEditingController = TextEditingController();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String dropdownValue = 'One';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
      appBar: PreferredSize(
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
                  IconButton(
                      padding: EdgeInsets.only(left: 30, right: 25),
                      icon: Icon(
                        CupertinoIcons.bars,
                        color: const Color(0xff46abdb),
                        size: 50,
                      ),
                      onPressed: null),
                  new Flexible(
                    child: TextFormField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: '$_counter', //'검색어를 입력해 주세요.',
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
      body: IndexedStack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(
                            () {
                              dropdownValue = newValue;
                            },
                          );
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  for (var a = 0; a < _counter; a++)
                    temp(_device_width, _device_height),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: 50,
              color: const Color(0xff46abdb),
              icon: new Image.asset('images/search_btn_home.png'),
              onPressed: null,
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_insert_user.png'),
              onPressed: () {
                /// 계정찾기 페이지 테스트용으로 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ForgotPasswordOrIdPage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_search.png'),
              onPressed: null,
            ),
            IconButton(
              iconSize: 50,
              icon: new Image.asset('images/search_btn_mypage.png'),
              onPressed: null,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
