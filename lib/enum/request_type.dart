/**
 * @author Marinda
 * @date 2024/3/8 16:50
 * @description 网络请求Type枚举
 */
enum RequestType{
  netaseMusicSearch("http://music.163.com/api/search/pc"),
  musicAnalysis("https://daga.cc/yue/"),
  normal(""),
  qqMusicAnalysis("https://api.xingzhige.com/API/QQmusicVIP/?name=&uin=&skey=&mode=&type=json&n=1&max=10&br=7&format=lrc&mid=&songid=value&song_type="),
  qqMusicSearch("https://api.xingzhige.com/API/QQmusicVIP/?name=value"),
  newVersion("http://175.24.177.189/api/verifyVersion.php");
  const RequestType(this.path);
  final String path;

  /*
   * @author Marinda
   * @date 2024/3/14 16:10
   * @description 获取转化占位符的路径
   */
  String getParsePlaceholderPath(String value){
    String path = this.path;
    return path.replaceFirst("value", "$value");
  }
}