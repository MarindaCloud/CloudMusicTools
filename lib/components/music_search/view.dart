import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_tools/enum/assets_enum.dart';
import 'package:music_tools/utils/font_rpx.dart';
import 'package:music_tools/components/music_search/state.dart';
import 'package:music_tools/utils/music_util.dart';

import '../../enum/music_type.dart';
import 'logic.dart';

class MusicSearchPage extends StatelessWidget {
  final MusicSearchLogic logic;
  final MusicSearchState state;
  final MusicType type;
  final Function searchFunction;
  final Function analysisFunction;
  final Function downloadFunction;
  MusicSearchPage(this.type,this.searchFunction,this.analysisFunction,this.downloadFunction,{Key? key})
      :
        logic = Get.put(MusicSearchLogic(type)),
        state = Get
            .find<MusicSearchLogic>()
            .state,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //搜索栏
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100.rpx,
                    height: 100.rpx,
                    child: Image.asset(MusicUtil.getMusicTypeIcon(type), fit: BoxFit.fill,),
                  ),
                  SizedBox(width: 50.rpx),
                  Expanded(
                    child: SizedBox(
                      height: 100.rpx,
                      child: TextField(
                        controller: state.searchTextController,
                        decoration: InputDecoration(
                            hintText: "请输入你要搜索的内容",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.rpx),
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.rpx),
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1)
                            ),
                            contentPadding: EdgeInsets.only(left: 30.rpx,
                                right: 30.rpx,
                                top: 20.rpx,
                                bottom: 20.rpx)
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50.rpx),
                    width: 150.rpx,
                    height: 80.rpx,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.7),
                        borderRadius: BorderRadius.circular(10.rpx)
                    ),
                    child: InkWell(
                      onTap: () async{
                        state.musicSearchInfoList.value = await searchFunction(type,state.searchTextController.text);
                        state.musicSearchInfoList.refresh();
                      },
                      child: Center(
                        child: Text(
                          "搜索",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.rpx),
              alignment: Alignment.topLeft,
              child: Text(
                  "${state.netaseMusicSearchList.isEmpty ? "暂无搜索" : "搜索共计: ${state.netaseMusicSearchList.length}条" }",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SlideTransition(
                  position: state.sliderAnimation!,
                  child: Container(
                    child: Column(
                        children: [
                          if(state.musicSearchInfoList.isNotEmpty)
                            ...state.musicSearchInfoList.map((element){
                              return Container(
                                margin: EdgeInsets.only(top: 30.rpx,bottom: 30.rpx),
                                width: Get.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: SizedBox(
                                          width: 100.rpx,
                                          height: 100.rpx,
                                          child: Image.network(logic.getPic(element),fit: BoxFit.fill,)),
                                    ),
                                    SizedBox(width: 50.rpx),
                                    Expanded(
                                      child: Container(

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "${logic.getMusicName(element)}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "作者名: ${logic.getAuthor(element)}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async{
                                              await analysisFunction(type,logic.getMusicId(element));
                                            } ,
                                            child: SizedBox(
                                              width: 70.rpx,
                                              height: 70.rpx,
                                              child: Image.asset("assets/play.png",fit: BoxFit.fill,),
                                            ),
                                          ),
                                          SizedBox(width: 50.rpx),
                                          InkWell(
                                            onTap: () async{
                                              await downloadFunction(type,logic.getMusicId(element));
                                            },
                                            child: SizedBox(
                                              width: 70.rpx,
                                              height: 70.rpx,
                                              child: Image.asset("assets/download.png",fit: BoxFit.fill,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList()
                        ]
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: SlideTransition(
            //       position: state.sliderAnimation!,
            //       child: Container(
            //         child: Column(
            //           children: logic.buildSearchResult()
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 150.rpx,)
          ],
        ),
      );
    });
  }
}
