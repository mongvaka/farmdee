
import 'package:farmdee/src/module/switch/switch_child_model.dart';

class SwitchModel  {
  String name;
  int id;
  bool isManual;
  List<SwitchChildModel>  schedule;


  SwitchModel({required this.name,required this.schedule,required this.isManual,required this.id});

  factory SwitchModel.fromJson(dynamic json) {
    List<SwitchChildModel> scList = [];
    json['schedule'].forEach((e)=>{
      scList.add(SwitchChildModel.fromJson(e))
    });
    return SwitchModel(
        id: int.parse( json['id']),
        name:  json['name'],
        isManual: json['isManual'],
        schedule:  scList
    );

  }


  @override
  Map<String, dynamic> toJson() {
    dynamic scList = schedule.map((e) {
      return e.toJson();
    }).toList();
    print(scList);
    return
      {
        'id':id,
        'name': name,
        'isManual': isManual,
        'schedule': scList,
      };
  }
}
