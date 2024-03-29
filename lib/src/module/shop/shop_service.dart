import 'dart:convert';

import 'package:farmdee/src/module/shop/models/category_model.dart';
import 'package:farmdee/src/module/shop/models/shop_model.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';

class ShopService {
  final BasicService _baseService  =  BasicService();
  Future<BasicResponse<ShopModel>> list(ShopSearch search) async {
    String url = '/product/search-product';
    Response? res = await _baseService.post(search.toJson(), url);
    if (res?.body == null) {
      return BasicResponse();
    }
    print('this body : ${res?.body}');
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), ShopModel.fromJson);
  }
  Future<BasicResponse<ShopModel>> addProductToOrder(int productId,int optionId) async {
    String url = '/product/add-product-to-bucket';
    final LocalStorage storage = LocalStorage('auth');
    await storage.ready;
    int? buyerId =  storage.getItem('id');
    print("buyerId");
    print(buyerId);
    Response? res = await _baseService.post({
      "productId":productId,
      "sellerId":null,
      "buyerId":buyerId,
      "value":1,
      "optionId":optionId
    }, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), ShopModel.fromJson);
  }
  Future<int> countBucket()async{
    String url = '/product/count-bucket';
    final LocalStorage storage = LocalStorage('auth');
    int? userId = storage.getItem('id');
    await storage.ready;
    Response? res = await _baseService.post({"userId":userId}, url);
    if(res?.body == null){
      return 0;
    }
    return int.parse( res!.body);
  }
  Future<int> getUserId()async{
    final LocalStorage storage = LocalStorage('auth');
    int userId = storage.getItem('id');

    return userId;
  }
  Future<List<CategoryModel>> category()async{
    String url = '/product/category';
    Response? res = await _baseService.get( url);
    if(res?.body == null){
      return [];
    }
    final items = jsonDecode(utf8.decode(res!.bodyBytes)).cast<Map<String, dynamic>>();
    return List<CategoryModel>.from(items.map((itemsJson) => CategoryModel.fromJson(itemsJson)));
  }
}