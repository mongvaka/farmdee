import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';
import '../../utils/constants.dart';

class CaptionText extends StatelessWidget {
  final String text;
  Color textColor;
  double fontSize;
  FontWeight fontWeight;
  CaptionText(
      {Key? key,
      required this.text,
      this.textColor = BODY_TEXT_COLOR,
      this.fontSize = 12,
      this.fontWeight = FontWeight.w300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      maxLines: 2,
      minFontSize: 10,
      text,
      style: ClientStyle.customTextStyle(textColor, fontSize, fontWeight),
    );

  }
}
