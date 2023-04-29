
class HomeModel  {
  int id;
  String name;
  int pin;
  String key;
  int status;

  HomeModel({
    required this.id,
    required this.name,
    required this.pin,
    required this.status,
    required this.key
  });

  factory HomeModel.fromJson(dynamic json) {
    print(json['id']);
    return HomeModel(

      id:  int.parse(json['id']),
      name: json['name'] as String,
      pin:  int.parse(json['pin'] ) ,
      status: int.parse(json['status']),
      key: json['main']['key'] as String,
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return
      {
        'id': id,
        'name': name,
        'pin': pin,
        'status': status,
        'key': key,
      };
  }
}
