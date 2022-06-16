import 'package:flutter/material.dart';
import 'package:googlesheets/page1.dart';

import 'GooglesheetCode.dart';



void main() async {

  await SheetsFlutter.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}