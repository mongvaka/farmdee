import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/order_tab.dart';

class OrderPage extends StatefulWidget {
  final int initialIndex;
  final String status;
  const OrderPage({Key? key, required this.status, required this.initialIndex}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      title: 'รายการสั่งซื้อ',
      canBack: true,
      tailing: SizedBox(),
    child: DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 4,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Material(
              child: TabBar( // ส่วนของ tab
                      tabs: [
                        Tab(
                          iconMargin: EdgeInsets.only(bottom: 0),
                          icon:  SvgPicture.asset(
                          'assets/icons/box.svg',
                          color: Colors.grey,
                          width: 20,
                          height: 20,
                        ),child: DetailText(text: 'การจัดส่ง',)),
                        Tab(
                          iconMargin: EdgeInsets.only(bottom: 0),
                          icon:  SvgPicture.asset(
                          'assets/icons/delivery.svg',
                          color: Colors.grey,
                          width: 20,
                          height: 20,
                        ),child: DetailText(text: 'ที่สำเร็จ',)),
                        Tab(
                          iconMargin: EdgeInsets.only(bottom: 0),
                          icon:  SvgPicture.asset(
                          'assets/icons/cancel_circle.svg',
                          color: Colors.grey,
                          width: 20,
                          height: 20,
                        ), child: DetailText(text: 'การยกเลิก',),),
                        Tab(
                          iconMargin: EdgeInsets.only(bottom: 0),
                          icon:  SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: Colors.grey,
                          width: 20,
                          height: 20,
                        ),
                          child: DetailText(text: 'ให้คะแนน',)
                        ,),
                      ],
                    ),
            ),
          ),
          Expanded(

            child: Material(
              child: TabBarView( // ส่วนของเนื้อหา tab
                    children: [
                      OrderTab(status: 'BuyerConfirm',),
                      OrderTab(status: 'Completed',),
                      OrderTab(status: 'Canceled',),
                      OrderTab(status: 'Delivered',),
                    ],
                  ),
            ),
          )
        ],
      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     bottom: const TabBar( // ส่วนของ tab
      //       tabs: [
      //         Tab(icon: Icon(Icons.feed)),
      //         Tab(icon: Icon(Icons.favorite_sharp)),
      //         Tab(icon: Icon(Icons.thumb_up)),
      //         Tab(icon: Icon(Icons.announcement)),
      //       ],
      //     ),
      //     title: Text('Home'),
      //   ),
      //   body: const TabBarView( // ส่วนของเนื้อหา tab
      //     children: [
      //       Center(child: Text('Tab 1111')),
      //       Center(child: Text('Tab 2222')),
      //       Center(child: Text('Tab 3333')),
      //       Center(child: Text('Tab 4444')),
      //     ],
      //   ),
      // ),
    )
    );
  }
}
