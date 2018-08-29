import 'package:flutter/material.dart';
import 'dart:math';

class HeaderPage extends StatefulWidget {
  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<HeaderPage> {
  final controller = ScrollController();
  double headerHeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    headerHeight = 100.0;
    controller.addListener(() {
      double newHeight = 100.0 - controller.offset;
      if (newHeight >= 20.0 && newHeight <= 300.0) {
        setState(() {
          headerHeight = newHeight;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(HeaderPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LoginPage'),
        ),
        body: SafeArea(
          child: Text('hello'),
        ));
  }
}
