import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_r/models/showcase.dart';
import 'package:test_app_r/modules/report_tile.dart';
import 'package:test_app_r/pages/take_picture_page.dart';


class DetailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final controller = PageController(
    initialPage: 0
  );


  @override
  Widget build(BuildContext context) {

    Showcase showcase = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(showcase.name),
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Image.network(showcase.imageUrl, width: MediaQuery.of(context).size.width),
                  ),
                  Container(
                      width: double.maxFinite,
                      child:  Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          showcase.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PickImagePage(),
                        settings: RouteSettings(
                            arguments: showcase
                        )
                    ));
                  },
                  backgroundColor: Colors.black,
                  child: Icon(Icons.camera),
                  shape: CircleBorder(),
                ),
              )
            ],
          ),
          ReportTile(showcase: showcase)

        ],
      )



    );
  }
}