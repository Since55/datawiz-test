import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app_r/api.dart';
import 'package:test_app_r/models/showcase.dart';

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
    print(sc);

    print(arg.image);
    return Scaffold(
      appBar: AppBar(
        title: Text('Send report'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/3,
            child: Image.file(arg.image),
          ),
          FloatingActionButton(
            onPressed: () {
              var resp = sendRep.sendReport(arg.image);
              sendRep.assignReport(sc, resp);

            },
          )

        ],
      ),
    );
  }
}