import 'package:http/http.dart';

import '../../shared/basic_service.dart';
import 'dart:developer';

class SetWifiService {
  final BasicService _baseService  =  BasicService();
  Future<bool> setWifi(String  userName,String password) async {
    print('setWifi Request');
    String url = 'http://192.168.4.1/wifisave';
    Response? res = await _baseService.setWifiPassword(userName,password, url);
    if (res?.body == null) {
      return false;
    }
    return true;
  }
  Future<bool> getWifi() async {
    print('get');
    String url = 'http://192.168.4.1/wifi?';
    Response? res = await _baseService.getWifiPages(url);
    // print(res);
    if (res?.body == null) {
      return false;
    }
    return true;
  }
}