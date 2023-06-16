import 'package:farmdee/src/module/order/model/order_model.dart';
import 'package:farmdee/src/module/order/order_search.dart';
import 'package:farmdee/src/module/order/order_service.dart';
import 'package:farmdee/src/module/order/widgets/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../login/widgets/label_text.dart';

class OrderTab extends StatefulWidget {
  final String status;
  const OrderTab({Key? key, required this.status}) : super(key: key);

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  int currentSegment = 0;
  OrderSearch search = OrderSearch();
  OrderService service = OrderService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<OrderModel> _posts = [];
  void _loadMore() async {
    if (search.page.last == false &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      search.page.offset += 1;

      try {
        final res = await service.list(search);
        search.fromResponse(res);
        final fetchedPosts = res.content;
        if (fetchedPosts!.isNotEmpty) {
          setState(() {
            print(fetchedPosts);

            _posts!.addAll(fetchedPosts);
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await service.list(search);
      print(res.content?.length);
      search.fromResponse(res);
      setState(() {
        if(res.content !=null){
          _posts = res!.content!;
        }
      });
    } catch (err,t) {
      if (kDebugMode) {
        print(t);
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      children: [
        ...getOrderCard()
      ],
    )
    );
  }

  List<Widget> getOrderCard() {
   return _posts.map((e){
      return OrderCard(model:e);
    }).toList();
  }
}
