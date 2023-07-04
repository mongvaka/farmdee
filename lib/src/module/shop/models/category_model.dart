
class CategoryModel  {
  String name;
  String description;
  int id;

  CategoryModel({
    required this.name,
    required this.description,
    required this.id
  });

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      name: json['name'],
      description: json['description'] ,
      id: int.parse(json['id']) ,
    );
  }



}