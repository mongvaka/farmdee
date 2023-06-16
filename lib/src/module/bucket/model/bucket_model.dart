
import 'package:farmdee/src/module/products/models/product_detail_model.dart';

class BucketModel  {
  int id;
  int buyerId;
  int value;
  int optionId;
  int productId;
  bool activate;
  ProductDetailModel product;

  BucketModel({
    required this.id,
    required this.value,
    required this.buyerId,
    required this.optionId,
    required this.product,
    required this.productId,
    required this.activate,
  });

  factory BucketModel.fromJson(dynamic json) {
    return BucketModel(
      id:  int.parse(json['id']),
      buyerId:  int.parse(json['buyerId']),
      value:  int.parse(json['value']),
      optionId:  int.parse(json['optionId']),
      productId:  int.parse(json['productId']),
      product: ProductDetailModel.fromJson(json['product']),
      activate: json['activate']
    );
  }
}
