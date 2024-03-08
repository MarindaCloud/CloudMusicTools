import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayState {
  String url = '';

  Player player = Player();
  VideoController? controller;
  final seek = 0.obs;
  final position = 0.obs;
  //是否暂停
  final isPaused = false.obs;
  PlayState() {
    ///Initialize variables
  }
}
