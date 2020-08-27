import 'package:flutter/services.dart';

enum NativeNotificationMethodType {
  getNotificationState,

}

typedef NativeNotificationCallback = Future Function(dynamic message);

class NativeNotification {

  NativeNotification({this.callback});
  NativeNotificationCallback callback;

  static const messageChannel = const BasicMessageChannel(
      'flutter_and_native_notification', StandardMessageCodec());

  /// 发送消息
  /// 返回格式：{'state': 1, 'msg':'成功', 'data': {}}
  static Future<Map> sendMessage(NativeNotificationMethodType type) async {
    var arguments;
    switch (type){
      case NativeNotificationMethodType.getNotificationState:
        arguments = 'getNotificationState';
        break;
    }

    Map reply = await messageChannel.send(arguments);

    return reply;
  }

  void receiveMessage() {
    messageChannel.setMessageHandler(this.callback);
  }
}