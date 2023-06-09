
import 'package:farmdee/src/module/products/models/product_option.dart';

import '../../shop/models/image.dart';
import 'comment_model.dart';

class ProductDetailModel  {
  int id;
  String name;
  String code;
  String detail;
  List<ImageModel>  images;
  List<CommentModel>?  comments;
  double rating;
  int sold;
  List<ProductOptionModel>  options;
  ProductDetailModel({
    required this.id,
    required this.name,
    required this.code,
    required this.detail,
    required this.comments,
    required this.images,
    required this.rating,
    required this.sold,
    required this.options
  });

  factory ProductDetailModel.fromJson(dynamic json) {
    print(json);
    List<ImageModel> imageList = [];
    List<CommentModel> commentList = [];
    List<ProductOptionModel> optionList = [];
    json['images']?.forEach((e)=>{
      imageList.add(ImageModel.fromJson(e))
    });
    json['comments']?.forEach((e)=>{
      commentList.add(CommentModel.fromJson(e))
    });
    json['options']?.forEach((e)=>{
      optionList.add(ProductOptionModel.fromJson(e))
    });
    return ProductDetailModel(
        id: int.parse(json['id']??0.0),
        name: json['name'] ,
        code: json['code'],
        detail: json['detail'] ,
        rating: json['rating'] ,
        sold: json['sold'] ,
        images: imageList,
        comments:commentList,
      options: optionList
    );
  }
}
