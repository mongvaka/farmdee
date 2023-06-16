import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:farmdee/src/module/products/product_detail.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/module/shop/widgets/shop_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../bucket/bucket_page.dart';
import '../products/widgets/product_option_dialog.dart';
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
      tailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BucketPage()),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 5, right: 5),
            width: 45,
            color: const Color.fromRGBO(245, 246, 248, 0.8),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '1',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/shopping_cart.svg',
                ),
              ],
            ),
          )),
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
                          print('model');
                          print(model.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(id: model.id,)),
                          );
                        },
                        onPressBuy: (ShopModel model) {
                          showModal(context,'เพิ่มลงตะกร้า',model,false);
                          // print('buypress');
                          // service.addProductToOrder(model.id,mo);
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
  void showModal(context, String text,ShopModel model,bool gotoBucket) {
    ProductDetailModel productDetailModel = new ProductDetailModel(
        id: model.id,
        name: model.name,
        code: model.code,
        detail: model.detail,
        comments: [],
        images: model.images,
        rating: model.rating,
        sold: 0,
        options: model.options,
    );
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return ProductOptionDialog(model: productDetailModel, title: text,returnValue: false,option: model.options[0]);
        }).whenComplete(() {
      // if(gotoBucket){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => BucketPage()),
      //   );
      // }
    });
  }
}
