import 'dart:convert';

import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:http/http.dart';

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
}