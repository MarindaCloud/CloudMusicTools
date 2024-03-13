import 'package:music_tools/enum/music_type.dart';

import '../enum/assets_enum.dart';

/**
 * @author Marinda
 * @date 2024/3/13 11:29
 * @description 音乐工具
 */
class MusicUtil{

  /*
   * @author Marinda
   * @date 2024/3/13 11:23
   * @description 获取音乐类型图标
   */
  static getMusicTypeIcon(MusicType musicType){
    var type =  musicType == MusicType.netase ? Assets.music : musicType == MusicType.qq ? Assets.music3 : Assets.music2;
    return type.assets;
  }

}