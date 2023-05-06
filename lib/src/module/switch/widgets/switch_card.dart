import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmdee/src/module/home/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../../../utils/constants.dart';
import '../../login/widgets/label_text.dart';
import '../switch_child_model.dart';
import 'label_text_switch.dart';

class SwitchCard extends StatefulWidget {
  final Function(SwitchChildModel) onPressDelete;
  final Function(SwitchChildModel) onStartTimeChange;
  final Function(SwitchChildModel) onEndTimeChange;
  final SwitchChildModel model;
  SwitchCard(
      {Key? key,
      required this.onPressDelete,
      required this.onStartTimeChange,
      required this.onEndTimeChange,
      required this.model})
      : super(key: key) {}
  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async{
                    DateTime dt = DateTime.parse('2020-01-02 ${widget.model.startTime}.000');
                    final result = await TimePicker.show<DateTime?>(
                      context: context,
                      sheet:TimePickerSheet(
                        initialDateTime: dt,
                        sheetTitle: 'เลือกเวลาเปิด',
                        hourTitle: 'ชั่วโมง',
                        minuteTitle: 'นาที',
                        saveButtonText: 'เลือก',
                        minuteInterval: 1,
                        sheetCloseIconColor: Colors.black,
                        saveButtonColor: Colors.blue,
                        hourTitleStyle:  TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                        minuteTitleStyle: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                        wheelNumberSelectedStyle: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                    );
                    if(result!=null){
                      setState(() {
                        widget.model.startTime = '${result?.hour.toString().padLeft(2, '0')}:${result?.minute.toString().padLeft(2, '0')}:00';
                      });
                    }
                    print('${result?.hour}:${result?.minute}');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                          height: 18,
                          width: 18,
                          color: Colors.green,
                        ),
                        LabelTextSwitch(text: 'เวลาเปิด'),
                        LabelTextSwitch(text: widget.model.startTime),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime dt = DateTime.parse('2020-01-02 ${widget.model.startTime}.000');

                    final result = await TimePicker.show<DateTime?>(
                      context: context,
                      sheet:TimePickerSheet(
                        initialDateTime: dt,
                        sheetTitle: 'เลือกเวลาเปิด',
                        hourTitle: 'ชั่วโมง',
                        minuteTitle: 'นาที',
                        saveButtonText: 'เลือก',
                        minuteInterval: 1,
                        sheetCloseIconColor: Colors.black,
                        saveButtonColor: Colors.blue,

                        hourTitleStyle:  TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                        minuteTitleStyle: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                        wheelNumberSelectedStyle: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                    );
                    if(result!=null){
                      setState(() {
                        widget.model.endTime = '${result?.hour.toString().padLeft(2, '0')}:${result?.minute.toString().padLeft(2, '0')}:00';
                      });
                    }
                    },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                          height: 18,
                          width: 18,
                          color: Colors.orange,
                        ),
                        LabelTextSwitch(text: 'เวลาปิด'),
                        LabelTextSwitch(text: widget.model.endTime),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    widget.onPressDelete(widget.model);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: 18,
                    width: 18,
                    alignment: Alignment.topRight,

                  ),
                ),
                SizedBox(width: 15,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ClientStyle {
  static final headerClientStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontSize: 18,
        color: TEXT_COLOR,
        overflow: TextOverflow.clip,
        decoration: TextDecoration.none),
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );
  static final bodyClientStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontSize: 14,
        color: BODY_TEXT_COLOR,
        overflow: TextOverflow.clip,
        decoration: TextDecoration.none),
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
}
