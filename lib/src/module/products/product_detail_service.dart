import 'dart:convert';

import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

import '../../shared/basic_service.dart';

class ProductDetailService {
  final BasicService _baseService  =  BasicService();
  Future<ProductDetailModel?> getProductDetail(int id) async {
    String url = '/product/product-detail';
    Response? res = await _baseService.post({"id":id}, url);
    if (res?.body == null) {
      return null;
    }
    return ProductDetailModel.fromJson(jsonDecode(utf8.decode(res!.bodyBytes)));
  }
  Future<bool> addProductToOrder(int productId,int value,int optionId) async {
    String url = '/product/add-product-to-bucket';
    final LocalStorage storage = LocalStorage('auth');
    int? buyerId = storage.getItem('id');
    Response? res = await _baseService.post(
        {"productId":productId,
        "buyerId":buyerId,
          "sellerId":null,
        "value":value,
        "optionId":optionId},
        url);
    if (res?.body == null) {
      return false;
    }
    return true;
  }
}