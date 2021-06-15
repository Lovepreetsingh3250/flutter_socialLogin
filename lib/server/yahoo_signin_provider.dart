import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_plugin/server/serviceApi.dart';
import 'YahooAuth.dart';

class YahooSignInProvider {

  getToken({context,clientId,clientSecret,callbackUrl}) async {
    final code = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YahooAuth(clientId: clientId,callBackUrl: callbackUrl),
        ));
    if (code != null) {
      return callTokenApi(code,clientId,clientSecret,callbackUrl);
    }
  }

  callTokenApi(code,clientId,clientSecret,redirectUri) async {
    var params = {
      "client_id":clientId,
      "client_secret":clientSecret,
      "redirect_uri":redirectUri,
      "code":code.toString(),
      "grant_type":"authorization_code"
    };

    final url = "https://api.login.yahoo.com/oauth2/get_token";
    var result = await callApi("POST", params, url);

    print(result);
    var accessToken = result['access_token'];

    var dio = Dio();
    var userDetails = await dio.get("https://api.login.yahoo.com/openid/v1/userinfo",options: Options(headers: {"Authorization": "Bearer $accessToken"
    }));

    return userDetails;
  }

}