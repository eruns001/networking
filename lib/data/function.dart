import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:networking/data/data.dart';
import 'dart:io';

Future network_function_getImage(String where, int _counter) async{
  File image = await ImagePicker.pickImage(source: ImageSource.gallery);

  StorageReference storageReference = FirebaseStorage.instance.ref()
      .child(where)
      .child('${dateFormat.format(DateTime.now())}_${uid}_No$_counter.jpg');
  _counter ++;

  StorageUploadTask uploadTask = storageReference.putFile(image);
  StorageTaskSnapshot strageTask = await uploadTask.onComplete;
  String downloadURL = await strageTask.ref.getDownloadURL();


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

    FirebaseUser user = await auth.currentUser();
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

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  if(user.providerData[1].providerId == 'google.com'){
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(false);
}

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

