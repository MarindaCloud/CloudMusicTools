import 'package:music_tools/global/music_search_info.dart';
/**
 * @author Marinda
 * @date 2024/3/14 16:21
 * @description  网易云音乐搜索结果
 */
class NetaseMusicSearch extends MusicSearchInfo{
  String? name;
  int? id;
  Author? author;
  MusicInfo? musicInfo;

  NetaseMusicSearch({this.name, this.id, this.author, this.musicInfo});

  NetaseMusicSearch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['artists'] != null) {
      List<Author> authors = [];
      json['artists'].forEach((v) {
        authors!.add(new Author.fromJson(v));
      });
      author = authors.first;
    }
    musicInfo = json['album'] != null ? new MusicInfo.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.author != null) {
      data['artists'] = [this.author!.toJson()];
    }
    if (this.musicInfo != null) {
      data['album'] = this.musicInfo!.toJson();
    }
    return data;
  }
}

class Author {
  String? name;
  int? id;
  String? picUrl;
  String? img1v1Url;

  Author({this.name, this.id, this.picUrl, this.img1v1Url});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    picUrl = json['picUrl'];
    img1v1Url = json['img1v1Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['picUrl'] = this.picUrl;
    data['img1v1Url'] = this.img1v1Url;
    return data;
  }
}

class MusicInfo {
  String? name;
  String? type;
  String? blurPicUrl;
  String? picUrl;

  MusicInfo({this.name, this.type, this.blurPicUrl, this.picUrl});

  MusicInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    blurPicUrl = json['blurPicUrl'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['blurPicUrl'] = this.blurPicUrl;
    data['picUrl'] = this.picUrl;
    return data;
  }
}