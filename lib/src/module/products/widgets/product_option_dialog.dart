import 'package:cart_stepper/cart_stepper.dart';
import 'package:farmdee/src/module/products/product_detail_service.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/text/caption_text.dart';
import '../../../widgets/text/title_text.dart';
import '../models/product_detail_model.dart';
import '../models/product_option.dart';

class ProductOptionDialog extends StatefulWidget {
  final ProductDetailModel model;
  int amount = 1;
  ProductOptionModel option =  ProductOptionModel(id: 0,name: '',price: 1);
  double price = 0;
  final String title;
  ProductOptionDialog({Key? key, required this.model, required this.title}) : super(key: key){
    price = model.options[0].price;
    option = model.options[0];
  }

  @override
  State<ProductOptionDialog> createState() => _ProductOptionDialogState();
}

class _ProductOptionDialogState extends State<ProductOptionDialog> {
  ProductDetailService service = ProductDetailService();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TitleText(text: 'ระบุตัวเลือกสินค้า'),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 100,
                      width: 100,
                      child: Image.network(
                        '$API_URL/images/product/${widget.model?.images[0]?.url}',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 5,),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            TitleText(text: 'ราคา ${widget.price} บาท',color: Colors.black,),
                          ],
                        )
                      ],),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Wrap(
                  children: getOption(widget.model?.options??[]),
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(text: 'จำนวน'),
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
                          size:22,
                          value:widget.amount,
                          didChangeCount: (v){
                            setState(() {
                              widget.amount = v;
                              widget.price = widget.amount*widget.option.price;
                            });
                          },
                        ),
                      )
                    ],),
                ),
                GestureDetector(
                  onTap: () async {
                    bool created = await service.addProductToOrder(widget.model.id,widget.amount,widget.option.id!);
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: TitleText(
                          text: widget.title,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ))
      ],
    );
  }
  List<Widget> getOption(List<ProductOptionModel> options) {
    List<Widget> optionWidgets = [];
    options.forEach((el) {
      optionWidgets.add(Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: (){
              setState(() {
                widget.option = el;
                widget.price = el.price*widget.amount;
              });
            },
            child: Chip(
                shape: StadiumBorder(side: BorderSide(color: el.id==widget.option?.id?Colors.blue:Colors.white)),
                backgroundColor: Colors.white,
                label: CaptionText(
                  text: el.name,
                )),
          )));
    });
    return optionWidgets;
  }
}
