import 'package:get/get.dart';
import 'package:music_tools/view/netase_music_cloud/components/music_search/logic.dart';

import 'logic.dart';

class NetaseMusicCloudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetaseMusicCloudLogic());
    Get.lazyPut(() => MusicSearchLogic());
  }
}
