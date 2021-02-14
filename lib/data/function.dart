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