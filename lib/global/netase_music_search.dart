class NetaseMusicSearch {
  String? name;
  int? id;
  List<Artists>? artists;
  Album? album;

  NetaseMusicSearch({this.name, this.id, this.artists, this.album});

  NetaseMusicSearch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    return data;
  }
}

class Artists {
  String? name;
  int? id;
  String? picUrl;
  String? img1v1Url;

  Artists({this.name, this.id, this.picUrl, this.img1v1Url});

  Artists.fromJson(Map<String, dynamic> json) {
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

class Album {
  String? name;
  String? type;
  String? blurPicUrl;
  String? picUrl;

  Album({this.name, this.type, this.blurPicUrl, this.picUrl});

  Album.fromJson(Map<String, dynamic> json) {
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