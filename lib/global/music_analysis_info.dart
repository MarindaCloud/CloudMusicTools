/**
 * @author Marinda
 * @date 2024/3/11 15:00
 * @description 音乐解析结果
 */
class MusicAnalysisInfo {
  String? _type;
  String? _link;
  int? _songid;
  String? _title;
  String? _author;
  String? _lrc;
  String? _url;
  String? _pic;

  MusicAnalysisInfo(
      {String? type,
        String? link,
        int? songid,
        String? title,
        String? author,
        String? lrc,
        String? url,
        String? pic}) {
    if (type != null) {
      this._type = type;
    }
    if (link != null) {
      this._link = link;
    }
    if (songid != null) {
      this._songid = songid;
    }
    if (title != null) {
      this._title = title;
    }
    if (author != null) {
      this._author = author;
    }
    if (lrc != null) {
      this._lrc = lrc;
    }
    if (url != null) {
      this._url = url;
    }
    if (pic != null) {
      this._pic = pic;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  String? get link => _link;
  set link(String? link) => _link = link;
  int? get songid => _songid;
  set songid(int? songid) => _songid = songid;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get author => _author;
  set author(String? author) => _author = author;
  String? get lrc => _lrc;
  set lrc(String? lrc) => _lrc = lrc;
  String? get url => _url;
  set url(String? url) => _url = url;
  String? get pic => _pic;
  set pic(String? pic) => _pic = pic;

  MusicAnalysisInfo.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _link = json['link'];
    _songid = json['songid'];
    _title = json['title'];
    _author = json['author'];
    _lrc = json['lrc'];
    _url = json['url'];
    _pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['link'] = this._link;
    data['songid'] = this._songid;
    data['title'] = this._title;
    data['author'] = this._author;
    data['lrc'] = this._lrc;
    data['url'] = this._url;
    data['pic'] = this._pic;
    return data;
  }
}