import 'dart:convert';

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
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), ShopModel.fromJson);
  }
  Future<BasicResponse<ShopModel>> addProductToOrder(int productId) async {
    String url = '/product/create-order';
    final LocalStorage storage = LocalStorage('auth');
    int? buyerId =  storage.getItem('id');
    print("buyerId");
    print(buyerId);
    Response? res = await _baseService.post({
      "productId":productId,
      "sellerId":null,
      "buyerId":buyerId,
      "value":1
    }, url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), ShopModel.fromJson);
  }
}