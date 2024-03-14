import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:music_tools/enum/music_type.dart';
import 'package:music_tools/global/music_analysis_info.dart';
import 'package:music_tools/global/music_search_info.dart';
import 'package:music_tools/global/qq_music_info.dart';
import 'package:uuid/v4.dart';
import 'package:path/path.dart' as p;
import '../../components/audio_play.dart';
import '../../components/download_progress_bar.dart';
import '../../global/music_netease_analysis_info.dart';
import '../../global/netase_music_search.dart';
import '../../network/api/music_api.dart';
import '../../network/base_provider.dart';
import '../../utils/log.dart';
import '../../utils/overlay_manager.dart';
import '../../utils/path_constraint.dart';
import 'state.dart';

/**
 * @author Marinda
 * @date 2024/3/14 16:20
 * @description 音乐控制器
 */
class MusicControllerLogic extends GetxController {
  final MusicControllerState state = MusicControllerState();

  /*
   * @author Marinda
   * @date 2024/3/14 16:38
   * @description 搜索方法
   */
  Future<List<MusicSearchInfo>> search(MusicType musicType,String content) async{
    if(content == "" || content == null) return [];
    List<MusicSearchInfo> musicSearchInfoList = [];
    switch(musicType){
      case MusicType.netase:
        List<NetaseMusicSearch> searchInfoList = await MusicAPI.sendSearchNeteaseMusic(content);
        musicSearchInfoList = searchInfoList;
        break;
      case MusicType.qq:
        List<QQMusicInfo> searchInfoList = await MusicAPI.sendSearchQQMusic(content);
        musicSearchInfoList = searchInfoList;
        break;
      default:
        break;
    }
    if(musicSearchInfoList.length >= 20){
      musicSearchInfoList = musicSearchInfoList.sublist(0,20);
    }
    Log.i("搜索结果: 共计${musicSearchInfoList.length}");
    return musicSearchInfoList;
  }

  /*
   * @author Marinda
   * @date 2024/3/14 16:43
   * @description 获取解析类
   */
  Future<MusicAnalysisInfo?> getAnalysisMusicInfo(MusicType musicType,int musicId) async{
    MusicAnalysisInfo? musicAnalysisInfo;
    switch(musicType){
      case MusicType.netase:
        var response = await MusicAPI.sendNeteaseMusicAnalysis(musicId.toString(), "id");
        var result = response["data"];
        if(result is List){
          List<MusicNeteaseInfo> list = result.map((e)=> MusicNeteaseInfo.fromJson(e)).toList();
          MusicNeteaseInfo analysisInfo = list.first;
          musicAnalysisInfo = analysisInfo;
        }
        break;
      case MusicType.qq:
        QQMusicInfo? qqMusicInfo = await MusicAPI.sendQQMusicAnalysis(musicId.toString());
        musicAnalysisInfo = qqMusicInfo;
        break;
      default:
        break;
    }
    return musicAnalysisInfo;
    }

  /*
   * @author Marinda
   * @date 2024/3/14 16:47
   * @description 解析音乐
   */
  void analysis(MusicType musicType,int musicId) async{
    var analysisMusicInfo = await getAnalysisMusicInfo(musicType,musicId);
    String picUrl = "";
    String url = "";
    String musicName = "";
    if(analysisMusicInfo == null){
      BotToast.showText(text: "解析失败！"); return;
    }
    switch(musicType){
      case MusicType.netase:
        MusicNeteaseInfo musicInfo = analysisMusicInfo as MusicNeteaseInfo;
        picUrl = musicInfo.pic!;
        url = musicInfo.url ?? "";
        musicName = "${musicInfo.title!} - ${musicInfo.author!}";
        break;
      case MusicType.qq:
        QQMusicInfo musicInfo = analysisMusicInfo as QQMusicInfo;
        picUrl = musicInfo.cover!;
        url = musicInfo.src ?? "";
        musicName = "${musicInfo.songname!} - ${musicInfo.name!}";
        break;
      default:
        break;
    }
    if(url == "" || url == null){
      BotToast.showText(text: "该音乐解析失败！"); return;
    }
    OverlayManager().createOverlay("onlinePlay", AudioPlayComponent(picUrl, url,musicName));
  }



  /*
   * @author Marinda
   * @date 2024/3/14 18:13
   * @description 下载音乐至本地
   */
  downloadMusicToLocal(MusicType musicType,int musicId) async{
    var analysisMusicInfo = await getAnalysisMusicInfo(musicType, musicId);
    if(analysisMusicInfo == null){
      BotToast.showText(text: "该音乐解析失败！"); return;
    }
    String url = "";
    String musicName = "";
    switch(musicType){
      case MusicType.netase:
        MusicNeteaseInfo musicInfo = analysisMusicInfo as MusicNeteaseInfo;
        url = musicInfo.url ?? "";
        musicName = "${musicInfo?.title} - ${musicInfo.author}";
        break;
      case MusicType.qq:
        QQMusicInfo musicInfo = analysisMusicInfo as QQMusicInfo;
        url = musicInfo.src ?? "";
        musicName = "${musicInfo.songname} - ${musicInfo.name}";
        break;
      default:
        break;
    }
    if(url == null || url == ""){
      BotToast.showText(text: "无法下载该文件！");
      return;
    }
    var dir = await PathConstraint.getApplicationCacheDirPath();
    var uuid = UuidV4();
    var uFileName = uuid.generate();
    String fileName = "${uFileName}.mp3";
    String savePath = p.join(dir.path,fileName);
    Log.i("文件下载url：${url}");
    Log.i("当前保存下载文件路径为：${savePath}");
    OverlayManager().createOverlay("downloadProgress", DownloadProgressBarComponent(musicName, state.downloadProgress,savePath));
    await BaseProvider.sendRequestDownload(url, savePath,onDownloadProcess: (count,total){
      var progress = (count / total) * 100;
      state.downloadProgress.value = progress;
      Log.i("进度: ${state.downloadProgress.value}");
    });
  }

}
