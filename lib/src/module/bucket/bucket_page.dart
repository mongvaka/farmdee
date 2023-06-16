import 'package:farmdee/src/module/bucket/bucket_service.dart';
import 'package:farmdee/src/module/bucket/model/bucket_model.dart';
import 'package:farmdee/src/module/bucket/widget/bucket_card.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:farmdee/src/module/products/models/product_option.dart';
import 'package:farmdee/src/module/verify_mobile/verify_mobile.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/text/detail_text.dart';
import '../home/home_search.dart';
import '../login/widgets/label_text.dart';
import '../products/widgets/product_option_dialog.dart';

class BucketPage extends StatefulWidget {
  double price =0;
  int value = 0;
   BucketPage({Key? key}) : super(key: key);

  @override
  State<BucketPage> createState() => _BucketPageState();
}

class _BucketPageState extends State<BucketPage> {
  int currentSegment = 0;
  HomeSearch search = HomeSearch();
  BucketService service = BucketService();
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List<BucketModel> _posts = [];
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
        print(res);
        search.fromResponse(res);
        final fetchedPosts = res.content;
        if (fetchedPosts!.isNotEmpty) {
          setState(() {
            _posts!.addAll(fetchedPosts);

          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
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
          widget.price = 0;
          widget.value = 0;
          _posts.forEach((element) {

            if(element.activate){
              ProductOptionModel option = element.product.options.firstWhere((op) => op.id == element.optionId);
              widget.price += option.price*element.value;
              widget.value += element.value;
            }


          });

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
      tailing: SizedBox(),
      title: 'ตะกร้าสินค้า',
      canBack: true,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _posts!.isNotEmpty
                ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _posts?.length,
                controller: _controller,
                itemBuilder: (_, index) {
                  BucketModel model = _posts![index];
                  return BucketCard(amount: model.value,isChecked: model.activate,
                    onIncreaseAmount: (m){
                      widget.price = 0;
                      widget.value = 0;
                      setState(() {
                        _posts.forEach((element) {
                          if(element.productId == m.productId && element.id == m.id){
                            element.value = m.value;
                          }
                          if(element.activate){
                            ProductOptionModel option = m.product.options.firstWhere((el) => el.id == element.optionId);
                            widget.price += option.price*element.value;
                            widget.value += element.value;
                          }


                        });
                      });
                    },
                    onOptionChange: (m){
                      showModal(context,'แก้ไขตัวเลือกสินค้า',m,false);
                    },
                    onSwitchActive: (m){
                      print('id ${m.id}');

                    widget.price = 0;
                    widget.value = 0;
                      setState(() {
                        _posts.forEach((element) {
                          if(element.productId == m.productId&& element.id == m.id){
                            element.activate = m.activate;
                          }
                          if(element.activate){
                            ProductOptionModel option = m.product.options.firstWhere((el) => el.id == element.optionId);
                            widget.price += option.price*element.value;
                            widget.value += element.value;
                          }

                        });
                      });
                    },
                    model: model,
                    onRemove: (m) async {
                     bool deleted = await service.removeProductInBucket(m.id);
                     if(deleted){
                       setState(() {
                         _posts.remove(m);
                       });
                     }
                    },
                  );
                })
                :!_posts.isEmpty? const Center(child: CupertinoActivityIndicator()):Center(child: LabelText(text: 'ไม่มีข้อมูล',),),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 7,bottom: 7),

                        color: Colors.white,
                        child: Row(children: [
                          Spacer(),
                          Column(
                            children: [
                              CaptionText(text: 'รวม ${widget.price} บาท',),
                              CaptionText(text: '( ${widget.value} ชิ้น)',),
                            ],
                          ),
                          Spacer(),
                        ],),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () async {
                          List<Map<String,dynamic>> orders = [];
                          _posts.forEach((el) {
                            ProductOptionModel option = el.product.options.firstWhere((op) => op.id == el.optionId);
                            if(el.activate){
                              orders.add({
                                "productId":el.productId,
                                "value":el.value,
                                "optionId":el.optionId,
                                "price":option.price,
                                "bucketId":el.id
                              });
                            }

                          });
                          bool mobileIsExist  = await service.verifyMobile();
                          if(!mobileIsExist){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VerifyMobile()),
                            );
                          }else{
                            // bool created = await service.createOrder(orders);
                          }

                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Row(children: [
                            Spacer(),

                            TitleText(text: 'สั่งซื้อ',color: Colors.white,),
                            Spacer(),
                          ],),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void showModal(context, String text,BucketModel m,bool gotoBucket) {
    ProductOptionModel option = m.product.options.firstWhere((el) => el.id == m.optionId);
    ProductDetailModel model = new ProductDetailModel(
        id: m.productId,
        name: m.product.name,
        code: m.product.code,
        detail: m.product.detail,
        comments: [],
        images: m.product.images,
        rating: m.product.rating,
        sold: m.product.sold,
        options: m.product.options
    );
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return ProductOptionDialog(model: model, title: text,returnValue: true,option: option,amount: m.value,bucketId: m.id,);
        }).whenComplete(() {
          print('whenComplete');
    }).then(( value) {
      print(value);
      if(value!=null){
        widget.price = 0;
        widget.value = 0;
        setState(() {
          _posts.forEach((element) {
            if(element.productId == value["productId"]&&element.id == value["bucketId"]){
              element.optionId = value["optionId"];
              element.value = value["value"];

            }
            if(element.activate){
              ProductOptionModel option = m.product.options.firstWhere((el) => el.id == m.optionId);
              widget.price += option.price*element.value;
              widget.value += element.value;
            }
          });
        });
      }


    });
  }
}
