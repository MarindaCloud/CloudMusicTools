import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/view/netase_music_cloud/components/music_search/view.dart';

import '../../components/custom_card.dart';
import '../../enum/assets_enum.dart';
import 'logic.dart';

/**
 * @author Marinda
 * @date 2024/3/5 17:11
 * @description 网易云音乐解析
 */
class NetaseMusicCloudPage extends StatelessWidget {
  NetaseMusicCloudPage({Key? key}) : super(key: key);

  final logic = Get.find<NetaseMusicCloudLogic>();
  final state = Get
      .find<NetaseMusicCloudLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.only(
            left: 30.rpx, right: 30.rpx, top: 50.rpx, bottom: 50.rpx),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //logo
            Container(
              child: SizedBox(
                  width: 200.rpx,
                  height: 200.rpx,
                  child: Image.asset("assets/music.png", fit: BoxFit.fill,)),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.rpx),
              child: Center(
                child: Text(
                  "网易云助手",
                  style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 30.rpx, right: 30.rpx, top: 50.rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(state.showSearch.value)
                      Expanded(
                        child: MusicSearchPage(),
                      ), //卡片方案布局
                    if(!state.showSearch.value && !state.showAnalysis.value)
                      Expanded(
                        child: CustomCard("音乐搜索", Assets.music.assets, () =>
                        state.showSearch.value = true),
                      ),
                    if(!state.showSearch.value && !state.showAnalysis.value)
                      SizedBox(
                        width: 100.rpx,
                      ),
                    if(!state.showSearch.value && !state.showAnalysis.value)
                      Expanded(
                          child: CustomCard("音乐解析", Assets.music.assets, () =>
                              print("音乐解析"))
                      ),
                  ],
                ),
              ),
            )
          ],
        ),

      );
    });
  }
}
