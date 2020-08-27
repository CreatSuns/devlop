
import 'package:flutter/services.dart';

enum NativeWebViewBehavior{
  jump,

}

class NativeWebView{
  static const MethodChannel _channel = const MethodChannel('screenShot');
  static Future<dynamic> takeScreenShot(String url) async {
    return await _channel.invokeMethod('takeScreenShot', {"url":url});
  }
}