import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/global/music_search_info.dart';
import 'package:music_tools/global/netase_music_search.dart';

import '../../enum/music_type.dart';
class MusicSearchState {
  Animation<Offset>? sliderAnimation;
  AnimationController? sliderController;
  TextEditingController searchTextController = TextEditingController();
  final netaseMusicSearchList = <NetaseMusicSearch>[].obs;
  final musicSearchInfoList = <MusicSearchInfo>[].obs;
  final downloadProgress = 0.0.obs;
  final musicType = MusicType.netase.obs;
  MusicSearchState() {
    ///Initialize variables
  }
}
