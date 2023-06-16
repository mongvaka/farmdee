import 'dart:convert';

import 'package:farmdee/src/module/order/model/order_model.dart';
import 'package:farmdee/src/module/order/order_search.dart';
import 'package:http/http.dart';

import '../../shared/basic_respones.dart';
import '../../shared/basic_service.dart';

class OrderService {
  final BasicService _baseService  =  BasicService();
  Future<BasicResponse<OrderModel>> list(OrderSearch search) async {
    String url = '/product/search-order';
    Response? res = await _baseService.post(search.toJson(), url);
    if (res?.body == null) {
      return BasicResponse();
    }
    return BasicResponse.fromJson(
        jsonDecode(utf8.decode(res!.bodyBytes)), OrderModel.fromJson);
  }
}