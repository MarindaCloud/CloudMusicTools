import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../utils/log.dart';
import '../../utils/overlay_manager.dart';
import 'state.dart';

class PlayLogic extends GetxController {
  final PlayState state = PlayState();
  String tag;


  PlayLogic(this.tag);


  @override
  void onInit() async{
    super.onInit();
  }

  @override
  void initPlayer(String url) async{
    Log.i("url: ${url}");
    state.controller =  VideoController(state.player);
    state.url = url;
    state.player.stream.playing.listen((event) {
      print('播放状态: ${event}');
    });
    state.player.stream.position.listen((event) {
      state.position.value = event.inMilliseconds;
    });
    state.player.stream.duration.listen((event) {
      state.seek.value = event.inMilliseconds;
    });
    state.player.stream.completed.listen((event) {
    });
    state.player.streams.error.listen((event) {
      // close();
      Log.e('播放失败: $event');
    });
      state. player.open(Playlist(
        [
          Media('file://$url'),
        ],
      ));
  }
  @override
  void play() {
    state.player.play();
    state.isPaused.value = false;
  }

  @override
  void pause() {
    state.player.pause();
    state.isPaused.value = true;
  }

  void playOrPause({bool? isPaused}) {
    if (isPaused != null) {
      isPaused ? pause() : play();
    } else {
      state.isPaused.value ? play() : pause();
    }
  }


  @override
  void setPosition(Duration duration) {
    state.player.seek(duration);
    // Future.delayed(const Duration(milliseconds: 10), () => sendSyncMsg(2));
  }

  @override
  Future close() async {
    OverlayManager().removeOverlay(tag);
  }

  @override
  void onClose(){
    super.onClose();
    state.player.dispose();
  }
}
