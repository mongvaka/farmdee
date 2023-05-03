import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';

class HomeCard extends StatefulWidget {
  final Function(HomeModel) onPress;
  final Function(HomeModel) onPressSwitch;
  final HomeModel model;
  bool statusSwitch = false;
  HomeCard({Key? key, required this.onPress, required this.onPressSwitch,  required this.model}) : super(key: key){
    statusSwitch = model.status==0;
  }

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
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
                  Text(
                    widget.model.status==0? 'สถานะ เปิด':'สถานะ ปิด',
                    style: ClientStyle.bodyClientStyle,
                    // style: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 16,
                    //     decoration: TextDecoration.none),
                  ),
                  Spacer(),

                  FlutterSwitch(
                    showOnOff: true,
                    activeText: 'เปิด',
                    inactiveText: 'ปิด',
                    activeTextColor: Colors.white,
                    activeColor: Colors.green.shade500,
                    inactiveTextColor: Colors.white,
                    value: widget.statusSwitch,
                    onToggle: (val) {
                      setState(() {
                        widget.statusSwitch = val;
                        widget.model.status = val?0:1;
                        widget.onPressSwitch(widget.model);
                      });
                    },
                  ),
                  // Container(
                  //     width: 30,
                  //     height: 30,
                  //     decoration: BoxDecoration(
                  //         color: model.status==1?BOOKMARK_ADDED_BACKGROUND_COLOR:BOOKMARK_BACKGROUND_COLOR,
                  //         border: Border.all(
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(5))),
                  //     child: Icon(
                  //       model.status==1?Icons.bookmark_added_outlined:Icons.bookmark_add_outlined,
                  //       color: model.status==1?BOOKMARK_ADDED_COLOR: BOOKMARK_COLOR,
                  //       size: 20,
                  //     ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class ClientStyle{
  static final headerClientStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontSize: 18,
        color: TEXT_COLOR,
        overflow: TextOverflow.clip,
        decoration: TextDecoration.none),
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,);
  static final bodyClientStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontSize: 14,
        color: BODY_TEXT_COLOR,
        overflow: TextOverflow.clip,
        decoration: TextDecoration.none),
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,);

}