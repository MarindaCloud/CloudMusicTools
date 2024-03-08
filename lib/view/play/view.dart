import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:music_tools/components/get_bind_widget.dart';
import 'package:music_tools/view/play/state.dart';

import '../../utils/overlay_manager.dart';
import 'logic.dart';

class PlayPage extends StatelessWidget {
  final PlayLogic logic;
  final PlayState state;
  final String tag;

  PlayPage(this.tag, {Key? key})
      : logic = Get.put(PlayLogic(tag)),
        state = Get
            .find<PlayLogic>(tag: OverlayManager.uniqueKeyMap[tag])
            .state,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBindWidget(
      bind: logic,
      tag: OverlayManager.uniqueKeyMap[tag],
      child: Obx(() {
        return Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(.3),
          child: FractionallySizedBox(
            widthFactor: .7,
            heightFactor: .7,
            child: Stack(
              children: [
                if(state.controller!=null)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Video(
                    controller: VideoController(Player()),
                    width: Get.width,
                    height: Get.height,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
