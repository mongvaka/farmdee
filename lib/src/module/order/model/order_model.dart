import 'package:farmdee/src/module/order/model/order_detail_model.dart';
import 'package:farmdee/src/module/order/model/order_tracking_model.dart';

class OrderModel  {
  int id;
  String orderNumber;
  int buyerId;
  DateTime? oderDate;
  String status;
  String? deliveryTag;
  List<OrderTrackingModel>  statusTracking;
  List<OrderDetailModel> orderDetails;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.buyerId,
    required this.oderDate,
    required this.status,
    required this.statusTracking,
    required this.orderDetails,
    this.deliveryTag
  });

  factory OrderModel.fromJson(dynamic json) {
    List<OrderTrackingModel>  statusTracking =[];
    List<OrderDetailModel> orderDetails = [];
    json['statusTracking']?.forEach((e)=>{
      statusTracking.add(OrderTrackingModel.fromJson(e))
    });
    json['orderDetails']?.forEach((e)=>{
      orderDetails.add(OrderDetailModel.fromJson(e))
    });
    return OrderModel(
        id:  int.parse(json['id']),
        orderNumber:  json['orderNumber'],
        buyerId:  int.parse(json['buyerId']),
        oderDate: json['oderDate']!=null? DateTime.parse(json['oderDate']):null,
        status:  json['status'],
        deliveryTag:  json['deliveryTag'],
        statusTracking: statusTracking,
        orderDetails: orderDetails
    );
  }
}