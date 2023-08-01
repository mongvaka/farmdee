import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:farmdee/src/module/home/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/style.dart';
import '../../../utils/constants.dart';

class HomeCard extends StatefulWidget {
  bool pending = false;
  final Function(HomeModel) onPress;
  final Function(HomeModel) onPressSwitch;
  final HomeModel model;
  bool statusSwitch = false;
  HomeCard({Key? key, required this.onPress, required this.onPressSwitch,  required this.model}) : super(key: key){
    statusSwitch = model.status==1;
  }

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  HomeService service = HomeService();
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
                    'assets/icons/chip.svg',
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
                      style: ClientStyle.customTextStyle(TEXT_COLOR,18,FontWeight.w500),
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
                    'assets/icons/switch.svg',
                    height: 14,
                    width:14,
                  ),

                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.pending?'สถานะ กำลังสั่งงาน': widget.model.status==1? 'สถานะ เปิด':'สถานะ ปิด',
                    style: ClientStyle.customTextStyle(TEXT_COLOR,14,FontWeight.w300),
                    // style: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 16,
                    //     decoration: TextDecoration.none),
                  ),
                  Spacer(),

                  FlutterSwitch(
                    disabled: widget.pending,
                    showOnOff: true,
                    activeText: 'เปิด',
                    inactiveText: 'ปิด',
                    activeTextColor: Colors.white,
                    activeColor: Colors.green.shade500,
                    inactiveTextColor: Colors.white,
                    value: widget.statusSwitch,
                    onToggle: (val) {
                      setState(() {
                        widget.pending = true;
                        widget.statusSwitch = val;
                        widget.model.status = val?1:0;
                      });
                      service.switchStatus(widget.model).then((value) {
                        if(value){
                          setState(() {
                            widget.pending = false;

                          });
                        }
                      });

                    },
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
