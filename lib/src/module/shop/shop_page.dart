import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:farmdee/src/module/products/product_create_page.dart';
import 'package:farmdee/src/module/products/product_detail.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/module/shop/widgets/shop_card.dart';
import 'package:farmdee/src/widgets/loadding_dialog.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../bucket/bucket_page.dart';
import '../products/widgets/product_option_dialog.dart';
import '../verify_mobile/get_otp_page.dart';
import 'models/category_model.dart';
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
  List<CategoryModel> _category = [];
  int categoryId = 1;
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
        if (res.content != null) {
          _posts = res!.content!;
        }
      });
    } catch (err, t) {
      if (kDebugMode) {
        print(t);
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _getCountBucket() {
    service.countBucket().then((value) {
      setState(() {
        countBucket = value;
      });
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
    _getCountBucket();
    _getCategoryData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  int? countBucket = 0;
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: Container(
        width: 100,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductCreatePage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 18, right: 10),
                  width: 45,
                  color: const Color.fromRGBO(245, 246, 248, 0.8),
                  child: SvgPicture.asset(
                    'assets/icons/plus.svg',

                  ),
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BucketPage()),
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
                        child: countBucket == 0
                            ? SizedBox()
                            : new Container(
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
                                  '$countBucket',
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
          ],
        ),
      ),
      title: 'สั่งซื้อสินค้า',
      canBack: false,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._getCategoryCard(),
                ],
              ),
            ),
          ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                        id: model.id,
                                      )),
                            );
                          },
                          onPressBuy: (ShopModel model) {
                            showModal(context, 'เพิ่มลงตะกร้า', model, false);
                          },
                          model: model);
                    })
                : _isFirstLoadRunning
                    ? const Center(child: AppLoadingDialog())
                    : Center(
                        child: LabelText(
                          text: 'ไม่มีข้อมูล',
                        ),
                      ),
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

  void showModal(context, String text, ShopModel model, bool gotoBucket) {
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
      categoryId: 0
    );
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return ProductOptionDialog(
              model: productDetailModel,
              title: text,
              returnValue: false,
              option: model.options[0]);
        }).whenComplete(() {}).then((value) {
      if (value) {
        _getCountBucket();
      }
    });
  }

  List<Widget> _getCategoryCard() {
    return _category.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            categoryId = e.id;
          });
          search.categoryId = categoryId;
          _firstLoad();
          _controller = ScrollController()..addListener(_loadMore);
        },
        child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: e.id == categoryId ? Colors.blue : Colors.grey,
                    width: e.id == categoryId ? 2 : 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: TitleText(
              text: e.name,
              fontSize: 13,
            )),
      );
    }).toList();
  }

  void _getCategoryData() {
    service.category().then((value) {
      setState(() {
        _category = value;
      });
    });
  }
}
