import 'dart:convert';

import 'package:music_tools/enum/request_type.dart';
import 'package:music_tools/global/version_info.dart';
import 'package:music_tools/network/base_provider.dart';
import 'package:music_tools/utils/log.dart';
import 'package:music_tools/utils/path_constraint.dart';

/**
 * @author Marinda
 * @date 2024/3/14 13:48
 * @description 版本API
 */
class VersionAPI{


  /*
   * @author Marinda
   * @date 2024/3/14 13:49
   * @description 获取最新版本号
   */
  static getNewVersionInfo() async{
    var response = await BaseProvider.sendRequestTypeGet(RequestType.newVersion);
    var result = json.decode(response);
    VersionInfo versionInfo = VersionInfo.fromJson(result);
    return versionInfo;
  }

  /*
   * @author Marinda
   * @date 2024/3/14 15:13
   * @description 下载最新客户端
   */
  static downloadNewClient(VersionInfo versionInfo,String savePath,{Function? onDownloadProcess}) async{
    String url = versionInfo.url ?? "";
    var response = await BaseProvider.sendRequestDownload(url,savePath,onDownloadProcess: onDownloadProcess);
    return response;
  }
}