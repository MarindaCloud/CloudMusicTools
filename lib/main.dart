import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_tools/global/app_pages.dart';
import 'package:music_tools/utils/font_rpx.dart';
void main() {
  initSetting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppPages.index,
      getPages:AppPages.routes,
    );
  }
}


initSetting() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await GetStorage.init();
}