import 'dart:convert';
import 'package:farmdee/src/shared/basic_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';
import 'home_model.dart';
import 'home_search.dart';
class HomeService {
  BasicService baseService  =  BasicService();
  Future<BasicResponse<HomeModel>> list(HomeSearch search) async {
    String url = '/esp/esp-child';
    Response? res = await baseService.post(search.toJson(), url);
      if (res?.body == null) {
        return BasicResponse();
      }
      return BasicResponse.fromJson(
          jsonDecode(utf8.decode(res!.bodyBytes)), HomeModel.fromJson);
  }
  Future<bool> switchStatus(HomeModel model) async {
    String url = '/esp/switch-status';
    Response? res = await baseService.post(model.toJson(), url);
    if(res?.body!=null){
        return true;
    }
    return false;
  }
}