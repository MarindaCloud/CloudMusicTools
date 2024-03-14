import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/overlay_manager.dart';

/**
 * @author Marinda
 * @date 2024/3/14 14:13
 * @description 提示组件
 */
class DialogComponent extends StatefulWidget{
  final String title;
  final String text;
  final Function onSubmit;
  DialogComponent(this.title,this.text,this.onSubmit);

  @override
  State<StatefulWidget> createState() {
    return DialogComponentState();
  }


}

class DialogComponentState extends State<DialogComponent> with TickerProviderStateMixin{

  AnimationController? controller;
  Animation? value;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    value = Tween<double>(begin: 0.0,end: 1.0).animate(controller!);
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: Get.width,
        height: Get.height,
        child: FractionallySizedBox(
          widthFactor: .7,
          heightFactor: .25,
          child: AnimatedBuilder(
            animation: controller!,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: value!.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.rpx),
                  ),
                  child: Column(
                    children: [
                      //标题
                      Container(
                        color: Colors.blue.withOpacity(.7),
                        height: 70.rpx,
                        child: Center(
                          child: Text(
                            "${widget.title}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.rpx
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              "${widget.text}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32.rpx,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30.rpx,right: 30.rpx,bottom: 20.rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap:()=>OverlayManager().removeOverlay("dialogComponent"),
                              child: Container(
                                width: 150.rpx,
                                height: 60.rpx,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15.rpx)
                                ),
                                child: Center(
                                  child: Text(
                                    "关闭",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.rpx
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                widget.onSubmit();
                                },
                              child: Container(
                                width: 150.rpx,
                                height: 60.rpx,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.rpx)
                                ),
                                child: Center(
                                  child: Text(
                                    "确定",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.rpx
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}