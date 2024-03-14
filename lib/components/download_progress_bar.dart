import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:music_tools/utils/log.dart';
import 'package:music_tools/utils/overlay_manager.dart';
import 'package:open_file_plus/open_file_plus.dart';

/**
 * @author Marinda
 * @date 2024/3/11 16:58
 * @description 进度条组件
 */
class DownloadProgressBarComponent extends StatefulWidget {

  final RxDouble progress;
  final String title;
  final String savePath;
  final bool? isAutoOpen;
  DownloadProgressBarComponent(this.title, this.progress,this.savePath,{this.isAutoOpen});

  @override
  State<StatefulWidget> createState() {
    return ProgressBarComponentState();
  }
}

/*
 * @author Marinda
 * @date 2024/3/11 16:58
 * @description 进度条
 */
class ProgressBarComponentState extends State<DownloadProgressBarComponent>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? opacityValue;
  ValueNotifier<double>? _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacityValue = Tween<double>(begin: 0.0, end: 1).animate(controller!);
    controller!.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
    opacityValue = null;
    _valueNotifier!.dispose();
    // TODO: implement dispose
  }


  /*
   * @author Marinda
   * @date 2024/3/11 17:17
   * @description 关闭
   */
  close() {
    OverlayManager().removeOverlay("downloadProgress");
  }

  /*
   * @author Marinda
   * @date 2024/3/11 17:19
   * @description 打开外部文件
   */
  openSource() async {
    if(widget.progress.value != 100){
      BotToast.showText(text: "等待文件下载完成后重试！");
      return;
    }
    await OpenFile.open(widget.savePath);
    Log.i("打开下载文件！");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        color: Colors.black.withOpacity(.3),
        child: Container(
          width: Get.width,
          height: Get.height,
          child: FractionallySizedBox(
            widthFactor: .7,
            heightFactor: .25,
            child: Container(
              padding: EdgeInsets.only(
                  top: 20.rpx, bottom: 20.rpx, left: 30.rpx, right: 30.rpx),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(20.rpx)
              ),
              child: FadeTransition(
                opacity: opacityValue!,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text: "正在下载",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.rpx
                                      )
                                  ),
                                  TextSpan(
                                    text: "   "
                                  ),
                                  TextSpan(
                                      text: "${widget.title}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 30.rpx
                                      )
                                  )
                                ]
                            )
                        )
                    ),
                    //进度条
                    SizedBox(
                      width: 300.rpx,
                      height: 300.rpx,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1,
                        valueNotifier: _valueNotifier,
                        progress: widget.progress.value,
                        maxProgress: 100,
                        startAngle: 225,
                        sweepAngle: 270,
                        corners: StrokeCap.butt,
                        foregroundColor: Colors.green,
                        backgroundColor: const Color(0xffeeeeee),
                        foregroundStrokeWidth: 30.rpx,
                        backgroundStrokeWidth: 30.rpx,
                        seekSize: 6,
                        seekColor: const Color(0xffeeeeee),
                        animation: true,
                        onAnimationEnd: () async{
                          Log.i("动画结束！");
                          Log.i("open: ${widget.isAutoOpen}");
                          if(widget.isAutoOpen == true){
                            await openSource();
                          }
                        },
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _valueNotifier!,
                            builder: (_, double value, __) =>
                                Text(
                                  '${value.toInt()}%',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 30.rpx
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => close(),
                            child: Container(
                              width: 170.rpx,
                              height: 80.rpx,
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(20.rpx)
                              ),
                              child: Center(
                                child: Text(
                                  "关闭",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.rpx

                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 150.rpx, height: 100.rpx,),
                          InkWell(
                            onTap: () => openSource(),
                            child: Container(
                              width: 170.rpx,
                              height: 80.rpx,
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(20.rpx)
                              ),
                              child: Center(
                                child: Text(
                                  "源文件",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.rpx
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

}