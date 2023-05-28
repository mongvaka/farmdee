import 'dart:convert';

import 'package:farmdee/src/module/search_hardware/search_hardware_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import '../../shared/basic_function.dart';
import '../../shared/basic_service.dart';
import 'package:http/http.dart' as http;


class SearchHardwareService {
  BasicService baseService  =  BasicService();
  Future<List<SearchHardwareModel> > list(List<String> keyFound) async {
    print(keyFound);
    String url = '/esp/pre-activate';
    Response? res = await baseService.post({'keys':keyFound}, url);
    if(res!=null){
      return List<SearchHardwareModel>.from( jsonDecode(utf8.decode(res!.bodyBytes)).map((itemsJson) => SearchHardwareModel.fromJson(itemsJson)));
    }
    return [];
  }
  Future<SearchHardwareModel?> activate(String key , String? email,String? password) async{
    String url = '/esp/activate';
    final LocalStorage storage = LocalStorage('auth');
    int? ownerId =  storage.getItem('id');
    Response? res = await baseService.post({'ownerId':ownerId,'key':key,'email':email,'password':password}, url);
    if(res!=null){
      return SearchHardwareModel.fromJson(jsonDecode(utf8.decode(res!.bodyBytes)));
    }
    return null;
  }

}