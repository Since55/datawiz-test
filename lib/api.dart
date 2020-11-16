import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
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
//TODO: replace all urls!

}

User user;

// login
class LoginApi {
  NetworkUtil _util = new NetworkUtil();
  static const LOGIN_URL = Url.BASE_URL + 'auth/token/get/';

  bool isLoginSuccessful(BuildContext context) {
    try{
      if(user.refresh_token != null) {
        print('successfully logged in');
        Navigator.pushNamed(context, '/home');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User> login(String login, String password, BuildContext context) {
    print('login data sent');
    return _util.post(LOGIN_URL, body: {
      'username': login,
      'password': password
    }).then((dynamic res) {
      user = User.map(res);
      isLoginSuccessful(context);
      return new User.map(res);
    });
  }
}


class ReportListApi {

  static Future getReports(Showcase sc) {
    final GET_REPORTS_URL = Url.BASE_URL + 'layout/stands/${sc.stand}/planogramlife/?planogram_id=${sc.planogram[0]['id']}';

    var response = http.get(
        GET_REPORTS_URL,
        headers: {
          'Authorization': "JWT ${user.refresh_token}"
        }
    );
    
    print('getReports response:' + response.toString());
    return response;
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
  dynamic sendReport(File img, Showcase sc) async {
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
        print(temp);
        assignReport(sc, temp);

        return temp;
       });
      }


//Assigning report to planogram -------->
  void assignReport(Showcase sc, var res) async {
    Dio dio = new Dio();

    const ASSIGN_URL = Url.BASE_URL + 'layout/stand-photo-reports/';

    var response = await dio.post(ASSIGN_URL,
        options: Options(
          headers: {
            'Authorization': "JWT ${user.refresh_token}",
          },
        ),
        data: {
          'files': [
            {
              'id': res['id'],
              'file': res['file']
            }
          ],
          'photos': [res['id']],
          'planogram': sc.planogram[0]['id'],
          'stand': sc.stand
        }
    );
    print('Assigned ====>');
    print(response.request.data);
    print(response.data);

  }
}
//  <================




