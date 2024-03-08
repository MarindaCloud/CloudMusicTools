import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/global/netase_music_search.dart';
class MusicSearchState {
  Animation<Offset>? sliderAnimation;
  AnimationController? sliderController;
  TextEditingController searchTextController = TextEditingController();
  final netaseMusicSearchList = <NetaseMusicSearch>[].obs;
  MusicSearchState() {
    ///Initialize variables
  }
}
