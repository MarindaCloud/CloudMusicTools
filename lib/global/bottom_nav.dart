import 'package:flutter/material.dart';

class BottomNav {
  String? text;
  int? index;
  IconData? iconData;
  BottomNav({this.text, this.index,this.iconData});

  BottomNav.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    index = json['index'];
    iconData = json["iconData"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['index'] = this.index;
    data["iconData"] = this.iconData;
    return data;
  }
}