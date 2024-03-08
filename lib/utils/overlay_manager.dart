import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_tools/main.dart';

class OverlayManager extends GetxService {
  //外部调用
  static OverlayManager? overlayManager;

  OverlayManager._();

  Map<String, OverlayEntry> floatOverlay = {};
  static Map<String, String> uniqueKeyMap = {};

  //存放所有的overlay
  Map<String, OverlayEntry> overlayMap = {};
  final completerMap = <String, Completer>{};

  //保存所有的overlay的的状态 true:显示 false:隐藏
  final overlayStatus = <String, bool>{}.obs;

  factory OverlayManager() {
    // 只能有一个实例
    overlayManager ??= OverlayManager._();
    return overlayManager!;
  }

  //移除指定的overlay
  void removeOverlay(String key, {var closeResult}) async {
    //一键清楚所有的overlay，用于退出登录的时候
    if (key == 'all') {
      overlayMap.forEach((key, value) => value.remove());
      overlayMap.clear();
      floatOverlay.clear();
      overlayStatus.clear();
      completerMap.clear();
    } else if (overlayMap.containsKey(key)) {
      overlayMap[key]!.remove();
      overlayMap.remove(key);
      floatOverlay.remove(key);
      completerMap[key]?.complete(closeResult);
      overlayStatus.remove(key);
    }
  }
  //移除非悬浮的窗口
  void removeAllOverlayExcludeFloat() {
    overlayMap.removeWhere((key, value){
      if(!floatOverlay.containsKey(key)) {
        value.remove();
        overlayStatus.remove(key);
        return true;
      }
      return false;
    });
  }

  void hideOverlay(String key) {
    if (overlayMap.containsKey(key)) {
      overlayStatus[key] = false;
    }
  }
  static addUniqueKey(String key) {
    uniqueKeyMap[key] = '$key-${DateTime.now().microsecondsSinceEpoch}';
  }
  void showOverlay(String key) {
    if (overlayMap.containsKey(key)) {
      overlayStatus[key] = true;
    }
  }

  bool containsOverlay(String key){
    return overlayMap.containsKey(key);
  }

  //添加overlay
  createOverlay(String key, var widget,
      {String above = '',
        String below = '',
        bool uniqueKey = false,
        isFloatWidget = false}) {
    removeOverlay(key);
    Completer completer = Completer();
    OverlayEntry? aboveEntry = overlayMap[above];
    OverlayEntry? belowEntry = overlayMap[below] ??
        (floatOverlay.isNotEmpty ? floatOverlay.values.first : null);

    overlayStatus[key] = true;
    if (uniqueKey) addUniqueKey(key);
    widget = widget is Function ? widget.call() : widget;
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => isFloatWidget
            ? widget
            : OverlayItem(widget, key));
    if (isFloatWidget) floatOverlay[key] = overlayEntry;
    overlayMap[key] = overlayEntry;
    MyApp.navigatorKey.currentState!.overlay!
        .insert(overlayEntry, above: aboveEntry, below: belowEntry);
    completerMap[key] = completer;
    return completer.future;
  }
}

// ignore: must_be_immutable
class OverlayItem extends StatelessWidget {
  OverlayManager overlayManager = Get.find<OverlayManager>();
  Widget child;
  String name;

  OverlayItem(this.child, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Offstage(
          offstage: !overlayManager.overlayStatus[name]!, child: child);
    });
  }
}
