import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/module/shop/widgets/shop_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/shop_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentSegment = 0;
  ShopSearch search = ShopSearch();
  ShopService service = ShopService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<ShopModel> _posts = [];
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
      print(res);
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
    return AppScaffoldItem(
        title: 'สั่งซื้อสินค้า', canBack: false,
        child: Column(
          children: [
            Expanded(
              child: _posts!.isNotEmpty
                  ? ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _posts?.length,
                  controller: _controller,
                  itemBuilder: (_, index) {
                    ShopModel model = _posts![index];
                    return ShopCard(
                        onPress: (ShopModel model) {

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           SwitchPage(homeModel: model)),
                          // ).then((value){
                          //   _firstLoad();
                          //   _controller = ScrollController()..addListener(_loadMore);
                          // });
                          // final router = context.router;
                          // router.push(ClientDetailRoute(clientId: clientId));
                        },
                        onPressSwitch: (ShopModel model) {
                          // service.switchStatus(model);
                        },
                        model:model

                    );
                  })
                  :!_posts.isEmpty? const Center(child: CupertinoActivityIndicator()):Center(child: LabelText(text: 'ไม่มีข้อมูล',),),
            ),
            if (_isLoadMoreRunning == true)
              const Padding(
                padding: EdgeInsets.only(top: 1, bottom: 1),
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
          ],
        ),
    );
  }
}
