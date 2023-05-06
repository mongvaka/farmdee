import 'dart:convert';
import 'package:farmdee/src/module/switch/switch_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';

class SwitchService {
  Future<SwitchModel?> getById(int childId) async {
    final LocalStorage storage = new LocalStorage('auth');

    String url = '${API_URL}/esp/child';
    String? token =  storage.getItem('token');

    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {

      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode({'id':childId}),
        encoding: Encoding.getByName("utf-8"),
        headers: header,
      );
      // print('body');
      // print(token);
      // print('body');
      // print(res.headers['Authorization']);
      if (res.body == null) {
        return null;
      }
      return SwitchModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
    } catch (e,t) {
      print(t);
      print(e);
    }
    return null;
  }
  Future<bool> createSchedule(SwitchModel model) async {
    String url = '${API_URL}/esp/create-schedule';
    final LocalStorage storage = new LocalStorage('auth');

    try {
      String? token =  storage.getItem('token');

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
    } catch (e,t) {
      print(e);
      print(t);
      return false;
    }
  }
  Future<bool> deleteSchedule(int scheduleId) async {
    String url = '${API_URL}/esp/delete-schedule';
    final LocalStorage storage = new LocalStorage('auth');

    try {
      String? token =  storage.getItem('token');

      // print(jsonDecode(login.body)['token']);
      if (token == null) {
        throw 'Cannot get token from hive.';
      }
      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode({'id':scheduleId}),
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