import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortsio/views/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black38),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
