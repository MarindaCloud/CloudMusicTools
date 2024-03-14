import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_tools/controller/music_controller/logic.dart';
import 'package:music_tools/global/app_pages.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/utils/log.dart';
import 'package:music_tools/utils/overlay_manager.dart';
import 'dart:ui';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Log.initLogger();
  await initSetting();
  if(window.physicalSize.isEmpty){
  window.onMetricsChanged = (){
  //在回调中，size仍然有可能是0
  if(!window.physicalSize.isEmpty) {
    window.onMetricsChanged = null;
    runApp(MyApp());
    }
  };
  } else{
  //如果size非0，则直接runApp
    runApp(MyApp());
  }

}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FontRpx.initialize(context);
    return GetMaterialApp(
      title: '音乐工具',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: BotToastInit(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppPages.index,
      getPages:AppPages.routes,
    );
  }
}


initSetting() async{
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await GetStorage.init();
  Get.put(OverlayManager());
  Get.put(MusicControllerLogic());
}