import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/search_hardware/search_hardware_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../shared/style.dart';
import '../../../utils/constants.dart';
import '../../../widgets/scaffold/widgets/app_top_save_button.dart';

class SearchHardwareCard extends StatefulWidget {
  final Function(SearchHardwareModel) onPress;
  final Function(SearchHardwareModel) onRegister;
  final SearchHardwareModel model;
  bool statusSwitch = false;
  SearchHardwareCard({Key? key, required this.onPress, required this.onRegister,  required this.model}) : super(key: key){
  }
  @override
  State<SearchHardwareCard> createState() => _SearchHardwareCardState();
}

class _SearchHardwareCardState extends State<SearchHardwareCard> {
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
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
                    'assets/icons/clock.svg',
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
                      'อุปกรณ์ไอดี : ${widget.model.key}',
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
                    'assets/icons/user.svg',
                    height: 14,
                    width:14,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.model.ownerId==0? 'ยังไม่ลงทะเบียน': '${widget.model.owner?.email}',
                    style: ClientStyle.customTextStyle(TEXT_COLOR,16,FontWeight.w500),
                  ),
                  const Spacer(),
                  AppTopSaveButton(text: widget.model.ownerId==0?'ลงทะเบียน':'ลงทะเบียนใหม่',onPressed: (){
                    widget.onRegister!(widget.model);
                  },)

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
