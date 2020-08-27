import 'package:flutter/material.dart';
import 'package:fluttersh/routes/application.dart';
import 'package:fluttersh/routes/routes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: (){
          Application.router.navigateTo(context, Routes.pages);
        }, child: Text('登录'),),
      )
    );
  }
}
