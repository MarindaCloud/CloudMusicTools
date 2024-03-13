import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/components/audio_play.dart';
import 'package:music_tools/enum/music_type.dart';
import 'package:music_tools/global/music_analysis_info.dart';
import 'package:music_tools/network/api/music_api.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/log.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import '../download_progress_bar.dart';
import '../../enum/assets_enum.dart';
import 'package:path_provider/path_provider.dart';
import '../../global/netase_music_search.dart';
import '../../network/base_provider.dart';
import '../../utils/overlay_manager.dart';
import '../../utils/path_constraint.dart';
import 'state.dart';

class MusicSearchLogic extends GetxController with GetSingleTickerProviderStateMixin{

  final MusicSearchState state = MusicSearchState();

  MusicSearchLogic([MusicType type = MusicType.netase]){
    state.musicType.value = type;
  }

  @override
  void onInit() {
    state.sliderController = AnimationController(vsync: this);
    state.sliderAnimation = Tween(begin: Offset(0,0),end: Offset(0,10)).animate(state.sliderController!);
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
    var analysisMusicInfo = await getAnalysisMusicInfo(element);
    if(analysisMusicInfo == null){
      BotToast.showText(text: "该音乐解析失败！"); return;
    }
    String picUrl = element.musicInfo?.picUrl ?? "";
    String url = analysisMusicInfo.url ?? "";
    String musicName = "${element.musicInfo?.name} — ${element.author?.name}";
    OverlayManager().createOverlay("onlinePlay", AudioPlayComponent(picUrl, url,musicName));
  }

  /*
   * @author Marinda
   * @date 2024/3/11 17:47
   * @description 获取
   */
  Future<MusicAnalysisInfo?> getAnalysisMusicInfo(NetaseMusicSearch element) async{
    int musicId = element.id ?? 0;
    var response = await MusicAPI.sendMusicAnalysis(musicId.toString(), "id");
    var result = response["data"];
    if(result is List){
      List<MusicAnalysisInfo> list = result.map((e)=> MusicAnalysisInfo.fromJson(e)).toList();
      MusicAnalysisInfo analysisInfo = list.first;
      if(analysisInfo.url == null || analysisInfo.url == ""){
        return null;
      }
      return analysisInfo;
    }
  }

  /*
   * @author Marinda
   * @date 2024/3/11 17:36
   * @description 下载音乐到本地
   */
  downloadMusicToLocal(NetaseMusicSearch element) async{
    var analysisMusicInfo = await getAnalysisMusicInfo(element);
    if(analysisMusicInfo == null){
      BotToast.showText(text: "该音乐解析失败！"); return;
    }
    String url = analysisMusicInfo.url ?? "";
    if(url == null || url == "") BotToast.showText(text: "解析异常，无法下载该文件！");
    var dir = await PathConstraint.getApplicationCacheDirPath();
    var uuid = UuidV4();
    var uFileName = uuid.generate();
    String fileName = "${uFileName}.mp3";
    String savePath = p.join(dir.path,fileName);
    Log.i("当前保存下载文件路径为：${savePath}");
    String musicName = "${element.musicInfo?.name} — ${element.author?.name}";
    OverlayManager().createOverlay("downloadProgress", DownloadProgressBarComponent(musicName, state.downloadProgress,savePath));
    await BaseProvider.sendRequestDownload(url, savePath,onDownloadProcess: (count,total){
      var progress = (count / total) * 100;
      state.downloadProgress.value = progress;
    });
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
                    onTap: ()=> downloadMusicToLocal(element),
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
