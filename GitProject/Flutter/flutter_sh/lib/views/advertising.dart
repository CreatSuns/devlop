import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersh/routes/application.dart';
import 'package:fluttersh/routes/routes.dart';

class Advertising extends StatefulWidget {
  @override
  _AdvertisingState createState() => _AdvertisingState();
}

class _AdvertisingState extends State<Advertising> {
  Timer _timer;
  int number = 3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      number --;
      setState(() {
      });
      if (number == 0) {
        Application.router.navigateTo(context, Routes.login);
      }
    });
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    number = 3;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('广告页$number s'),
        ),
      ),
    );
  }
}
