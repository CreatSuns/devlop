import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttersh/views/login.dart';
import 'package:fluttersh/views/root.dart';

var loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Login();
  },
);

var pagesHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return RootWidget();
  },
);