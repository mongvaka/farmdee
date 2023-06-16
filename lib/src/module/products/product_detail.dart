import 'package:cart_stepper/cart_stepper.dart';
import 'package:chip_list/chip_list.dart';
import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/products/models/comment_model.dart';
import 'package:farmdee/src/module/products/models/product_detail_model.dart';
import 'package:farmdee/src/module/products/models/product_option.dart';
import 'package:farmdee/src/module/products/product_detail_service.dart';
import 'package:farmdee/src/module/products/widgets/comment_card.dart';
import 'package:farmdee/src/module/products/widgets/product_option_dialog.dart';
import 'package:farmdee/src/module/shop/models/image.dart';
import 'package:farmdee/src/module/shop/shop_search.dart';
import 'package:farmdee/src/module/shop/shop_service.dart';
import 'package:farmdee/src/module/shop/widgets/shop_card.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import '../../widgets/scaffold/widgets/app_positive_button.dart';
import '../../widgets/text/caption_text.dart';
import '../../widgets/text/title_text.dart';
import '../bucket/bucket_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  const ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSegment = 0;
  ProductDetailService service = ProductDetailService();
  bool _isFirstLoadRunning = true;
  ProductDetailModel? model;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res = await service.getProductDetail(widget.id);
      print(res);
      setState(() {
        if (res != null) {
          model = res;
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

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      tailing: SizedBox(),
      title: 'ข้อมูลสินค้า',
      canBack: true,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  model != null
                      ? ImageSlideshow(
                          width: double.infinity,
                          height: 250,
                          initialPage: 0,
                          indicatorColor: Colors.blue,
                          indicatorBackgroundColor: Colors.grey,
                          children: getImages(model?.images ?? []),
                          autoPlayInterval: 3000,
                          isLoop: true,
                        )
                      : Center(child: CupertinoActivityIndicator()),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            TitleText(
                              text: model == null ? '' : model!.name,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            RatingBar(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              unratedColor: Colors.white,
                              ignoreGestures: true,
                              itemSize: 16,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star_rounded,
                                  color: STAR_COLOR,
                                ),
                                half: Icon(Icons.star_half_rounded,
                                    color: STAR_COLOR),
                                empty: Icon(Icons.star_outline_rounded,
                                    color: STAR_COLOR),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CaptionText(text: '${model?.rating ?? '0'}')
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            CaptionText(
                              text: 'ขายแล้ว',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CaptionText(
                              text: '${model?.sold} ชิ้น',
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            TitleText(
                              text: 'ตัวเลือกสินค้า',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CaptionText(
                              text: '( ${model?.options.length} รายการ )',
                            ),
                          ],
                        ),
                        Row(
                          children: getOption(model?.options ?? []),
                          // [
                          //   Chip(label: CaptionText(text: '${model?.options.length}',) )
                          // ],
                        ),
                        Row(
                          children: [
                            TitleText(text: 'รายละเอียด'),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DetailText(
                            text: model?.detail ?? '',
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            TitleText(text: 'ความคิดเห็น'),
                            SizedBox(
                              width: 5,
                            ),
                            CaptionText(
                                text: '( ${model?.comments?.length} รายการ)')
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 400,
                          child: Column(
                            children: getComment(model?.comments ?? []),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showModal(context, 'เพิ่มลงรถเข็น',model!,false,false);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Spacer(),
                            SvgPicture.asset(
                              'assets/icons/shopping_cart.svg',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TitleText(
                              text: 'เพิ่มลงรถเข็น',
                              color: Colors.black,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showModal(context, 'สั่งซื่อ',model!,true,true);

                      },
                      child: Container(
                        color: Colors.blue,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Spacer(),
                            SvgPicture.asset(
                              'assets/icons/shopping_bag.svg',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TitleText(
                              text: 'สั่งซื้อ',
                              color: Colors.white,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getImages(List<ImageModel> images) {
    print('images.length');

    print(images.length);
    List<Widget> imageWidgets = [];
    images.forEach((element) {
      imageWidgets.add(Image.network(
        '$API_URL/images/product/${element.url}',
        fit: BoxFit.cover,
      ));
    });
    return imageWidgets;
  }

  List<Widget> getComment(List<CommentModel> comments) {
    List<Widget> commentWidgets = [];
    comments.forEach((element) {
      commentWidgets.add(CommentCard(
          name: '${element.commentor.firstName} ${element.commentor.lastName}',
          comment: element.comment,
          rating: element.rating ?? 0.0));
    });
    return commentWidgets;
  }

  List<Widget> getOption(List<ProductOptionModel> options) {
    List<Widget> optionWidgets = [];
    options.forEach((element) {
      optionWidgets.add(Material(
          color: Colors.transparent,
          child: Chip(
              label: CaptionText(
            text: element.name,
          ))));
    });
    return optionWidgets;
  }

  void showModal(context, String text,ProductDetailModel model,bool gotoBucket,bool activate) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return ProductOptionDialog(model: model, title: text,returnValue: false,option: model.options[0],activate: activate,);
        }).whenComplete(() {

    }).then((value){
      if(gotoBucket&&value!=null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BucketPage()),
        );
      }

    });
  }
}
