import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:music_tools/global/version_info.dart';
import 'package:music_tools/network/api/music_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

/**
 * @author Marinda
 * @date 2024/3/14 14:07
 * @description 全局工具类
 */
class CommonUtil {

  /*
   * @author Marinda
   * @date 2024/3/13 13:53
   * @description 获取当前版本
   */
  static Future<String> getVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }


}