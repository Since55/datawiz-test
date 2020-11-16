import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app_r/models/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app_r/api.dart';
import 'package:test_app_r/models/showcase.dart';

class ReportTile extends StatefulWidget {
  ReportTile({this.showcase});
  final showcase;

  @override
  State<StatefulWidget> createState() => ReportTileState();
}

class ReportTileState extends State<ReportTile> {
  List<Report> _reports = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  _loadReports() {
    ReportListApi.getReports(widget.showcase).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print('Report tile response body' + response.body);
        print('Decoded list of reports' + list.toString());
        _reports = list.map((e) => Report.fromJson(e)).toList();
        _isLoading = false;
      });
    });
    print(_reports);
  }

  _reportPhotos(num index){
    List<Container> photos = [];

    for(int i = 0; i < _reports[index].imageUrl.length; i++) {
      print("Image" + _reports[index].imageUrl.toString());
      for(int j = 0; j < _reports[index].imageUrl[i]['photos'].length; j++) {

        photos.add(Container(
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width/3,
          child: Image.network(_reports[index].imageUrl[i]['photos'][j]['file']),
        ));
      }


    }
    return Row(
      children: photos
    );
  }

_reportsList() {
// TODO: check if it works. {works ? beHappy() : dontBeSad();}
    return ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          print("Date: " + _reports[index].date.toString());
          return Card(
            margin: EdgeInsets.all(10),
            child: InkWell(
              splashColor: Colors.grey,
              onTap: (){
                print(_reports[index]);
//              TODO: implement report detail page (if needed)
              },
              child: Column(
                children: <Widget>[
                  Text('Report for:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(_reports[index].date.toString()),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _reportPhotos(index)
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.all(15),
//                          width: MediaQuery.of(context).size.width/3,
//                          child:
//                          Image.network(_reports[index].imageUrl),
//                        ),
//                      ],
//                    )
                  ),
                  Text('${_reports[index].comment ?? 'No comment'}')
                ],
              ),
            ),
          );
        }
    );
}
  _noReports() {
    return Center(
      child: Text("No reports", style:
        TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black38,
          fontSize: 35
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print('Showcase ====> ' + widget.showcase.name);
    print('Reports length ===> ' + _reports.length.toString());
    if(_isLoading) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      try{
        if(_reports[0].imageUrl.isNotEmpty) return _reportsList();
        return _noReports();
      } catch(e) {
        return _noReports();
      }
    }


  }



}