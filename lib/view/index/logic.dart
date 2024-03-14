import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/components/dialog_component.dart';
import 'package:music_tools/components/music_search/logic.dart';
import 'package:music_tools/components/music_view_component.dart';
import 'package:music_tools/controller/music_controller/logic.dart';
import 'package:music_tools/enum/music_type.dart';
import 'package:music_tools/components/custom_card.dart';
import 'package:music_tools/enum/assets_enum.dart';
import 'package:music_tools/enum/request_type.dart';
import 'package:music_tools/global/bottom_nav.dart';
import 'package:music_tools/global/version_info.dart';
import 'package:music_tools/network/api/version_api.dart';
import 'package:music_tools/network/base_provider.dart';
import 'package:music_tools/utils/common_util.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/log.dart';
import 'package:music_tools/utils/overlay_manager.dart';
import 'package:music_tools/utils/path_constraint.dart';
import '../../components/download_progress_bar.dart';
import 'state.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class IndexLogic extends GetxController with GetTickerProviderStateMixin {
  final IndexState state = IndexState();
  final MusicControllerLogic logic = Get.find<MusicControllerLogic>();

  @override
  void onInit() {
    initBottomInfo();
    state.contentWidget.value = buildContentWidget();
    state.controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    state.animation = Tween(begin: Offset(-Get.width, 0), end: Offset(0, 0))
        .animate(state.controller!);

    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {
    autoUpdate();
    super.onReady();
    testDownload();

  }


  /*
   * @author Marinda
   * @date 2024/3/14 13:55
   * @description 自动更新
   */
  autoUpdate() async{
    String currentVersion = await CommonUtil.getVersion();
    VersionInfo versionInfo = await VersionAPI.getNewVersionInfo();
    String newVersion = versionInfo?.version ?? "";
    state.versionInfo = versionInfo;
    if(currentVersion!=newVersion){
      OverlayManager().createOverlay("dialogComponent", DialogComponent("自动更新", "最新版本为v1.0.4,是否需要自动更新",updateClient));
    }
    Log.i("当前版本: ${currentVersion},最新版本：${versionInfo.version}");
  }
  
  /*
   * @author Marinda
   * @date 2024/3/14 15:15
   * @description 更新客户端
   */
  updateClient() async{
    VersionInfo versionInfo = state.versionInfo;
    String url = versionInfo.url ??"";
    var dir = await PathConstraint.getBaseDirPath();
    String fileName = url.substring(url.lastIndexOf("/")+1);
    String savePath = p.join(dir.path,fileName);
    Log.i("客户端保存地址：${savePath}");
    OverlayManager().removeOverlay("dialogComponent");
    OverlayManager().createOverlay("downloadProgress", DownloadProgressBarComponent("客户端", state.downloadProgress,savePath,isAutoOpen: true,));
    await VersionAPI.downloadNewClient(versionInfo, savePath,onDownloadProcess: (count,total){
        var progress = (count / total) * 100;
        state.downloadProgress.value = progress;
    });
  }


  initBottomInfo() {
    state.bottomNavInfoList = [
      BottomNav(text: "主页", iconData: Icons.home, index: 1),
      BottomNav(text: "设置", iconData: Icons.settings, index: 2),
      BottomNav(text: "我的", iconData: Icons.person, index: 3),
    ];
  }
  
  test() async{
    var data = "http://m10.music.126.net/20240311180727/0ad7d5de9789f22891cdbc5a08cbcdab/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/14055025967/5a0a/cc5d/2055/e7bc382dc04175f439e9090fcda99944.mp3";
    var header = {
      "Accept": "*/*",
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
      "Accept-Encoding": "gzip, deflate",
      "Accept-Language": "zh-CN,zh;q=0.9",
      "Connection": "keep-alive"
    };
    AudioPlayer player = AudioPlayer();
    player.play(UrlSource(data));
    ResponseBody response =  await BaseProvider.sendRequestStream(RequestType.normal,data: data,header: header);
  }


  /*
   * @author Marinda
   * @date 2024/3/11 16:44
   * @description 测试下载
   */
  testDownload() async{
    String url = "http://m10.music.126.net/20240311180727/0ad7d5de9789f22891cdbc5a08cbcdab/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/14055025967/5a0a/cc5d/2055/e7bc382dc04175f439e9090fcda99944.mp3";
    // var dir = await PathConstraint.getApplicationCacheDirPath();
    // String savePath = p.join(dir.path,"123.mp3");
    // await BaseProvider.sendRequestDownload(url, savePath,onDownloadProcess: (count,total){
    //   Log.i('当前下载进度为: ${count / total}');
    // });
    // OverlayManager().createOverlay("downloadProgress", DownloadProgressBarComponent("文件信息", 30));

    // if(url == null || url == "") BotToast.showText(text: "解析异常，无法下载该文件！");
    // var dir = await PathConstraint.getApplicationCacheDirPath();
    // var uuid = UuidV4();
    // var uFileName = uuid.generate();
    // String fileName = "${uFileName}.mp3";
    // String savePath = p.join(dir.path,fileName);
    // Log.i("当前保存下载文件路径为：${savePath}");
    // await BaseProvider.sendRequestDownload(url, savePath,onDownloadProcess: (count,total){
    //   var progress = (count / total) * 100;
    //
    //   Log.i('当前下载进度为: ${progress}');
    // });
  }

  /*
   * @author Marinda
   * @date 2024/3/5 15:30
   * @description 修改侧边栏
   */
  changeSideNav() {
    state.showSideNav.value = !state.showSideNav.value;
    if (state.showSideNav.value) {
      state.controller!.forward();
    } else {
      state.controller!.reverse();
    }
  }


  /*
   * @author Marinda
   * @date 2024/3/5 17:36
   * @description 切换视图
   */
  changeContentWidget(Widget widget){
    state.contentWidget.value = widget;
    state.backFlag.value = true;
  }

  /*
   * @author Marinda
   * @date 2024/3/5 17:41
   * @description 回到主页
   */
  backIndex() async{
    state.backFlag.value = false;
    state.navIndex.value = 1;
    state.contentWidget.value = buildContentWidget();
    //移除音乐搜索记录
    await Get.delete<MusicSearchLogic>();
  }


  buildContentWidget() {
    Widget widget = Container();
    switch (state.navIndex.value) {
      case 1:
        widget = Center(
          child: Container(
            margin: EdgeInsets.only(left: 30.rpx, right: 30.rpx),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //卡片方案布局
                Expanded(
                  child: CustomCard("网易云音乐解析",Assets.music.assets,()=>changeContentWidget(MusicViewComponent(MusicType.netase,logic.search,logic.analysis,logic.downloadMusicToLocal))),
                ),
                SizedBox(
                  width: 50.rpx,
                ),
                //卡片方案布局
                Expanded(
                  child: CustomCard("QQ音乐解析",Assets.music3.assets,()=>changeContentWidget(MusicViewComponent(MusicType.qq,logic.search,logic.analysis,logic.downloadMusicToLocal))),
                ),
                SizedBox(
                  width: 50.rpx,
                ),
                Expanded(
                  child: CustomCard("全民K歌解析",Assets.music2.assets,()=>changeContentWidget(MusicViewComponent(MusicType.kg,logic.search,logic.analysis,logic.downloadMusicToLocal)))
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        // widget = NetaseMusicCloudPage();
        break;
    }
    return widget;
  }

  /*
   * @author Marinda
   * @date 2024/3/5 16:23
   * @description 构建底部导航
   */
  List<Widget> buildBottomNav() {
    return state.bottomNavInfoList.map((e) {
      return Expanded(
        child: InkWell(
          onTap: () => state.navIndex.value = e.index!,
          child: Column(
            children: [
              Container(
                child: SizedBox(
                    width: 80.rpx,
                    height: 80.rpx,
                    child: Icon(
                      e.iconData,
                      color: e.index == state.navIndex.value
                          ? Colors.red
                          : Colors.white,
                    )),
              ),
              Container(
                child: Text(
                  "${e.text}",
                  style: TextStyle(
                      color: e.index == state.navIndex.value
                          ? Colors.red
                          : Colors.white,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void onClose() {
    state.controller!.dispose();
    state.animation = null;
    // TODO: implement onClose
    super.onClose();
  }
}
