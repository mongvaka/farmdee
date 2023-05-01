
class SwitchModel  {
  int id;
  String startTime;
  String endTime;


  SwitchModel({
    required this.id,
    required this.startTime,
    required this.endTime
  });

  factory SwitchModel.fromJson(dynamic json) {
    return SwitchModel(
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
