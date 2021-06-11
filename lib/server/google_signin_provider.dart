import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  List<String> userDetails=[];
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future<dynamic> login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return null;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,

      );

      //showToast(context, user.displayName+"email - "+user.email);
      //print(user.toString());
      userDetails.add(user.displayName.toString());
      userDetails.add(user.email.toString());
      userDetails.add(user.photoUrl.toString());
      userDetails.add(user.id.toString());

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
      return userDetails;
    }
  }

  void logout(BuildContext context) async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

    //showToast(context, "Logged Out");
  }
}