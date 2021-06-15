import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.Dart' as http;
import 'package:social_login_plugin/common/common.dart';
import 'dart:io';

Future<dynamic> callApi(String httpType, dynamic params, var url) async {
  var response;

  try {
    if (httpType == "GET") {
      response = await http.get(url);
      print('jsh');
    } else {
      //if encode then use convert.jsonEncode(params)
      response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: params);
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
    var jsonError = {
      kDataResult: "Server not responding. Please try again later",
      kDataCode: "500"
    };
    return jsonError;
  } on SocketException catch (_) {
    // Other exception
    var jsonError = {
      kDataResult: "Something went wrong. Please try again later.",
      kDataCode: "500"
    };
    return jsonError;
  }
  var jsonResponse;
  try {
    jsonResponse = convert.jsonDecode(response.body);
  } on Exception catch (_) {
    var jsonError = {
      kDataResult: "Something went wrong. Please try again later.",
      kDataCode: "500"
    };
    return jsonError;
  }
  if (jsonResponse!=null) {
    return jsonResponse;
  } else if (jsonResponse[kDataCode] == 401) {
    var jsonError = {kDataResult: jsonResponse[kDataResult], kDataCode: "401"};
    return jsonError;
  } else if (response[kDataCode] == 500) {
    var jsonError = {kDataResult: jsonResponse[kDataResult], kDataCode: "500"};
    Future.delayed(const Duration(milliseconds: 500), () {
//      RemoveSharedPreference(kDataLoginUser);
//      SetHomePage(0);
    });
    return jsonError;
  } else {
    var jsonError = {
      kDataResult: "Something went wrong. Please try again later.",
      kDataCode: "404"
    };
    return jsonError;
  }
}