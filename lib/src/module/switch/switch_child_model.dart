
class SwitchChildModel  {
  int id;
  String startTime;
  String endTime;


  SwitchChildModel({
    required this.id,
    required this.startTime,
    required this.endTime
  });

  factory SwitchChildModel.fromJson(dynamic json) {
    print('onMA=p');
    print(json);
    return SwitchChildModel(
      id:  int.parse(json['id']),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return
      {
        'id': id,
        'startTime': startTime,
        'endTime': endTime
      };
  }
}
