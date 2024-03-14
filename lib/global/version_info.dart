/**
 * @author Marinda
 * @date 2024/3/14 14:01
 * @description 版本详情
 */
class VersionInfo {
  String? _version;
  String? _url;

  VersionInfo({String? version, String? url}) {
    if (version != null) {
      this._version = version;
    }
    if (url != null) {
      this._url = url;
    }
  }

  String? get version => _version;
  set version(String? version) => _version = version;
  String? get url => _url;
  set url(String? url) => _url = url;

  VersionInfo.fromJson(Map<String, dynamic> json) {
    _version = json['version'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this._version;
    data['url'] = this._url;
    return data;
  }
}