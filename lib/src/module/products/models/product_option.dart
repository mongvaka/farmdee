
import 'dart:ui';

import '../../message/models/answer_model.dart';

class ProductOptionModel  {
  String name;
  double price;
  int? id;


  ProductOptionModel({
    required this.name,
    required this.price,
    required this.id
  });

  factory ProductOptionModel.fromJson(dynamic json) {
      return ProductOptionModel(
        id: int.parse(json['id']),
        name: json['name'],
        price: json['price'].toDouble()  ,
      );



  }
}
