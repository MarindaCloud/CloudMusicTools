import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:music_tools/enum/request_type.dart';

import '../utils/log.dart';

/**
 * @author Marinda
 * @date 2024/3/8 16:37
 * @description  基础请求
 */
class Request {
  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 5000,
  );

  // 创建 Dio 实例
  static final Dio _dio = Dio(_options);



  // _request 是核心函数，所有的请求都会走这里
  static Future<T> _request<T>(String path,
      {required String method, Map<String,dynamic>? headers,  data,bool? isStream = false}) async {
    Log.i('请求地址$path');
    Log.i('发送的数据为：$data');
    try {
      Options options = Options(
          method: method,
          headers: headers,
      );
      if(isStream == true){
        options.responseType = ResponseType.stream;
      }
      Response response = await _dio.request(path,
          data: data, options: options);
      if (response.statusCode == 200) {
        try {
          return response.data;
        } catch (e) {
          Log.e('解析响应数据异常$e');
          // LogUtil.v(e, tag: '解析响应数据异常');
          return Future.error('解析响应数据异常');
        }
      } else {
        // _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e) {
      Log.e('dio请求失败：$e');
      // LogUtil.v(_dioError(e), tag: '请求异常');
      // EasyLoading.showInfo(_dioError(e));
      return Future.error(_dioError(e));
    } catch (e) {
      Log.e('请求未知异常$e');
      // LogUtil.v(e, tag: '未知异常');
      return Future.error('未知异常');
    }
  }

  /*
   * @author Marinda
   * @date 2024/3/8 16:40
   * @description post请求
   */
  static Future<dynamic> sendPost(String path,dynamic data,{Map<String,dynamic>? header,bool? isStream}){
    return _request(path, method: "POST",headers: header,data:data,isStream: isStream);
  }

  /*
   * @author Marinda
   * @date 2024/3/8 16:40
   * @description post请求
   */
  static Future<dynamic> sendGet(String path,{Map<String,dynamic>? header,bool? isStream}){
    return _request(path, method: "GET",headers: header,isStream: isStream);
  }

  // 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioErrorType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioErrorType.response:
        return "服务器异常，请稍后重试！";
      case DioErrorType.cancel:
        return "请求已被取消，请重新请求";
      case DioErrorType.other:
        return "网络异常，请稍后重试！";
      default:
        return "Dio异常";
    }
  }



}
