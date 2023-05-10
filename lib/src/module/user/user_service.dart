import 'dart:convert';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../../shared/basic_respones.dart';
import '../../utils/constants.dart';
class UserService {
  Future<UserModel> getById() async {
    final LocalStorage storage = new LocalStorage('auth');

    String url = '${API_URL}/users/get-user';
    String? token =  storage.getItem('token');
    int? id =  storage.getItem('id');
    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {

      Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode({'id':id}),
        encoding: Encoding.getByName("utf-8"),
        headers: header,
      );
      if (res.body == null) {
        return UserModel(lastName: '', firstName: '', email: '');
      }
      return UserModel.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      print(e);
    }
    return UserModel(lastName: '', firstName: '', email: '');
  }
}