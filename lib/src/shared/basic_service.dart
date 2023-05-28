import 'dart:convert';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class BasicService {
  Future<Response?> post(dynamic json,String urlStr) async {
    final LocalStorage storage = new LocalStorage('auth');
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
}