import 'package:get/get.dart';
import 'package:music_tools/view/netase_music_cloud/logic.dart';

import 'logic.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexLogic());
    Get.lazyPut(() => NetaseMusicCloudLogic());
  }
}
