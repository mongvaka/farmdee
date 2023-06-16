import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';
import '../../utils/constants.dart';

class DetailText extends StatelessWidget {
  final  String text;
   Color color;
   double size;
   DetailText({Key? key, required this.text,this.color = BODY_TEXT_COLOR,this.size = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      minFontSize: 10,
      text,
      style: ClientStyle.customTextStyle(color,size,FontWeight.w300),
    );
    return Text(text,
      style: TextStyle(
          color:  color, fontSize: size, fontWeight: FontWeight.w400,decoration: TextDecoration.none,overflow: TextOverflow.clip),
    );
  }
}
