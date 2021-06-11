
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_login_plugin/server/facebook_signin_provider.dart';

class SocialLoginPlugin {
  static const MethodChannel _channel =
      const MethodChannel('social_login_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello Plugin"),
    );
  }
}

class FLogin{
  Future facebookLogin() async {
    //final provider = FbLogin();
    var rest = await FbLogin().loginWithFB();
    return rest;
  }
}

