import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:networking/data/data.dart';
import 'package:networking/widget/NetworkingAppBar.dart';
import 'package:networking/widget/net_Container.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';
import 'dart:io';

import 'SearchPage.dart';

///게시글 작성 페이지

class UploadQuestionPage extends StatefulWidget {
  @override
  _UploadQuestionState createState() => _UploadQuestionState();
}
class _UploadQuestionState extends State<UploadQuestionPage> {

  int _counter = 0;

  var _image;
  Widget temp_1st = UQP_icon_1st;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseUser _user;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _downloadURL = "upload";

  ///작성자
  String _uqpControllerWriter = uid;
  ///제목
  TextEditingController _uqpControllerTitle = new TextEditingController();
  ///요약
  TextEditingController _uqpControllerSummarize = new TextEditingController();
  ///내용
  TextEditingController _uqpControllerContents = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _prepareService();
  }
  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
    print('data: $uid');
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      temp_1st = Image.file(_image, );
    });

    StorageReference storageReference = _firebaseStorage.ref()
        .child('UploadQuestion')
        .child('${dateFormat.format(DateTime.now())}_${uid}_No$_counter.jpg');
    _counter ++;

    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot strageTask = await uploadTask.onComplete;
    strageTask.ref.getDownloadURL().then((value) {
      imageUrl = value;
    });

    if(uploadTask.isComplete){
      setState(() {
        _downloadURL = imageUrl;
      });
    }
  }

  bool _toastUQPIsNull() {
    String nullCase;
    bool UQPNull = false;
    if(_uqpControllerTitle.text.length == 0) {nullCase = "제목을 입력해주세요"; UQPNull = true;}
    else if(_uqpControllerContents.text.length == 0) {nullCase = "내용을 입력해주세요"; UQPNull = true;}

    ///비었을때 Toast
    if(UQPNull){
      Fluttertoast.showToast(
          msg: nullCase,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    return UQPNull;
  }
  Future _uqpPostUpload() async{
    var now = new DateTime.now();
    String nickName;
    String document = "${uid}__${now.toString()}";
    await Firestore.instance.collection('Account').document(uid).get().then((DocumentSnapshot ds) {
      nickName = ds.data["nickName"];
    });
    await Firestore.instance.collection('uqpPost').document(document).setData({
      'Writer_uid':uid,
      'Writer':nickName,
      'Title':_uqpControllerTitle.text,
      'Summarize':_uqpControllerSummarize.text,
      'Contents':_uqpControllerContents.text,
      'Time' : now.toString(),
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
      appBar: NetworkingAppBar(
        context: context,
        deviceHeight: _device_height,
        deviceWidth: _device_width,
        title: '게시글 작성하기',
        stackIndex: 1,
        rightButtonIcon: Container(
            width: _device_width * 0.073,
            child: FlatButton(
                child: Text(
                  "작성",
                  style: TextStyle( color: const Color(0xff46abdb),),
                ),
                onPressed: () async{
                  bool isNull = _toastUQPIsNull();
                  if(!isNull){
                    await _uqpPostUpload();
                    Navigator.pop(context);
                  }
                },
            ),
          ),
        leftButton: Container(
          margin: EdgeInsets.only(left: _device_width * 0.02),
          child: IconButton(
              icon: Icon(
                CupertinoIcons.chevron_left,
                color: const Color(0xff46abdb),
                size: 35,
              ),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ),
      ),

      body:SingleChildScrollView (
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///picRow
              /*
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
              */


              ///작성자 프로필사진 + 작성자 역할
              Container(
                child: FutureBuilder(
                    future: Firestore.instance.collection('Account').document(uid).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if (snapshot.data != null){
                        Map<String, dynamic> data = snapshot.data.data;
                        return Container(
                          margin: EdgeInsets.only(left: _device_width * 0.065, top: _device_height * 0.06),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  data["imageUrl"],
                                  loadingBuilder: (
                                      BuildContext context,
                                      Widget child,
                                      ImageChunkEvent event,
                                      ) {
                                    if (event == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CupertinoActivityIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Container(
                                child: Text(
                                  data["roll"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                margin: EdgeInsets.only(left: _device_width * 0.03),
                              )
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                ),
              ),
              ///제목 TextField
              Container(
                height: _device_height * 0.06,
                width:  _device_width * 0.871,
                margin: EdgeInsets.only(top: _device_height * 0.026),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xff999999),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x80cacaca),
                        offset: Offset(0, -1),
                        blurRadius: 16,
                        spreadRadius: 2)
                  ],
                  color: const Color(0xffffffff),
                ),
                child: TextField(
                  controller: _uqpControllerTitle,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                    EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                    hintText: '제목을 입력해 주세요',
                    hintStyle: uqpHintTextStyle,
                    border: InputBorder.none,
                  ),

                ),
              ),
              ///summary 요약
              Container(
                height: _device_height * 0.06,
                width:  _device_width * 0.871,
                margin: EdgeInsets.only(top: _device_height * 0.026),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xff999999),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x80cacaca),
                        offset: Offset(0, -1),
                        blurRadius: 16,
                        spreadRadius: 2)
                  ],
                  color: const Color(0xffffffff),
                ),
                child: TextField(
                  controller: _uqpControllerSummarize,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                    EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                    hintText: '요약 내용을 입력해 주세요',
                    hintStyle: uqpHintTextStyle,
                    border: InputBorder.none,
                  ),

                ),
              ),
              ///contant 내용
              Container(
                height: _device_height * 0.278,
                width:  _device_width * 0.871,
                margin: EdgeInsets.only(top: _device_height * 0.026),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xff999999),
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x80cacaca),
                        offset: Offset(0, -1),
                        blurRadius: 16,
                        spreadRadius: 2)
                  ],
                  color: const Color(0xffffffff),
                ),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _uqpControllerContents,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding:
                      EdgeInsets.fromLTRB(_device_width * 0.05, 0, 0, 0),
                      hintText: '게시글을 입력해 주세요',
                      hintStyle: uqpHintTextStyle,
                      border: InputBorder.none,
                    ),

                  ),
                )
              ),
            ],
          ),
        ),
      ),

    );
  }
}