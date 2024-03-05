import 'package:get/get.dart';
import 'package:music_tools/view/index/binding.dart';
import 'package:music_tools/view/index/view.dart';

class AppPages{
  static String index = "/index";

  static final routes = [
    GetPage(name: index, page: ()=>IndexPage(),binding: IndexBinding())
  ];
}