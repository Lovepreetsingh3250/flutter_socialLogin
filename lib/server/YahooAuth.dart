import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YahooAuth extends StatefulWidget {
  final clientId;
  final callBackUrl;
  final scope;

  const YahooAuth({Key key, this.clientId, this.callBackUrl, this.scope="openid"}) : super(key: key);
  @override
  _LinkedInAuthState createState() => _LinkedInAuthState();
}

class _LinkedInAuthState extends State<YahooAuth> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yahoo Login'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl:
          //'https://api.login.yahoo.com/oauth2/request_auth?client_id=dj0yJmk9VDZsTEt4YUUxT2NOJmQ9WVdrOWVrbHJVbXBXTjI0bWNHbzlNQT09JnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTIz&redirect_uri=https://socialplugin.cloudns.cl&response_type=code&scope=openid',
          'https://api.login.yahoo.com/oauth2/request_auth?client_id=${widget.clientId}&redirect_uri=${widget.callBackUrl}&response_type=code&scope=${widget.scope}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) {
            if (url.startsWith(widget.callBackUrl)) {
              Navigator.pop(
                context,
                url.toString().substring(url.lastIndexOf("=") + 1),
              );
            }
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}