
import 'dart:ui';

import '../../message/models/answer_model.dart';

class CreateProductOptionModel  {
  String name;
  double price;
  int? id;


  CreateProductOptionModel({
    required this.name,
    required this.price,
    required this.id
  });

  factory CreateProductOptionModel.fromJson(dynamic json) {
    return CreateProductOptionModel(
      id: int.parse(json['id']),
      name: json['name'],
      price: json['price'].toDouble()  ,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
