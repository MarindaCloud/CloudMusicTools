import 'package:get/get.dart';

import 'logic.dart';

class NetaseMusicCloudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetaseMusicCloudLogic());
  }
}
