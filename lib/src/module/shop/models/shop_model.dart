
import 'dart:ui';

import 'image.dart';

class ShopModel  {
  String name;
  String code;
  String detail;
  double rating;
  List<ImageModel>  images;


  ShopModel({
    required this.name,
    required this.code,
    required this.detail,
    required this.rating,
    required this.images
  });

  factory ShopModel.fromJson(dynamic json) {
    List<ImageModel> imageList = [];
    json['images'].forEach((e)=>{
      imageList.add(ImageModel.fromJson(e))
    });
    // List<ImageModel> imageList = json['images'].map((m){return ImageModel.fromJson(m); });
    return ShopModel(
      name: json['name'] as String,
      code: json['code'] as String,
      detail: json['detail'] as String,
      rating:  json['rating']==null?0.0: double.parse(json['rating']) ,
      images: imageList
    );
  }
}
