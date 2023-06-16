import 'dart:convert';

import 'package:farmdee/src/module/bucket/model/bucket_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';
import '../home/home_search.dart';

class BucketService {
  BasicService baseService  =  BasicService();
  Future<BasicResponse<BucketModel>> list(HomeSearch search) async {
    String url = '/product/search-product-in-bucket';
    final LocalStorage storage = LocalStorage('auth');
    int? buyerId = storage.getItem('id');
    Response? res = await baseService.post({'buyerId':buyerId}, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    print(res?.body);
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), BucketModel.fromJson);
  }
  Future<bool> removeProductInBucket(int id) async{
    String url = '/product/delete-product-in-bucket';
    Response? res = await baseService.post({'id':id}, url);
    print(res?.body);
    return res?.body != null;
  }
  Future<bool> createOrder(List<Map<String,dynamic>> orders) async{
    String url = '/product/create-order';
    final LocalStorage storage = LocalStorage('auth');
    int? buyerId = storage.getItem('id');
    Response? res = await baseService.post({"ordersDetail":orders,"buyerId":buyerId}, url);
    print(res?.body);
    return res?.body != null;
  }
}