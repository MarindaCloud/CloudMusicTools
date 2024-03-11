
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/log.dart';
import 'package:music_tools/utils/overlay_manager.dart';

/**
 * @author Marinda
 * @date 2024/3/11 14:15
 * @description  音频播放组件
 */
class AudioPlayComponent extends StatefulWidget{

  final String url;
  final String picUrl;
  final String musicName;
  const AudioPlayComponent(this.picUrl,this.url,this.musicName);

  @override
  State<StatefulWidget> createState() {
    return AudioPlayComponentState();
  }

}

/**
 * @author Marinda
 * @date 2024/3/11 14:18
 * @description 音频播放组件
 */
class AudioPlayComponentState extends State<AudioPlayComponent> with TickerProviderStateMixin{

  AnimationController? animationController;
  Animation<double>? rotateAnimationValue;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? _duration;
  Duration? _position;
  PlayerState? _playState;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 15));
    rotateAnimationValue = Tween<double>(begin: 0,end: pi*2).animate(animationController!);
    _duration = Duration(milliseconds: 0);
    _position = Duration(milliseconds: 0);
    audioPlayer.setVolume(.7);
    _playState = PlayerState.stopped;
    animationController!.addListener(() {
      if(animationController!.status == AnimationStatus.completed){
        animationController!.repeat();
      }
    });
    //播放进度更改
    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((status) {
      setState(() {
        _playState = status;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    rotateAnimationValue = null;
    // TODO: implement dispose
    super.dispose();
  }




  /*
   * @author Marinda
   * @date 2024/3/11 14:41
   * @description 播放
   */
  play() async{
    if(_playState == PlayerState.playing){
      pause();
      return;
    }
    await audioPlayer.play(UrlSource(widget.url));
    animationController!.forward();
    Log.i("播放音乐");
  }

  /*
   * @author Marinda
   * @date 2024/3/11 14:44
   * @description 暂停
   */
  pause() async{
    await audioPlayer.pause();
    Log.i("暂停");
    animationController!.stop();
  }

  /*
   * @author Marinda
   * @date 2024/3/11 14:45
   * @description 格式化seekPosition
   */
  changeSeekPosition(double value){
    final duration = _duration;
    if (duration == null) {
      return;
    }
    final position = value * duration.inMilliseconds;
    audioPlayer.seek(Duration(milliseconds: position.round()));
  }

  close() async{
    await audioPlayer.dispose();
    OverlayManager().removeOverlay("onlinePlay");
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.3),
      child: Container(
        width: Get.width,
        height: Get.height,
        child: FractionallySizedBox(
          widthFactor: .75,
          heightFactor: .22,
          child: Container(
            padding: EdgeInsets.only(left: 20.rpx,right: 20.rpx,bottom: 10.rpx),
            color: Colors.white.withOpacity(.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.rpx),
                //图片
                AnimatedBuilder(
                  animation: animationController!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: rotateAnimationValue!.value,
                      child: Container(
                        width: 230.rpx,
                        height: 230.rpx,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100000),
                            color: Colors.pink,
                            image: DecorationImage(
                                image: Image.network(widget.picUrl,fit: BoxFit.fill).image,
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 50.rpx),
                Container(
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "当前播放歌曲：",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.rpx,
                            )
                          ),
                          TextSpan(
                              text: "${widget.musicName}",
                              style: TextStyle(
                                fontSize: 28.rpx,
                              )
                          ),
                        ]
                      )
                    )
                  ),
                ),
                SizedBox(height: 50.rpx),

                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        //播放暂停
                        Container(
                          child: InkWell(
                            onTap: ()=>play(),
                            child: SizedBox(
                              width: 60.rpx,
                              height: 60.rpx,
                              child: Image.asset(
                                  _playState == PlayerState.stopped
                                      || _playState == PlayerState.completed ||
                                      _playState == PlayerState.paused
                                      ? "assets/play.png"
                                      : "assets/pause.png",
                                  fit: BoxFit.fill,color: Colors.black,),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.rpx,right: 10.rpx),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: (_position != null &&
                                        _duration != null &&
                                        _position!.inMilliseconds > 0 &&
                                        _position!.inMilliseconds < _duration!.inMilliseconds)
                                        ? _position!.inMilliseconds / _duration!.inMilliseconds
                                        : 0.0,
                                    onChanged: changeSeekPosition,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    _position != null
                                        ? '$_positionText / $_durationText'
                                        : _duration != null
                                        ? _durationText
                                        : '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28.rpx
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(LinearBorder.none),
                            ),
                            onPressed: ()=>close(),
                            child: Text(
                              "退出",
                              style: TextStyle(
                                fontSize: 30.rpx
                              ),
                            ),

                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}