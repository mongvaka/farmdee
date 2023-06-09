
import 'dart:ui';

import 'package:farmdee/src/module/products/models/product_option.dart';

import 'image.dart';

class ShopModel  {
  int id;
  String name;
  String code;
  String detail;
  double rating;
  double minPrice;
  double maxPrice;
  List<ImageModel>  images;
  List<ProductOptionModel>  options;

  ShopModel({
    required this.id,
    required this.name,
    required this.code,
    required this.detail,
    required this.rating,
    required this.images,
    required this.minPrice,
    required this.maxPrice,
    required this.options,
  });

  factory ShopModel.fromJson(dynamic json) {
    print(json['rating']);
    List<ImageModel> imageList = [];
    List<ProductOptionModel> _option = [];
    json['images'].forEach((e)=>{
      imageList.add(ImageModel.fromJson(e))
    });
    json['options'].forEach((e)=>{
      _option.add(ProductOptionModel.fromJson(e))
    });

    ProductOptionModel _maxPrice = _option.reduce((a, b) {
      if (a.price > b.price){
        return a;
      }

      else{
        return b;
      }

    });
    ProductOptionModel _minPrice = _option.reduce((a, b) {
      if (a.price > b.price){
        return b;
      }
      else{
        return a;
      }

    });
    // List<ImageModel> imageList = json['images'].map((m){return ImageModel.fromJson(m); });
    return ShopModel(
      id: int.parse(json['id']??0.0),
      name: json['name'] as String,
      code: json['code'] as String,
      detail: json['detail'] as String,
      rating:  json['rating']==null?0.0: json['rating'] ,
      images: imageList,
      minPrice: _minPrice.price.toDouble(),
      maxPrice: _maxPrice.price.toDouble(),
      options: _option
    );
  }
}
