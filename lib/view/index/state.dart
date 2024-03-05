import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/bottom_nav.dart';
class IndexState {
  AnimationController? controller;
  Animation<Offset>? animation;
  final showSideNav = false.obs;
  final navIndex = 1.obs;
  List<BottomNav> bottomNavInfoList = [];
  IndexState() {
    ///Initialize variables
  }

}
