import 'package:flutter/material.dart';
import 'package:fluttersh/routes/application.dart';
import 'package:fluttersh/routes/routes.dart';
import 'package:fluttersh/views/advertising.dart';
import 'package:fluttersh/views/login.dart';
import 'package:fluttersh/views/root.dart';
import 'package:fluro/fluro.dart';

void main() {
  var router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Advertising(),
    );
  }
}
