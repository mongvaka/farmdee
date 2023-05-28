import 'dart:convert';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../../shared/basic_service.dart';
class UserService {
  BasicService baseService  =  BasicService();
  Future<UserModel> getById() async {
    final LocalStorage storage = LocalStorage('auth');
    int? id =  storage.getItem('id');
    String url = '/users/get-user';
    Response? res = await baseService.post({'id':id}, url);
    if (res?.body == null) {
      return UserModel(lastName: '', firstName: '', email: '');
    }
    print(res?.body);
    return UserModel.fromJson(jsonDecode(utf8.decode(res!.bodyBytes)));
  }
}