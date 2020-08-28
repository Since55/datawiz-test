import 'package:flutter/material.dart';
import 'package:test_app_r/pages/home_page.dart';
import 'package:test_app_r/pages/login_page.dart';
import 'package:test_app_r/pages/detail_page.dart';
import 'package:test_app_r/pages/take_picture_page.dart';

Future<void> main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planohero copy App',
      routes: routes,
//      home: Scaffold(
//        body: Center(
//          child: LoginPage(),
//        ),
//      ),
    );
  }
}

final routes = {
  '/': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/details': (BuildContext context) => DetailPage(),
//  '/camera': (BuildContext) => CameraApp()
};