import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/enum/music_type.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/components/music_search/view.dart';
import 'package:music_tools/utils/music_util.dart';
import '../../enum/assets_enum.dart';

/**
 * @author Marinda
 * @date 2024/3/5 17:11
 * @description 网易云音乐解析
 */
class MusicViewComponent extends StatelessWidget {
  MusicType musicType;
  Function searchFunction;
  Function analysisFunction;
  Function downloadFunction;
  MusicViewComponent(this.musicType,this.searchFunction,this.analysisFunction,this.downloadFunction,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(MusicUtil.getMusicTypeIcon(musicType), fit: BoxFit.fill,)),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.rpx),
            child: Center(
              child: Text(
                "${musicType.type}助手",
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
                  // if(state.showSearch.value)
                  Expanded(
                    child: MusicSearchPage(musicType,searchFunction,analysisFunction,downloadFunction),
                  ), //卡片方案布局
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
