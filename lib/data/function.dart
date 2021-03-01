import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:networking/data/data.dart';
import 'dart:io';

import 'package:networking/page/SearchPage.dart';

Future<String> network_function_getImage(String where, int _counter) async{
  File image = await ImagePicker.pickImage(source: ImageSource.gallery);

  StorageReference storageReference = FirebaseStorage.instance.ref()
      .child(where)
      .child(uid)
      .child('${dateFormat.format(DateTime.now())}_${uid}_No$_counter.jpg');
  _counter ++;

  StorageUploadTask uploadTask = storageReference.putFile(image);
  StorageTaskSnapshot strageTask = await uploadTask.onComplete;
  String downloadURL = await strageTask.ref.getDownloadURL();

  return downloadURL;
  /*
  if(uploadTask.isComplete){
    setState(() {
      _downloadURL = downloadURL;
    });
  }*/
}

Future<bool> googleSingIn () async{
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if( googleSignInAccount != null){
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    AuthResult result = await auth.signInWithCredential(credential);

    //FirebaseUser user = await auth.currentUser();
    FirebaseUser user = result.user;
    print("user.uid : ${user.uid}");
    uid = user.uid;
    return Future.value(true);
    //집가자.
    //https://youtu.be/LLmg_n-EdWg?t=658
  }
}

Future<bool> signin(String email, String password) async {
  try{
    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    //FirebaseUser user = result.user;

    return Future.value(true);
  } catch(e){
    switch(e.code){
      case 'ERROR_INVALID_EMAIL':
        print('error_signin : ERROR_INVALID_EMAIL');
    }
  }
}

Future<bool> signup(String email, String password) async {
  try{
    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    //FirebaseUser user = result.user;

    return Future.value(true);
  } catch(e){
    switch(e.code){
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        print('error_signup : ERROR_EMAIL_ALREADY_IN_USE');
    }
  }
}

///로그아웃
Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();

  if(user.providerData[1].providerId == 'google.com'){
    await gooleSignIn.disconnect();
  }
  await auth.signOut();

  return Future.value(false);
}

///회원탈퇴
Future<bool> WithdrawalUser() async {
  FirebaseUser user = await auth.currentUser();
  user.delete();
  if(user.providerData[1].providerId == 'google.com'){
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  user = null;
  return Future.value(false);
}

///회원가입 된 상태인지 확인
void IsLogin() {
  var docRef = Firestore.instance.collection('Account').document(uid);
  docRef.get();
}


///init
Future<bool> setuid()async{
  print("setuid");
  FirebaseAuth.instance.currentUser().then((value) {
    print("value : $value");
    uid = value.uid;
  });
  return Future<bool>.value(true);
}

///SearchPage
List<String> setPositionList(Role) {
  List<String> PositionList = positionNullList;
  switch(Role){
    case "모든역할":
      PositionList= positionNullList;
      break;
    case "SW 개발":
      PositionList= positionDeveloperList;
      break;
    case "기획/PM/운영":
      PositionList= positionPlannerList;
      break;
    case "마케팅":
      PositionList= positionMarketingList;
      break;
    case "일러스트/디자인":
      PositionList = positionDesignerList;
      break;
    case "영상/인터넷 방송":
      PositionList = positionVideoList;
      break;
    case "음악":
      PositionList = positionMusicList;
      break;
  }
  return PositionList;
}

///로그인 이후 회원정보 받아오기
Future getAccount() async{


}