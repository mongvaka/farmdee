import 'package:farmdee/src/module/order/model/order_model.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../../../widgets/text/title_text.dart';

class OrderCard extends StatelessWidget {
  int value = 0;
  double price = 0;
  final OrderModel model;
   OrderCard({Key? key, required this.model}) : super(key: key){
     for (var el in model.orderDetails) {
       value+=el.value;
       price+=el.price;
     }
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: TitleText(
                    text: 'หมายเลขคำสั่งซื้อ : ',
                    color: Colors.black,
                    fontSize: 16,
                  )),
              Expanded(
                  flex: 7,
                  child: TitleText(
                    text: model.orderNumber,
                    color: Colors.black,
                    fontSize: 16,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Spacer(),
                      TitleText(
                        text: 'หมายเลขจัดส่งวัสดุ : ',
                        color: BODY_TEXT_COLOR,
                        fontSize: 12,
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  )),
              Expanded(
                  flex: 7,
                  child: TitleText(
                    text: model.deliveryTag??'',
                    color: BODY_TEXT_COLOR,
                    fontSize: 12,
                  )),
            ],
          ),
          Row(
            children: [

              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/box.svg',
                        width: 18,
                        height: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DetailText(
                        text: '${value} ชิ้น',
                        color: TEXT_COLOR,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/coins.svg',
                        width: 18,
                        height: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DetailText(
                        text: '${price*value} บาท',
                        color: TEXT_COLOR,
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CaptionText(
                text: 'รายการสินค้า',
                textColor: TEXT_COLOR,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ...getProducts(model)

              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2, child: Center(child: CaptionText(text: 'เวลา'))),
              Expanded(
                  flex: 3,
                  child: Center(
                      child: CaptionText(
                    text: 'สถานะ',
                    textColor: TEXT_COLOR,
                  ))),
            ],
          ),
          ...getStatusTracking(model),
        ],
      ),
    );
  }

 List<Widget> getProducts(OrderModel model) {
     return model.orderDetails.map((e){
       return Container(
         width: 90,
         padding: EdgeInsets.all(4),
         decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.black26),
             borderRadius: BorderRadius.all(
               Radius.circular(10),
             )),
         child: Column(
           children: [
             Image.network(
               '$API_URL/images/product/${e.product.images[0]}',
               width: 50,
               height: 50,
               fit: BoxFit.cover,
             ),
             Row(
               children: [
                 Container(
                     width: 80,
                     child: CaptionText(
                         textColor: TEXT_COLOR,
                         text: '${e.product.name}')),
               ],
             ),
             Row(
               children: [
                 Container(
                   padding: EdgeInsets.only(top: 1),
                   child: SvgPicture.asset(
                     'assets/icons/box.svg',
                     width: 13,
                     height: 13,
                     color: Colors.grey,
                   ),
                 ),
                 SizedBox(
                   width: 3,
                 ),
                 CaptionText(
                   text: '${e.value} ชิ้น',
                   fontSize: 11,
                   textColor: TEXT_COLOR,
                 ),
               ],
             ),
             Row(
               children: [
                 Container(
                   padding: EdgeInsets.only(top: 1),
                   child: SvgPicture.asset(
                     'assets/icons/coins.svg',
                     width: 13,
                     height: 13,
                     color: Colors.grey,
                   ),
                 ),
                 SizedBox(
                   width: 3,
                 ),
                 CaptionText(
                     text: '${e.price} บ.',
                     fontSize: 11,
                     textColor: TEXT_COLOR),
               ],
             ),
           ],
         ),
       );
     }).toList();
 }

 List<Widget> getStatusTracking(OrderModel model) {
     return model.statusTracking.map((e){
       return Row(
         children: [
           Expanded(
               flex: 2, child: CaptionText(text: '${e.statusDate.day}-${e.statusDate.month}-${e.statusDate.year} เวลา ${e.statusDate.hour}:${e.statusDate.minute}')),
           Expanded(
               flex: 3,
               child:
               CaptionText(text: e.reason, textColor: TEXT_COLOR)),
         ],
       );
     }).toList();
 }
}
