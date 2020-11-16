import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_app_r/models/showcase.dart';

class Report {
  List<dynamic> imageUrl;
  String comment;
  DateTime date;



  Report({this.date, this.comment, this.imageUrl});



 factory Report.fromJson(Map json){
   print('Report json: ' + json.toString());
   return Report(
       imageUrl: (json['photos'] ?? 'no reports'),
       comment: json['comment'],
       date: DateTime.parse(json['date_from'])
   );

  }

}

