import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:networking/data/data.dart';
import 'package:networking/widget/net_Container.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'main.dart';
import 'dart:io';

class UploadQuestionPage extends StatefulWidget {
  @override
  _UploadQuestionState createState() => _UploadQuestionState();
}
class _UploadQuestionState extends State<UploadQuestionPage> {

  int _counter = 0;

  var _image = null;
  Widget temp_1st = UQP_icon_1st;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseUser _user;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _downloadURL = "upload";

  @override
  void initState() {
    super.initState();
    _prepareService();
  }
  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
    log('data: ${_user.uid}');
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      temp_1st = Image.file(_image, );
    });
    log('data: 1');
    StorageReference storageReference = _firebaseStorage.ref().child('test').child('path${_counter}.jpg');
    _counter ++;
    log('data: 2');
    StorageUploadTask uploadTask = storageReference.putFile(image);

    StorageTaskSnapshot stragetask = await uploadTask.onComplete;
    log('data: 3');
    String downloadURL = await stragetask.ref.getDownloadURL();

    log('data: 4');
    if(uploadTask.isComplete){
      setState(() {
        _downloadURL = downloadURL;
        log('data: 5');
      });
    }
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
                      onPressed: (){
                      }),
                  new Flexible(
                    child:
                    TextFormField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: _downloadURL,
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
                      onPressed: (){

                      }
                  ),
                ],
              ),
            )
        ),
      ),
      body:SingleChildScrollView (
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //picRow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  net_Container(
                    child: IconButton(
                      icon: temp_1st,
                      onPressed: () async{
                        _getImage();
                      },
                    ),
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (24.9/100),
                    net_height: _device_height * (12.1/100),
                    radius: UQP_radius_picadd,
                  ),
                  net_Container(
                    child: Icon(
                      CupertinoIcons.plus,
                      color: const Color(0xff46abdb),
                      size: 50,
                    ),
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (24.9/100),
                    net_height: _device_height * (12.1/100),
                    radius: UQP_radius_picadd,
                  ),
                  net_Container(
                    child: Icon(
                      CupertinoIcons.plus,
                      color:  const Color(0xff46abdb),
                      size: 50,
                    ),
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (24.9/100),
                    net_height: _device_height * (12.1/100),
                    radius: UQP_radius_picadd,
                  ),
                ],
              ),
              SizedBox(
                height: _device_width * (UQP_margin_text/100),
              ),
              //titleRow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "제목",
                    style: TextStyle(
                      color: const Color(0xff99c8df),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 20,
                    ), //textAlign: TextAlign.center
                  ),
                  net_Container(
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (68.8/100),
                    net_height: _device_height * (UQP_height_text/100),
                    radius: UQP_radius_textadd,
                  ),
                ],
              ),
              SizedBox(
                height: _device_width * (UQP_margin_text/100),
              ),
              //summaryRow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "요약",
                    style: TextStyle(
                      color: const Color(0xff99c8df),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 20,
                    ), //textAlign: TextAlign.center
                  ),
                  net_Container(
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (68.8/100),
                    net_height: _device_height * (UQP_height_text/100),
                    radius: UQP_radius_textadd,
                  ),
                ],
              ),
              SizedBox(
                height: _device_width * (UQP_margin_text/100),
              ),
              //contantRow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "내용",
                    style: TextStyle(
                      color: const Color(0xff99c8df),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 20,
                    ), //textAlign: TextAlign.center
                  ),
                  net_Container(
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (68.8/100),
                    net_height: _device_height * (23.0/100),
                    radius: UQP_radius_textadd,
                  ),
                ],
              ),
              SizedBox(
                height: _device_width * (UQP_margin_text/100),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [//4.8
                  Text(
                    "태그",
                    style: TextStyle(
                      color: const Color(0xff99c8df),
                      fontWeight: FontWeight.w500,
                      fontFamily: "NotoSansKR",
                      fontStyle:  FontStyle.normal,
                      fontSize: 20,
                    ), //textAlign: TextAlign.center
                  ),
                  net_Container(
                    margin: new EdgeInsets.symmetric(horizontal: _device_width * (0.9/100)),
                    net_width: _device_width * (68.8/100),
                    net_height: _device_height * (UQP_height_text/100),
                    radius: UQP_radius_textadd,
                  ),
                ],
              ),
            ],
          ),
        ),
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
}

