
import '../../shop/models/image.dart';
import 'comment_model.dart';

class ProductDetailModel  {
  int id;
  String name;
  String code;
  String detail;
  List<ImageModel>  images;
  List<CommentModel>  comments;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.code,
    required this.detail,
    required this.comments,
    required this.images
  });

  factory ProductDetailModel.fromJson(dynamic json) {
    print(json);
    List<ImageModel> imageList = [];
    List<CommentModel> commentList = [];
    json['images']?.forEach((e)=>{
      imageList.add(ImageModel.fromJson(e))
    });
    json['comments']?.forEach((e)=>{
      commentList.add(CommentModel.fromJson(e))
    });
    return ProductDetailModel(
        id: int.parse(json['id']??0.0),
        name: json['name'] ,
        code: json['code'],
        detail: json['detail'] ,
        images: imageList,
        comments:commentList
    );
  }
}
