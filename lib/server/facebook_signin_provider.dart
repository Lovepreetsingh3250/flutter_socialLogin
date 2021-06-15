import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FbLogin {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  Future<dynamic> loginWithFB() async{

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        //print(profile);
        userProfile = profile;
        _isLoggedIn = true;

        return userProfile;

        break;

      case FacebookLoginStatus.cancelledByUser:
        _isLoggedIn = false;
        //showToast(context, "Logged In Cancelled");
        return null;
        //setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        _isLoggedIn = false;
        //showToast(context, "Logged In Error");
        return null;
        //setState(() => _isLoggedIn = false );
        break;

      default:
        return null;
        break;
    }

  }

  logout(BuildContext context){
    facebookLogin.logOut();
    _isLoggedIn = false;
   // showToast(context, "Logged Out");
    /*setState(() {
      _isLoggedIn = false;
    });*/
  }
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}