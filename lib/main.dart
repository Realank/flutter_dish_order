import 'package:flutter/material.dart';
import 'package:flutter_dish_order/pages/LoginPage.dart';
import 'package:flutter_dish_order/pages/Header.dart';
import 'resources/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: Builder(builder: (context) {
        return LoginPage();
      }),
    );
  }
}
