import 'dart:convert';

import 'package:farmdee/src/module/shop/models/shop_model.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:http/http.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';

class ShopService {
  BasicService baseService  =  BasicService();
  Future<BasicResponse<ShopModel>> list(ShopSearch search) async {
    String url = '/product/search-product';
    Response? res = await baseService.post(search.toJson(), url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), ShopModel.fromJson);
  }
}