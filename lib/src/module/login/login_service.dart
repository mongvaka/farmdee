import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';
import 'auth_respones_model.dart';
import 'login_model.dart';

class LoginService {
  Future<AuthResponseModel> login(LoginModel model) async {
    String url = '${API_URL}/users/login';
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
      final LocalStorage storage = new LocalStorage('auth');
      storage.setItem('id', authData.id);
      storage.setItem('token', authData.token);
      print(authData.token);
      return authData;

    } catch (e) {
      print(e);
    }
    return AuthResponseModel();
  }
}