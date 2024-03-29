import 'package:flutter/material.dart';


/*
 * @Author ZISE
 * @Description //动态计算字体大小，类似于前端的 rem
 * @Date 4:49 2022/6/11
 **/
class FontRpx {
  // 分辨率的宽度
  static late double physicalWidth;

  // 分辨率的宽度
  static late double physicalHeight;

  // 获取 dpr 倍率 @1x @2x @3x
  static late double dpr;

  // 屏幕的宽度和高度
  static late double screenWidth;
  static late double screenHeight;

  // rpx 和 px
  static late double rpx;
  static late double px;

  // 公司里提供的是1920 * 1080的分辨率
  static void initialize(BuildContext context) {
    // 1.手机物理分辨率
    physicalWidth = View.of(context).physicalSize.width;
    physicalHeight = View.of(context).physicalSize.height;
    // 2.获取 dpr 倍率 @1x @2x @3x
    dpr = View.of(context).devicePixelRatio;
    int cutSize =  MediaQuery.of(context).orientation == Orientation.landscape ? 1920 : 1080;
    // 3.屏幕的宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;
    rpx =  screenWidth / cutSize;
    // 5.rpx 和 px
    // px = screenWidth / cutSize * 2;
  }

  static double setRpx(double size) {
    return rpx * size;
  }

// static double setPx(double size) {
//   return px * size;
// }
}

extension DoubleFit on double {
  // double get px {
  //   return FontRpx.setPx(this);
  // }

  double get rpx {
    return FontRpx.setRpx(this);
  }
}

extension IntFit on int {
  // double get px {
  //   return FontRpx.setPx(toDouble());
  // } 

  double get rpx {
    return FontRpx.setRpx(toDouble());
  }
}
