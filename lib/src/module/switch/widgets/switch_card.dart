import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../login/widgets/label_text.dart';
import '../switch_model.dart';

class SwitchCard extends StatefulWidget {
  final Function(SwitchModel) onPressDelete;
  final Function(SwitchModel) onStartTimeChange;
  final Function(SwitchModel) onEndTimeChange;
  final SwitchModel model;
  SwitchCard({Key? key, required this.onPressDelete, required this.onStartTimeChange, required this.onEndTimeChange,required this.model}) : super(key: key)
  {}
  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color:Colors.white,
          ),

          borderRadius:
          BorderRadius.all(Radius.circular(10))),

      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/coins.svg',
                  height: 14,
                  width:14,
                ),
                LabelText(text:'เวลาเปิด'),
                LabelText(text:'เวลาเปิด'),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/coins.svg',
                  height: 14,
                  width:14,
                ),
              ],
            )
          ],
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