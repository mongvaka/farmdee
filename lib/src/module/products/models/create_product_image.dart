class CreateProductImageModel  {
  String name;
  String url;
  String type;
  int productId;


  CreateProductImageModel({
    required this.name,
    required this.url,
    required this.type,
    required this.productId,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'type': type,
      'productId': productId,
    };
  }
}