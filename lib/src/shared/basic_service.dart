import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class BasicService {
  Future<Response?> post(dynamic json,String urlStr) async {
    final LocalStorage storage =  LocalStorage('auth');
    await storage.ready;
    String url = '$API_URL$urlStr';
    String? token =  storage.getItem('token');
    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(json),
        encoding: Encoding.getByName("utf-8"),
        headers: header,
      );
      return res;

    } catch (e) {
      print(e);
      return Future(() => null);
    }
  }
  Future<Response?> get(String urlStr) async {
    final LocalStorage storage =  LocalStorage('auth');
    await storage.ready;
    String url = '$API_URL$urlStr';
    String? token =  storage.getItem('token');
    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response res = await http.get(
        Uri.parse(url),
        headers: header,
      );
      print(res.body);
      return res;

    } catch (e) {
      print(e);
      return Future(() => null);
    }
  }
  Future<Response?> getWifiPages(String urlStr) async {

    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      Response res = await http.get(
        Uri.parse(urlStr),
        headers: header,
      );
      print(res.body);
      return res;

    } catch (e) {
      print(e);
      return Future(() => null);
    }
  }
  Future<Response?> setWifiPassword(String s,String p,String urlStr) async {
    Map<String,String> header = {
      'Content-Type': 'text/html',
      'Access-Control-Allow-Origin': '*',
      'Accept-Encoding': 'gzip, deflate',
      'Accept-Language': 'en-US,en;q=0.9',
      'Cache-Control': 'max-age=0',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Host': '192.168.4.1',
      'Origin': 'http://192.168.4.1',
      'Referer': 'http://192.168.4.1/wifi?',
      'Upgrade-Insecure-Requests': '1',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
      'Keep-Alive': 'timeout=2000'
    };
    var map = new Map<String, dynamic>();
    map['s'] = s;
    map['p'] = p;
    log(urlStr);
    try {
      Response res = await http.post(
        Uri.parse(urlStr),
        body: map,
        encoding: Encoding.getByName("utf-8"),

      );
      print('thesResStatus: ${res.statusCode}');
      log(res!.body);

      return res;

    } catch (e) {
      print('thisError  : $e');
      return Future(() => null);
    }
  }
}