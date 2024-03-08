import 'package:get/get.dart';
import 'package:music_tools/view/index/binding.dart';
import 'package:music_tools/view/index/view.dart';
import 'package:music_tools/view/netase_music_cloud/binding.dart';
import 'package:music_tools/view/netase_music_cloud/view.dart';

class AppPages{
  static String index = "/index";
  static String netaseMusicCloud = "/netaseMusicCloud";

  static final routes = [
    GetPage(name: index, page: ()=>IndexPage(),binding: IndexBinding()),
    GetPage(name: netaseMusicCloud, page: ()=>NetaseMusicCloudPage(),binding: NetaseMusicCloudBinding()),

  ];
}