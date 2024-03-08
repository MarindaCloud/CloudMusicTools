import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/**
 * @author Marinda
 * @date 2024/3/8 16:36
 * @description  路径存放
 */
class PathConstraint{

  /*
   * @author Marinda
   * @date 2024/3/8 16:36
   * @description 基础目录
   */
  static Future<Directory> getBaseDirPath() async{
    final Directory? dbFolder;
    if(GetPlatform.isAndroid) {
      dbFolder = await  getExternalStorageDirectory();
    }
    else if(GetPlatform.isIOS) {
      dbFolder = await  getApplicationDocumentsDirectory();
    }
    else {
      dbFolder = await getApplicationSupportDirectory();
    }
    return dbFolder!;
  }
}