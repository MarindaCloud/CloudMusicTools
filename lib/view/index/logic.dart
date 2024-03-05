import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/global/bottom_nav.dart';
import 'package:music_tools/utils/font_rpx.dart';

import 'state.dart';

class IndexLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final IndexState state = IndexState();

  @override
  void onInit() {
    initBottomInfo();
    state.controller = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    state.animation = Tween(begin: Offset(-Get.width,0),end: Offset(0 ,0)).animate(state.controller!);
    // TODO: implement onInit
    super.onInit();
  }

  initBottomInfo(){
    state.bottomNavInfoList = [
      BottomNav(text: "主页",iconData: Icons.home,index: 1),
      BottomNav(text: "设置",iconData: Icons.settings,index: 2),
      BottomNav(text: "我的",iconData: Icons.person,index: 3),
    ];
  }

  /*
   * @author Marinda
   * @date 2024/3/5 15:30
   * @description 修改侧边栏
   */
  changeSideNav(){
    state.showSideNav.value = !state.showSideNav.value;
    if(state.showSideNav.value){
      state.controller!.forward();
    }else{
      state.controller!.reverse();
    }
  }

  /*
   * @author Marinda
   * @date 2024/3/5 16:23
   * @description 构建底部导航
   */
  List<Widget> buildBottomNav(){
    return state.bottomNavInfoList.map((e){
      return Expanded(
        child: InkWell(
          onTap: ()=>state.navIndex.value = e.index!,
          child: Column(
            children: [
              Container(
                child: SizedBox(
                    width: 80.rpx,
                    height: 80.rpx,
                    child: Icon(
                      e.iconData,
                      color: e.index == state.navIndex.value ? Colors.red : Colors.white,
                    )
                ),
              ),
              Container(
                child: Text(
                  "${e.text}",
                  style: TextStyle(
                      color: e.index == state.navIndex.value ? Colors.red :Colors.white,
                      fontSize: 16
                  ),
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
