import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:test_app_r/models/showcase.dart';

// Check if value is null or empty
bool isNullEmpty(String value) =>
    (value == null || value == '');

// Check status code
void checkStatusCode(statusCode) {
  if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }
}

class NetworkUtil {
  //  to make this class a Singleton(builds only necessary objects)
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  //  Class that helps to decode json
  final JsonDecoder _decoder = new JsonDecoder();

//  Get request
  Future<dynamic> get(String url, {headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      checkStatusCode(statusCode);
      var resp = json.decode(response.body);

      print(resp);
      return resp;
    });
  }



//  Post request
  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
           final String res = response.body;
           final int statusCode = response.statusCode;

           checkStatusCode(statusCode);
           return _decoder.convert(res);
    });
  }

}

List<Showcase> parseShowcase(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Showcase>((json) => Showcase.fromJson(json)).toList();
}



// delete if won't work


class ImageArgs {
  final File image;

  ImageArgs(this.image);
}

