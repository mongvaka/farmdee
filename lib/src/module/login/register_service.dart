import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';
import 'auth_respones_model.dart';
import 'login_model.dart';
import 'register_model.dart';

class RegisterService {
  Future<AuthResponseModel> register(RegisterModel model) async {
    print('register');
    String url = '${API_URL}/users/register';
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
      if (res.body == null) {
        return AuthResponseModel();
      }
      AuthResponseModel authData =  AuthResponseModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      final LocalStorage storage =  LocalStorage('auth');
      await storage.ready;
      storage.setItem('id', authData.userId);
      storage.setItem('token', authData.token);
      return authData;

    } catch (e) {
      print(e);
    }
    return AuthResponseModel();
  }
}