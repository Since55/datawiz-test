import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app_r/models/showcase.dart';
import 'package:test_app_r/pages/detail_page.dart';
import 'package:test_app_r/api.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<Showcase> _showcases = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadShowcases();

  }

  void _loadShowcases() {
    HomeApi().load(Showcase.all).then((showcase) =>{
      showcase.forEach((element) {
        element.name = utf8.decode(element.name.runes.toList());
      }),
      setState(()=>{
        _isLoading = false,
        _showcases = showcase,
      })
    });
  }

  Card _buildHomePageList(BuildContext, int index) {
    print(_showcases[index].planogram[0]['id']);
    return Card(
      child: InkWell(
        splashColor: Colors.grey,
        onTap: (){Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => DetailPage(),
            settings: RouteSettings(
              arguments: _showcases[index],
            )
          ));
        },
        child: Column(
          children: <Widget>[
            Text(_showcases[index].name),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Image.network(_showcases[index].imageUrl),
            )
          ],
        ),
      )
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planohero'),
        backgroundColor: Colors.black,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: _buildHomePageList,
            itemCount: _showcases.length,
          )
      ),
    );
  }
}