import 'package:flutter/services.dart';

class KeyboardEvent{
  KeyboardEvent();
  // 监听原生的键盘高度变化
  static const EventChannel eventChannel = EventChannel('keyboardHeight');
  // 告知原生添加监听
  static const MethodChannel methodChannel = MethodChannel('keyboardNotic');

  // 告知原生移除键盘监听
  static Future<bool> addKeyboardObserver()async{
    var result;
    try{
      result = await methodChannel.invokeMethod('addKeyboardObserver');
      return Future.value(result);
    }catch(e){
      return Future.error(e.toString());
    }
  }

  static Future<bool> addKeyboardRemoveObserver()async{
    var result;
    try{
      result = await methodChannel.invokeMethod('removeKeyboardObserver');
      return Future.value(result);
    }catch(e){
      return Future.error(e.toString());
    }
  }


  static void addListen<T>(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}){
    eventChannel.receiveBroadcastStream().listen(onData, onError: onError);
  }
}