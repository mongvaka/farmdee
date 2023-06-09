import 'package:cart_stepper/cart_stepper.dart';
import 'package:farmdee/src/module/bucket/model/bucket_model.dart';
import 'package:farmdee/src/widgets/text/caption_text.dart';
import 'package:farmdee/src/widgets/text/detail_text.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../products/models/product_option.dart';

class BucketCard extends StatefulWidget {
  final BucketModel model;
  final Function(BucketModel) onIncreaseAmount;
  final Function(BucketModel) onOptionChange;
  final Function(BucketModel) onSwitchActive;
  ProductOptionModel? option;
  double price = 0;
  BucketCard({Key? key, required this.model,
    required this.onIncreaseAmount,
    required this.onOptionChange,
    required this.onSwitchActive
  }) : super(key: key){
    option = model.product.options.firstWhere((e) => e.id==model.optionId);
    price = model.value* option!.price;
  }
  bool? isChecked = false;
  int amount =1;
  @override
  State<BucketCard> createState() => _BucketCardState();
}

class _BucketCardState extends State<BucketCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          color: Colors.white,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 80,
                child: Material(
                  child: Checkbox(
                    activeColor: Colors.blue,
                    value: widget.isChecked,
                    onChanged: (val){
                      setState(() {
                        widget.isChecked = val;
                      });

                    },

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 80,
                height: 80,
                child:Image.asset(
                  'assets/images/1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.9,
                            child: TitleText(text: widget.model.product.name,color: Colors.black,)),

                      ],
                    ),
                    Row(
                      children: [
                        Material(
                            color: Colors.transparent,
                            child: Chip(
                                label: CaptionText(
                                  text: widget.option!.name,
                                ))),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                CaptionText(text: '${widget.price} บาท'),
                              ],
                            ),
                            Row(
                              children: [
                                Material(
                                  child: CartStepperInt(
                                    style: CartStepperStyle(
                                      foregroundColor: Colors.black87,
                                      activeForegroundColor: Colors.black87,
                                      activeBackgroundColor: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      elevation: 0,
                                      buttonAspectRatio: 1.5,
                                    ),
                                    size:18,
                                    numberSize: 4,
                                    value: widget.model.value,
                                    didChangeCount: (v){
                                      setState(() {
                                        widget.model.value = v;
                                        widget.price = widget.model.value*widget.option!.price;
                                      });
                                    },
                                  ),
                                )

                              ],
                            ),
                          ],
                        )
                        // CaptionText(text: 'ThisOption'),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top:8,
            right:12,
            child: GestureDetector(
              onTap: (){
                print('onCancel');
                print('onCancel');
              },
              child: SvgPicture.asset(
                'assets/icons/close.svg',
                color: Colors.red,
                width: 15,
                height: 15,
              ),
            )
        ),
      ],
    );
  }
}
