import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_r/models/user.dart';
import 'package:test_app_r/models/showcase.dart';
import 'package:test_app_r/util.dart';
import 'package:http_parser/http_parser.dart';
//final String URL = 'http://app2.test.planohero.com/api/auth/token/get/'; - done
//final String secondURL = 'http://app2.test.planohero.com/api/layout/library/'; - in progress...
// token JWT refresh_token (Get)

class Url {
  static const BASE_URL = 'http://app2.test.planohero.com/api/';

}

User user;

// login
class LoginApi {

  NetworkUtil _util = new NetworkUtil();
  static const LOGIN_URL = Url.BASE_URL + 'auth/token/get/';

  bool isLoginSuccessful() {
    if(user.refresh_token == null) return false;
    return true;
  }

  Future<User> login(String login, String password) {
    return _util.post(LOGIN_URL, body: {
      'username': login,
      'password': password
    }).then((dynamic res) {
      user = User.map(res);

      return new User.map(res);
    });
  }
}


// Ver 2


class HomeApi {
  Future<T> load<T>(Resourse<T> resourse, {headers}) async {
    final response = await http.get(resourse.url, headers: {
      'Authorization': "JWT ${user.refresh_token}"
    });
    print('loading...');
    if(response.statusCode == 200) {
      return resourse.parse(response);
    } else {
      throw Exception('Fail');
    }
  }

}

// Sending report on server
class SendReportApi {

  NetworkUtil _util = new NetworkUtil();
  static const REPORT_URL = Url.BASE_URL + 'layout/storages/';
  Dio dio = new Dio();
  JsonDecoder _decode = new JsonDecoder();

//  uploading report
  Future<dynamic> sendReport(File img) async {
    print('IMAGE ' + img.toString() + " " );
    print('URL ' + REPORT_URL);
  var uri = Uri.parse(REPORT_URL);
  var request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = "JWT ${user.refresh_token}"
    ..files.add(await http.MultipartFile.fromPath(
        'file', img.path,
      contentType: MediaType('image', 'png'))
    );

  var response = await request.send();
  var parsed = response.stream.bytesToString();
  parsed
      .then((value) {
        var temp = _decode.convert(value);
        print('ID ===>');
        print(temp['id']);
        return temp;
      });
  }
//  <================

//Assigning report to planogram

  void assignReport(Showcase sc, var res) {
    print(res['id']);
//    print(res['id']);
  }
}

