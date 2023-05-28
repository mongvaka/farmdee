import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:farmdee/src/module/shop/models/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/style.dart';
import '../../../utils/constants.dart';

class ShopCard extends StatefulWidget {
  final Function(ShopModel) onPress;
  final Function(ShopModel) onPressSwitch;
  final ShopModel model;
  bool statusSwitch = false;
  ShopCard({Key? key, required this.onPress, required this.onPressSwitch,  required this.model}) : super(key: key){
  }

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        setState(() {
          widget.onPress(widget.model);
        });

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color:Colors.white,
            ),

            borderRadius:
            BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 18),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/bank.svg',
                    height: 16,
                    width:16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    constraints: new BoxConstraints(
                      minHeight: 15.0,
                      maxHeight: 60.0,
                    ),
                    width: MediaQuery.of(context).size.width/1.39,
                    child: AutoSizeText(
                      maxLines:2,
                      minFontSize: 10,
                      widget.model.name,
                      style: ClientStyle.headerClientStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 27,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/coins.svg',
                    height: 14,
                    width:14,
                  ),

                  SizedBox(
                    width: 5,
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
