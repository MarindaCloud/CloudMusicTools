import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:music_tools/utils/font_rpx.dart';

import 'logic.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);

  final logic = Get.find<IndexLogic>();
  final state = Get
      .find<IndexLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () => state.backFlag.value ? logic.backIndex() : logic.changeSideNav(),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${String.fromCharCode(state.backFlag.value
                      ? Icons.arrow_back_ios.codePoint
                      : Icons.menu.codePoint)}",
                  style: TextStyle(
                      fontFamily: state.backFlag.value ? Icons.arrow_back_ios
                          .fontFamily : Icons.menu.fontFamily,
                      fontSize: 60.rpx,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            title: Text(
              "Cloud音乐工具箱",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.withOpacity(.7),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                //内容
                state.contentWidget.value,
                //遮罩层
                if(state.showSideNav.value)
                  InkWell(
                    onTap: () => logic.changeSideNav(),
                    child: SizedBox.expand(
                      child: Container(
                        color: Colors.black.withOpacity(.3),
                      ),
                    ),
                  ),
                AnimatedBuilder(
                  animation: state.animation!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: state.animation!.value,
                      child: SizedBox(
                        width: 500.rpx,
                        // height: 100.rpx,
                        child: Container(
                          padding: EdgeInsets.only(left: 20.rpx, right: 20.rpx),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //网易云模块
                              Container(
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        print("测试");
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              LinearBorder.none)
                                      ),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 30.rpx),
                                                      child: SizedBox(
                                                        width: 70.rpx,
                                                        height: 70.rpx,
                                                        child: Image.asset(
                                                            "assets/music.png",
                                                            fit: BoxFit.fill),
                                                      )
                                                  ),
                                                  Text(
                                                    "网易云模块",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: 30.rpx,
                                                height: 30.rpx,
                                                child: Image.asset(
                                                  "assets/nav_down.png",
                                                  fit: BoxFit.fill,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 160.rpx, top: 0.rpx),
                                      child: InkWell(
                                        onTap: () => print("音乐搜索"),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "音乐搜索",
                                                  style: TextStyle(
                                                      color: Colors.deepPurple
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 30.rpx, left: 160.rpx),
                                      child: InkWell(
                                        onTap: () => print("音乐解析"),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "音乐解析",
                                                  style: TextStyle(
                                                      color: Colors.deepPurple
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.only(bottom: 30.rpx),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        color: Colors.grey.withOpacity(.6),
                                        width: 1
                                    ))
                                ),
                              ),
                              SizedBox(height: 20.rpx),
                              Container(
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        print("测试");
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              LinearBorder.none)
                                      ),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 30.rpx),
                                                      child: SizedBox(
                                                        width: 70.rpx,
                                                        height: 70.rpx,
                                                        child: Image.asset(
                                                            "assets/music2.png",
                                                            fit: BoxFit.fill),
                                                      )
                                                  ),
                                                  Text(
                                                    "全民K歌模块",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: 30.rpx,
                                                height: 30.rpx,
                                                child: Image.asset(
                                                  "assets/nav_down.png",
                                                  fit: BoxFit.fill,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 160.rpx, top: 0.rpx),
                                      child: InkWell(
                                        onTap: () => print("音乐解析"),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "音乐解析",
                                                  style: TextStyle(
                                                      color: Colors.deepPurple
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(bottom: 30.rpx),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    height: 150.rpx,
                    color: Colors.blue.withOpacity(.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: logic.buildBottomNav(),
                    ),
                  ),
                )
              ],
            ),
          )
      );
    });
  }
}
