import 'dart:convert';

import 'package:music_tools/enum/request_type.dart';
import 'package:music_tools/global/netase_music_search.dart';
import 'package:music_tools/network/base_provider.dart';

/**
 * @author Marinda
 * @date 2024/3/8 17:05
 * @description  音乐API
 */
class MusicAPI{

  /*
   * @author Marinda
   * @date 2024/3/8 17:09
   * @description 发送网易云解析请求
   */
  static sendMusicAnalysis(String searchContent,String type) async{
    Map<String,dynamic> headers = {
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      "X-Requested-With": "XMLHttpRequest"
    };
    Map<String,dynamic> data = {
      "input": searchContent,
      "filter": "${type}",
      "type": "netease",
      "page": "1"
    };
    return await BaseProvider.sendRequestTypePost(RequestType.musicAnalysis, data,header: headers);
  }


  /*
   * @author Marinda
   * @date 2024/3/8 17:10
   * @description 发送网易云搜索
   */
  static sendSearchNeteaseMusic(String content) async{
    String data = "?s=${content}&limit=100&type=1";
    var headers = {
      "Cookie": " NMTID=00OMk6e9ekNU6hVkkmehuQaHBNozywAAAGMNBSpYw; __remember_me=true; _ntes_nnid=6926017e84b71169524526166e90bd8e,1701680819089; _ntes_nuid=6926017e84b71169524526166e90bd8e; WEVNSM=1.0.0; WNMCID=toxccx.1701680820484.01.0; WM_TID=UBBAMSqAlptBBBFEAEbF0IX4Pi3d5asG; ntes_utid=tid._.d%252Bvn8oNY4NxARwVRURPAxdGsbizZ6EOP._.0; sDeviceId=YD-tBV0FdoTLCRBVwRARFPBfEHLsYnHy%2BOn; __csrf=10faee938bd5db3dee04b2587ab93051; MUSIC_U=004A3B153C51231C6DAC78D7E9E8452B5B3AD274A2F92BE3C5A6F5F9289DE2A1B6B430CC1A26911B239DAE9E7E58B713358114FA636BFE890C61DA3481FB7BE6E036A375C59B56445EE09F760CFA07CC61390983F560F7B2F63273ABB7320883F609A58DF593F5B802E0E4AB6E346BF402CB016FEA7ABDCD035CA14B73DE082713231778F72F33FE517E4864B8716A4603AEFC563FED0D9A8337B40D3B7392C50EE3B38D21B45F3F4F7782017366EF53EC77EA1620867E05B9CA8AAD785D65EC97AB1762304F0FF638959ED3D321484E10DCDE2BC7999A650453D8523B13B3E9658DC569652AA732F97AE7E45775B9BD3E3DD4727BB824E6F2F4A207244C531AF81DCC0FC8704E299915025C340118B271C54BCF508146EE1F81F3A9A6CF966A9A704D1DBAFAB23A0F3BC9602B9C31C1B7E1EE15B3647EBF7AF190B608BD3C7DE2EAC6BA0D70B4B049FE2327B8E870A564F7FEB1518135CC71E9DD6E8218AAA63A; __csrf=7267a70161c88538f6fc4f0f2204e9e2; WM_NI=CKPKhh8HEXRbUxYkVQxHPF6YfBgcblyeDbXsFOEGqwi%2FiOaKh4lChbZLiMzFBpdHOJ4e5ZIAFhsxmX62EVjl%2FBwsfu4%2BXYM43t4hufw1G1HISUK50Wf0e0lFe8JlZTVhQVo%3D; WM_NIKE=9ca17ae2e6ffcda170e2e6eea8f07297efa08ab643879a8bb2c54f978a8a82c53e8698feafef3ae9e9a59bdb2af0fea7c3b92a8195a0aceb64fc988bb9d16a97a8978cd55bbc98a0a7b553a69ea984e168bbbb8c83db7986918ba8f47dabf1a7b0e441aceca4a4eb6a9a94a7aef94e82b0aca9ce42f8bbfbbbcc4b86b8bd99f054f6ee8bb7e968ed9eb994e57ff8f598bad040f1acfc89f86eb5ef89d2cb43918b85d6b35da6f0abd1ef4ea7e8868dd96096b89fb7ee37e2a3; ntes_kaola_ad=1; JSESSIONID-WYYY=kHXeV8pF4R40t07lHt%2FhWfQQyPFwAj4%2BEBZo80E%2BscuSRlrlU2hvH4hjIJtsS5P8kIkzTijFoetsW1%2Be9kJDa88%2Byhk2AfPF3bfQNAtF%2FIyeBB5hNX1vMMxYGQ9BsjnjJQZOOKSyXD2AetqJWQivm4dDmRaFJYhvBfSebthVrYZzt2CS%3A1709622499137; _iuqxldmzr_=33"
    };
    var response = await BaseProvider.sendRequestTypeGet(RequestType.netaseMusicSearch, data,header: headers);
    var decodeData = json.decode(response);
    var result = decodeData["result"]["songs"];
    if(result is List){
      var searchInfoList = result.map((e) => NetaseMusicSearch.fromJson(e)).toList();
      print('搜索详情列表 ${searchInfoList.length}');
      return searchInfoList;
    }
    return null;
  }
}