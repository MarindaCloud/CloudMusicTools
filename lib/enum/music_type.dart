/**
 * @author Marinda
 * @date 2024/3/13 11:12
 * @description 音乐类型
 */
enum MusicType{
  netase("网易云音乐"),qq("QQ音乐"),kg("全民K歌");

  const MusicType(this.type);
  final String type;
}