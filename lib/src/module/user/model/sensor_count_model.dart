import '../../../utils/data_hepler.dart';

class SensorCountModel {
  int sensorCount;
  int controllerCount;
  int lightSensor;
  int tempSensor;
  int homSensor;

  SensorCountModel(
      {required this.sensorCount,
      required this.controllerCount,
      required this.lightSensor,
      required this.tempSensor,
      required this.homSensor});

  factory SensorCountModel.fromJson(dynamic json) {
    print('objectccc : ${json["controllerCount"]}');
    print('controllerCount : ${DataHelper.toInt(json["controllerCount"])}');

    return SensorCountModel(
        sensorCount: DataHelper.toInt(json["sensorCount"]) ,
        controllerCount: DataHelper.toInt(json["controllerCount"]),
        lightSensor: DataHelper.toInt(json["lightSensor"]),
        tempSensor: DataHelper.toInt(json["tempSensor"]),
        homSensor: DataHelper.toInt(json["homSensor"]));
  }
  factory SensorCountModel.empty() {
    return SensorCountModel(
        sensorCount: 0,
        controllerCount: 0,
        lightSensor: 0,
        tempSensor:0,
        homSensor: 0);
  }
}
