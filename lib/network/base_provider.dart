import 'package:music_tools/enum/request_type.dart';
import 'package:music_tools/network/request.dart';

/**
 * @author Marinda
 * @date 2024/3/8 16:49
 * @description 基础网络请求适配器
 */
class BaseProvider {

  static sendRequestTypePost(RequestType type,dynamic data,{Map<String,dynamic>? header}){
   String path = type.path;
   return Request.sendPost(path, data,header: header);
  }

  static sendRequestTypeGet(RequestType type,dynamic data,{Map<String,dynamic>? header}){
   String path = "${type.path}${data}";
   print('path: ${path}');
    return Request.sendGet(path,header: header);
  }

  static sendRequestStream(RequestType type,dynamic data,{Map<String,dynamic>? header}){
    String path = "${type.path}${data}";
    print('path: ${path}');
    return Request.sendGet(path,header: header,isStream: true);
  }
 }