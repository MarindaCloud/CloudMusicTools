/**
 * @author Marinda
 * @date 2024/3/8 16:50
 * @description 网络请求Type枚举
 */
enum RequestType{
  netaseMusicSearch("http://music.163.com/api/search/pc"),
  musicAnalysis("https://daga.cc/yue/");
  const RequestType(this.path);
  final String path;
}