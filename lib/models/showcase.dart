import 'dart:convert';
import 'package:http/http.dart';

class Showcase {
   String imageUrl;
   String name;
   num stand;
   List planogram;

  Showcase({this.name, this.imageUrl, this.stand, this.planogram});

  Showcase.map(dynamic obj) {
    this.imageUrl = obj['image'];
    this.name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['image'] = imageUrl;
    return map;
  }

  static Resourse<List<Showcase>> get all {
    return Resourse(
      url: 'http://app2.test.planohero.com/api/layout/stands/library/',
      parse: (response) {
        final result = json.decode(response.body);
        Iterable list = result;
        return list.map((e) => Showcase.fromJson(e)).toList();
      }
    );
  }

  factory Showcase.fromJson(Map json) {
    return Showcase(
      name: json['name'],
      imageUrl: json['image'],
      stand: json['stand_id'],
      planogram: json['planograms']
    );
  }
}

class Resourse<T> {
  final String url;
  T Function(Response response) parse;

  Resourse({this.url, this.parse});
}
