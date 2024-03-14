import 'package:music_tools/global/music_analysis_info.dart';
import 'package:music_tools/global/music_search_info.dart';

/**
 * @author Marinda
 * @date 2024/3/14 16:03
 * @description QQ音乐信息
 */
class QQMusicInfo extends MusicSearchInfo implements MusicAnalysisInfo{
  String? _songname;
  String? _name;
  String? _album;
  int? _type;
  int? _songid;
  int? _bpm;
  String? _cover;
  String? _songurl;
  String? _src;

  QQMusicInfo(
      {String? songname,
        String? name,
        String? album,
        int? type,
        int? songid,
        int? bpm,
        String? cover,
        String? songurl,
        String? src}) {
    if (songname != null) {
      this._songname = songname;
    }
    if (name != null) {
      this._name = name;
    }
    if (album != null) {
      this._album = album;
    }
    if (type != null) {
      this._type = type;
    }
    if (songid != null) {
      this._songid = songid;
    }
    if (bpm != null) {
      this._bpm = bpm;
    }
    if (cover != null) {
      this._cover = cover;
    }
    if (songurl != null) {
      this._songurl = songurl;
    }
    if (src != null) {
      this._src = src;
    }
  }

  String? get songname => _songname;
  set songname(String? songname) => _songname = songname;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get album => _album;
  set album(String? album) => _album = album;
  int? get type => _type;
  set type(int? type) => _type = type;
  int? get songid => _songid;
  set songid(int? songid) => _songid = songid;
  int? get bpm => _bpm;
  set bpm(int? bpm) => _bpm = bpm;
  String? get cover => _cover;
  set cover(String? cover) => _cover = cover;
  String? get songurl => _songurl;
  set songurl(String? songurl) => _songurl = songurl;
  String? get src => _src;
  set src(String? src) => _src = src;

  QQMusicInfo.fromJson(Map<String, dynamic> json) {
    _songname = json['songname'];
    _name = json['name'];
    _album = json['album'];
    _type = json['type'];
    _songid = json['songid'];
    _bpm = json['bpm'];
    _cover = json['cover'];
    _songurl = json['songurl'];
    _src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songname'] = this._songname;
    data['name'] = this._name;
    data['album'] = this._album;
    data['type'] = this._type;
    data['songid'] = this._songid;
    data['bpm'] = this._bpm;
    data['cover'] = this._cover;
    data['songurl'] = this._songurl;
    data['src'] = this._src;
    return data;
  }
}
