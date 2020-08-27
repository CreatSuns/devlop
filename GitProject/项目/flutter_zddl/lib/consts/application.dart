import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_zddl/commons/base_color.dart';
import 'package:flutter_zddl/debug/log_until.dart';
import 'package:flutter_zddl/untils/native_notification.dart';

enum ENV {
  PRODUCTION,
  DEV,
}

//enum DynamicModel{
//
//}

class Application {
  static ENV env = ENV.DEV;

  static Router router;
  static NativeNotification notification;

  static LogUtil log;

  static Header getHeader() {
    return ClassicalHeader(
      bgColor: Colors.white,
      refreshText: "下拉可以刷新",
      refreshReadyText: "释放立即刷新",
      textColor: c333333,
      showInfo: false,
      refreshingText: "正在刷新...",
      refreshedText: "刷新完成",
      refreshFailedText: "刷新失败",
    );
  }
}
