//[{stand_id: 51747, date_from: "2020-08-28T12:44:32.092168", date_to: null,…},…]
//0: {stand_id: 51747, date_from: "2020-08-28T12:44:32.092168", date_to: null,…}
//date_from: "2020-08-28T12:44:32.092168"
//date_to: null
//photos: [{date: "2020-08-28", comment: "",…}]
//0: {date: "2020-08-28", comment: "",…}
//comment: ""
//date: "2020-08-28"
//photos: [{file: "https://app.planohero.com/media/2/storage/2020-08-28_9-17-31_pilcPnB.png",…}]
//0: {file: "https://app.planohero.com/media/2/storage/2020-08-28_9-17-31_pilcPnB.png",…}
//file: "https://app.planohero.com/media/2/storage/2020-08-28_9-17-31_pilcPnB.png"
//name: "2020-08-28_9-17-31_pilcPnB"
//photos_names: ["2020-08-28_9-17-31_pilcPnB"]
//0: "2020-08-28_9-17-31_pilcPnB"
//stand_id: 51747

import 'package:flutter/material.dart';
import 'package:test_app_r/api.dart';
import 'package:test_app_r/models/showcase.dart';
import 'package:test_app_r/pages/detail_page.dart';

import 'package:test_app_r/util.dart' as util;

class SendReportPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SendReportPageState();
}

class SendReportPageState extends State<SendReportPage> {


  SendReportApi sendRep = new SendReportApi();

  @override
  Widget build(BuildContext context) {
    final List args = ModalRoute.of(context).settings.arguments;

    final util.ImageArgs arg = args[0];
    final Showcase sc = args[1];

    print(arg.image);
    return Scaffold(
      appBar: AppBar(
        title: Text('Send report'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width/3,
                        child: Image.file(arg.image),
                      ),
                    ],
                  ),
                ],
              )

            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.send),
              onPressed: () {
                print('SC STAND' + sc.stand.toString());
                sendRep.sendReport(arg.image, sc);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          )
        ],
      )


    );
  }
}