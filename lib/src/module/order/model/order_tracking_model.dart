class OrderTrackingModel  {
  int id;
  int orderId;
  String status;
  DateTime statusDate;
  String reason;

  OrderTrackingModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.statusDate,
    required this.reason,
  });

  factory OrderTrackingModel.fromJson(dynamic json) {
    return OrderTrackingModel(
        id:  int.parse(json['id']),
        orderId:  int.parse(json['orderId']),
        status:  json['status'],
        statusDate: DateTime.parse( json['statusDate']),
        reason: json['reason'],
    );
  }
}