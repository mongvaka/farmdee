import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';
import 'home_model.dart';
import 'home_search.dart';

class HomeService {
  Future<BasicResponse<HomeModel>> list(HomeSearch search) async {
    final LocalStorage storage = new LocalStorage('auth');

    String url = '${API_URL}/esp/esp-child';
    String? token =  storage.getItem('token');

    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token;'
    };
    try {

      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(search.toJson()),
        encoding: Encoding.getByName("utf-8"),
        headers: header,
      );
      // print('body');
      // print(token);
      // print('body');
      // print(res.headers['Authorization']);
      if (res.body == null) {
        return BasicResponse();
      }
      return BasicResponse.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes)), HomeModel.fromJson);
    } catch (e) {
      print(e);
    }
    return BasicResponse();
  }
  Future<bool> switchStatus(HomeModel model) async {
    String url = '${API_URL}/esp/switch-status';
    try {
      String? token =  'thisToken';
      // print(jsonDecode(login.body)['token']);
      if (token == null) {
        throw 'Cannot get token from hive.';
      }
      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(model.toJson()),
        encoding: Encoding.getByName("utf-8"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if(res.body!=null){
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}