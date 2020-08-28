////api/layout/storages/
//// Form Data => file
//// POST
//
////then
////api/layout/stand-photo-reports/
////post
//


// VERSION 2 ===========================================>


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app_r/models/showcase.dart';
import 'package:test_app_r/pages/send_report_page.dart';
import 'package:test_app_r/util.dart';

class PickImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PickImagePageState();
}

class PickImagePageState extends State<PickImagePage> {
  @override
  Widget build(BuildContext context) {

    Showcase showcase = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick image'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Pick from gallery'),
              onPressed: () => _pickImage(ImageSource.gallery, showcase),
            ),
            RaisedButton(
              child: Text('Pick from camera'),
              onPressed: () => _pickImage(ImageSource.camera, showcase),
            ),
          ],
        ),
      ),
    );
  }

  _pickImage(ImageSource imageSource, Showcase sc) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    if (image != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => SendReportPage(),
        settings: RouteSettings(
            arguments: [ImageArgs(image), sc]
        )
      ),
      );

    }
  }
}

