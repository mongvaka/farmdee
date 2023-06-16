import 'order_product_model.dart';

class OrderDetailModel  {
  int id;
  int value;
  OrderProductModel product;
  double price;

  OrderDetailModel({
    required this.id,
    required this.value,
    required this.product,
    required this.price

  });

  factory OrderDetailModel.fromJson(dynamic json) {
    return OrderDetailModel(
      id:  int.parse(json['id']),
      value:  int.parse(json['value']),
      product:  OrderProductModel.fromJson(json['product']) ,
      price:  json['price'].toDouble() ,

    );
  }
}