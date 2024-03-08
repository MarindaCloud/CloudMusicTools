import 'package:flutter/material.dart';
import 'package:music_tools/utils/font_rpx.dart';

/**
 * @author Marinda
 * @date 2024/3/5 17:49
 * @description 自定义的卡片组件
 */
class CustomCard extends StatelessWidget{
  Color? textColor;
  Function onTap;
  double? height;
  String assets;
  String? text;
  CustomCard(this.text,this.assets,this.onTap,{this.height,this.textColor,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.only(
            top: 20.rpx, bottom: 20, right: 10.rpx, left: 10.rpx),
        height: height ?? 300.rpx,
        decoration:
        BoxDecoration(color: Colors.white38, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: Offset(5, 5),
              blurRadius: 10,
              blurStyle: BlurStyle.solid),
        ]),
        child: Column(
          children: [
            Container(
              margin:
              EdgeInsets.only(bottom: 30.rpx, top: 30.rpx),
              child: SizedBox(
                width: 100.rpx,
                height: 100.rpx,
                child: Image.asset(
                  "${assets}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.rpx),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "${text}",
                      style: TextStyle(color: textColor ?? Colors.red),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}