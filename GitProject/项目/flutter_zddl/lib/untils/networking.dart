import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_zddl/debug/debug_print.dart';
import 'package:toast/toast.dart';

class BaseUrl {
  // 配置默认请求地址
  static const String url = 'https://zdds-wap.ruishan666.com/';
}

typedef DownloadProgressCallback = Function(double count);
typedef UploadProgressCallback = Function(double count);

class HttpQuerery {
  static Future get(String url,
      {Map<String, dynamic> data, Map<String, dynamic> headers}) async {
    // 数据拼接
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('${key}=${value}&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }

    // 发送get请求
    return await _sendRequest(url, 'get', data: data, headers: headers);
  }

  static Future post(String url,
      {dynamic data, Map<String, dynamic> headers}) async {
    // 发送post请求
    return await _sendRequest(url, 'post', data: data, headers: headers);
  }

  // 请求处理
  static Future _sendRequest(String url, String method,
      {dynamic data, Map<String, dynamic> headers}) async {
    int _code;
    String _msg;

    // 检测请求地址是否是完整地址
    if (!url.startsWith('http') || !url.startsWith('https')) {
      url = BaseUrl.url + url;
    }

    try {
      Map<String, dynamic> httpHeader = {
        'token': '70fdff175ab839a52c03c835027d4d13',
//        'token': '0fc0c73a7c226ce30b315417781aca1a',
      };
      if (headers != null) {
        httpHeader.addAll(headers);
      }
      dynamic params;
      if (data is Map<String, dynamic>) {
        params = Map<String, dynamic>();
        if (data != null) {
          params.addAll(data);
        }
      } else if (data is List) {
        params = data;
      }

      // 配置dio请求信息
      Response response;
      BaseOptions option = BaseOptions(
        connectTimeout: 10000,
        // 服务器链接超时，毫秒
        receiveTimeout: 3000,
        // 响应流上前后两次接受到数据的间隔，毫秒
        headers: httpHeader,
        // 添加headers,如需设置统一的headers信息也可在此添加
        contentType: "application/json",
        responseType: ResponseType.plain,
      );
      Dio dio = Dio(option);
//      dio.interceptors.add(LogInterceptor(responseBody: true));
      if (method == 'get') {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.post(url, data: params);
      }

      if (response.statusCode != 200) {
        _msg = '网络请求错误,状态码:' + response.statusCode.toString();
        return _msg;
      }

      // 返回结果处理
      Map<String, dynamic> resCallbackMap = json.decode(response.data);
      _code = resCallbackMap['status'];
      _msg = resCallbackMap['msg'];
      if (_code == -1) {
        CustomToast.showToast(_msg);
      } else if (_code == 0) {
        CustomToast.showToast(_msg);
        return response.data;
      } else {
//        llog([response.data], titles: ['response.data']);
        return response.data;
      }
    } catch (exception) {
      return '数据请求错误：' + exception.toString();
    }
  }

  static Future download(String url, String path,
      {Map<String, dynamic> params, DownloadProgressCallback progress}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.download(url, path,
          onReceiveProgress: (int count, int total) {
        if (progress != null) {
          progress(count / total);
        }
      }, queryParameters: params);

      llog('response.statusCode===${response.statusCode}====');
      llog('response.statusMessage===${response.statusMessage}====');
      if (response.statusCode != 200) {
        return '网络请求错误,状态码:' + response.statusCode.toString();
      } else {
        return response.data;
      }
    } catch (exception) {
      return '下载失败：' + exception.toString();
    }
  }

  static Future upload(String url, File file,
      {Map<String, dynamic> map, UploadProgressCallback progress}) async {
    try {
      Dio dio = Dio();
      var path = file.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      map['file'] = MultipartFile.fromFileSync(path, filename: name);
      FormData formData = FormData.fromMap(map);
      Response response = await dio.post(url, data: formData,
          onSendProgress: (int count, int total) {
        if (progress != null) {
          progress(count / total);
        }
      });
      llog('response.statusCode===${response.statusCode}====');
      llog('response.statusMessage===${response.statusMessage}====');
      if (response.statusCode != 200) {
        return '网络请求错误,状态码:' + response.statusCode.toString();
      } else {
        return url + map['key'];
      }
    } catch (exception) {
      return '上传失败：' + exception.toString();
    }
  }
}
