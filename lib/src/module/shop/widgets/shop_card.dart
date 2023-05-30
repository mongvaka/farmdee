import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:farmdee/src/module/shop/models/shop_model.dart';
import 'package:farmdee/src/widgets/scaffold/widgets/app_positive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/style.dart';
import '../../../utils/constants.dart';

class ShopCard extends StatefulWidget {
  final Function(ShopModel) onPress;
  final Function(ShopModel) onPressBuy;
  final ShopModel model;
  bool statusSwitch = false;
  ShopCard(
      {Key? key,
      required this.onPress,
      required this.onPressBuy,
      required this.model})
      : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print('pess');
          widget.onPress(widget.model);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    height: 100,
                    child: Image.network('https://picsum.photos/250?image=9')),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            minFontSize: 10,
                            widget.model.name,
                            style: ClientStyle.headerProductStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            maxLines: 2,
                            minFontSize: 10,
                            widget.model.detail,
                            style: ClientStyle.detailProductStyle,
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    RatingBar(
                                      initialRating: widget.model.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      unratedColor: Colors.white,
                                      ignoreGestures: true,
                                      itemSize: 16,
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                      ratingWidget: RatingWidget(
                                        full: Icon(
                                          Icons.star_rounded,
                                          color:STAR_COLOR,
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
                                    SizedBox(width: 3,),
                                    Text(widget.model.rating.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('ราคา 100 บาท'),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            AppPositiveButton(text: 'สั่งซื้อ',onPressed: (){
                              print('prrrrr');
                              widget.onPressBuy(widget.model);
                            },)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
