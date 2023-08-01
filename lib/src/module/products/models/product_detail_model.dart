import 'package:farmdee/src/module/products/models/product_option.dart';

import '../../shop/models/image.dart';
import 'comment_model.dart';

class ProductDetailModel {
  int id;
  int categoryId;
  String name;
  String code;
  String detail;
  List<ImageModel> images;
  List<CommentModel>? comments;
  double rating;
  int sold;
  List<ProductOptionModel> options;
  ProductDetailModel(
      {required this.id,
        required this.categoryId,
      required this.name,
      required this.code,
      required this.detail,
      required this.comments,
      required this.images,
      required this.rating,
      required this.sold,
      required this.options});

  factory ProductDetailModel.fromJson(dynamic json) {
    print(json);
    List<ImageModel> imageList = [];
    List<CommentModel> commentList = [];
    List<ProductOptionModel> optionList = [];
    json['images']?.forEach((e) => {imageList.add(ImageModel.fromJson(e))});
    json['comments']
        ?.forEach((e) => {commentList.add(CommentModel.fromJson(e))});
    json['options']
        ?.forEach((e) => {optionList.add(ProductOptionModel.fromJson(e))});
    return ProductDetailModel(
        id: int.parse(json['id'] ?? 0.0),
        name: json['name'],
        categoryId: json['categoryId'],
        code: json['code'],
        detail: json['detail'],
        rating: json['rating'],
        sold: json['sold'],
        images: imageList,
        comments: commentList,
        options: optionList);
  }
  factory ProductDetailModel.empty(){
    return ProductDetailModel(
        id: 0,
        name: '',
        code: '',
        detail: '',
        comments: [],
        images: [],
        rating: 0,
        sold: 0,
        categoryId:0,
        options: []
    );
  }
  Map<String, dynamic> toJson() {
    List<dynamic> imageJsons = images.map((e) => e.toJson()).toList();
    List<dynamic> optionJsons = options.map((e) => e.toJson()).toList();
    return {
    'id': id,
    'name': name,
    'code': code,
    'detail': detail,
    'images': imageJsons,
    'options': optionJsons,
      'categoryId':categoryId
    };
  }
}
