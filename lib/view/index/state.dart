import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/bottom_nav.dart';
import '../../global/version_info.dart';
class IndexState {
  AnimationController? controller;
  Animation<Offset>? animation;
  final showSideNav = false.obs;
  final backFlag = false.obs;
  final navIndex = 1.obs;
  Rx<Widget> contentWidget = Rx(Container());
  List<BottomNav> bottomNavInfoList = [];
  VersionInfo versionInfo = VersionInfo();
  final downloadProgress = 0.0.obs;
  IndexState() {
    ///Initialize variables
  }

}
