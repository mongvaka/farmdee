import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

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
  static final chatStyle = GoogleFonts.inter(
    textStyle: const TextStyle(
        fontSize: 16,
        color: TEXT_COLOR,
        overflow: TextOverflow.clip,
        decoration: TextDecoration.none),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,);

}
