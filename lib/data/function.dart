import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

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
    log("user.uid : ${user.uid}");
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