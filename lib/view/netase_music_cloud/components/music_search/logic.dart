import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/components/audio_play.dart';
import 'package:music_tools/global/music_analysis_info.dart';
import 'package:music_tools/network/api/music_api.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/log.dart';

import '../../../../enum/assets_enum.dart';
import '../../../../global/netase_music_search.dart';
import '../../../../utils/overlay_manager.dart';
import 'state.dart';

class MusicSearchLogic extends GetxController with GetSingleTickerProviderStateMixin{

  final MusicSearchState state = MusicSearchState();

  @override
  void onInit() {
    state.sliderController = AnimationController(vsync: this);
    state.sliderAnimation = Tween(begin: Offset(0,0),end: Offset(0,1)).animate(state.sliderController!);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    state.sliderController!.dispose();
    state.sliderAnimation = null;
    // TODO: implement onClose
    super.onClose();
  }

  /*
   * @author Marinda
   * @date 2024/3/11 15:08
   * @description 解析Music
   */
  analysisMusic(NetaseMusicSearch element) async{ 
    int musicId = element.id ?? 0;
    var response = await MusicAPI.sendMusicAnalysis(musicId.toString(), "id");
    var result = response["data"];
    if(result is List){
      List<MusicAnalysisInfo> list = result.map((e)=> MusicAnalysisInfo.fromJson(e)).toList();
      MusicAnalysisInfo analysisInfo = list.first;
      if(analysisInfo.url == null || analysisInfo.url == ""){
        BotToast.showText(text: "该音乐解析失败！");
        return;
      }
      String picUrl = element.musicInfo?.picUrl ?? "";
      String url = analysisInfo.url ?? "";
      String musicName = "${element.musicInfo?.name} — ${element.author?.name}";
      OverlayManager().createOverlay("onlinePlay", AudioPlayComponent(picUrl, url,musicName));
      // Log.i("当前解析数据: ${analysisInfo.toJson()}");
    }
  }


  /*
   * @author Marinda
   * @date 2024/3/8 17:14
   * @description 搜索方法
   */
  search() async{
    String content = state.searchTextController.text;
    if(content == "" || content == null) return false;
    List<NetaseMusicSearch> searchInfoList = await MusicAPI.sendSearchNeteaseMusic(content);
    var list = <NetaseMusicSearch>[];
    if(searchInfoList.length >= 20){
      for(var i = 0;i<20;i++){
        var element = searchInfoList[i];
        list.add(element);
      }
    }else{
      list.addAll(searchInfoList);
    }
    state.netaseMusicSearchList.value = list;
    Log.i("搜索结果: 共计${searchInfoList.length}");
  }

  buildSearchResult(){
    return state.netaseMusicSearchList.map((element){
      return Container(
        margin: EdgeInsets.only(top: 30.rpx,bottom: 30.rpx),
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SizedBox(
                  width: 100.rpx,
                  height: 100.rpx,
                  child: Image.network(element.musicInfo?.picUrl ?? "",fit: BoxFit.fill,)),
            ),
            SizedBox(width: 50.rpx),
            Expanded(
              child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${element.name}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "作者名: ${element.author?.name}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: ()=>analysisMusic(element),
                    child: SizedBox(
                      width: 70.rpx,
                      height: 70.rpx,
                      child: Image.asset("assets/play.png",fit: BoxFit.fill,),
                    ),
                  ),
                  SizedBox(width: 50.rpx),
                  InkWell(
                    onTap: ()=>print("下载"),
                    child: SizedBox(
                      width: 70.rpx,
                      height: 70.rpx,
                      child: Image.asset("assets/download.png",fit: BoxFit.fill,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
