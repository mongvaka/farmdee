import 'dart:convert';
import 'package:farmdee/src/module/user/model/edit_profile_model.dart';
import 'package:farmdee/src/module/user/model/sensor_count_model.dart';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../../shared/basic_service.dart';
class UserService {

  BasicService baseService  =  BasicService();
  Future<UserModel> getById() async {
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int? id =  storage.getItem('id');
    String url = '/users/get-user';
    Response res = await baseService.post({'id':id}, url);
    if (res?.body == null) {
      return UserModel(lastName: '', firstName: '', email: '');
    }
    return UserModel.fromJson(jsonDecode(utf8.decode(res!.bodyBytes)));
  }
  Future<List<Map<String,dynamic>>> getOrderNotification() async {
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int? id =  storage.getItem('id');
    String url = '/product/notice/$id';
    Response? res = await baseService.get(url);
    if (res?.body == null) {
      return [];
    }
    return List<Map<String,dynamic>>.from(jsonDecode(res!.body));
  }
  Future<bool> editUserProfile(EditProfileModel model) async{
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    model.id =  storage.getItem('id');
    String url = '/users/edit-user-profile/';
    Response? res = await baseService.post(model.toJson(), url);
    return res!=null;
  }

  Future<SensorCountModel> getSensorCount()  async {
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int  id =  storage.getItem('id');
    String url = '/users/all-sensor/';
    Response? res = await baseService.post({"userId":id}, url);
    return SensorCountModel.fromJson(jsonDecode(res.body));
  }

}