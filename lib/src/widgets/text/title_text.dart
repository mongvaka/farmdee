import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';
import '../../utils/constants.dart';

class TitleText extends StatelessWidget {
  final  String text;
  final Color color;
  double fontSize;
   TitleText({Key? key, required this.text,this.color = TEXT_COLOR,this.fontSize = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      maxLines: 2,
      minFontSize: 10,
      text,
      style: ClientStyle.customTextStyle(color,fontSize,FontWeight.w500),
    );
    return Text(text,
      style: const TextStyle(
          color: TEXT_COLOR, fontSize: 19, fontWeight: FontWeight.w600,decoration: TextDecoration.none),
    );
  }
}
