import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';
import '../../utils/constants.dart';

class CaptionText extends StatelessWidget {
  final  String text;
  const CaptionText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      maxLines: 2,
      minFontSize: 10,
      text,
      style: ClientStyle.captionProductStyle,
    );
    return Text(text,
      style: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
          overflow: TextOverflow.clip),
    );
  }
}
