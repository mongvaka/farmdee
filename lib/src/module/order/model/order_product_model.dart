class OrderProductModel {
  String name;
  List<String>  images;

  OrderProductModel({
    required this.name,
    required this.images
  });

  factory OrderProductModel.fromJson(dynamic json) {
    List<String> productImages = [];
    json['images']?.forEach((e)=>{
      productImages.add(e['url'])
    });

    return OrderProductModel(
      name: json['name'],
      images: productImages
    );
  }
}