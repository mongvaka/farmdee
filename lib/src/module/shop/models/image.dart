
class ImageModel  {
  String name;
  String url;
  String type;

  ImageModel({
    required this.name,
    required this.url,
    required this.type
  });

  factory ImageModel.fromJson(dynamic json) {
    return ImageModel(
      name: json['name'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return
      {
        'name': name,
        'url': url,
        'type': type,
      };
  }
}
