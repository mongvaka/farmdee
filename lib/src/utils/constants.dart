// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';

const PRIMARY_COLOR = Color.fromRGBO(240, 24, 12, 1);
const TEXT_COLOR = Color.fromRGBO(28, 28, 30, 1);
const BORDER_COLOR = Color.fromRGBO(229, 229, 234, 1);
const DISABLED_BG_COLOR = Color.fromRGBO(249, 249, 249, 1);
const DISABLED_TEXT_COLOR = Color.fromRGBO(60, 60, 67, 0.3);
const SECURE_ENCRYPT_KEY = 'etYwoNfLAnAt';
const BACKGROUND_COLOR = Color.fromRGBO(243, 244, 246, 1.0);
const STAR_COLOR = Color.fromRGBO(255, 169, 64, 1);
const BOOKMARK_ADDED_COLOR = Color.fromRGBO(16, 162, 14, 1);
const BOOKMARK_ADDED_BACKGROUND_COLOR = Color.fromRGBO(221, 255, 244, 1);
const BOOKMARK_COLOR = Color.fromRGBO(240, 24, 12, 1);
const BOOKMARK_BACKGROUND_COLOR = Color.fromRGBO(255, 241, 240, 1);
const SEARCH_BACKGROUND_COLOR = Color.fromRGBO(118, 118, 128, 0.1);
const SEARCH_BACKGROUND_BORDER_COLOR = Color.fromRGBO(229, 229, 234, 1);
const BODY_TEXT_COLOR = Color.fromRGBO(60, 60, 67, 0.6);

const COMPLEX_CHART_INNER_COLOR = [
  Color.fromRGBO(  217, 33, 15, 1),
  Color.fromRGBO( 238, 67, 39 , 1),
  Color.fromRGBO(  248, 109, 73, 1),
  Color.fromRGBO(  254, 152, 116, 1),
  Color.fromRGBO( 176, 177, 181 , 1),
  Color.fromRGBO( 141, 142, 145 , 1),
  Color.fromRGBO(  108, 109, 112, 1),
  Color.fromRGBO( 77, 78, 80 , 1),
];
const COMPLEX_CHART_OUTER_COLOR = [
  Color.fromRGBO(  229, 104, 92, 1),
  Color.fromRGBO( 243, 127, 108, 1 ),
  Color.fromRGBO(250, 156, 132, 1 ),
  Color.fromRGBO( 254, 185, 161, 1),
  Color.fromRGBO( 201, 202, 205, 1 ),
  Color.fromRGBO(  178, 178, 180, 1),
  Color.fromRGBO( 155, 156, 158, 1 ),
  Color.fromRGBO( 134, 135, 136, 1 ),
];
 const API_URL = 'http://141.98.17.93/api/v1';
 //const API_URL = 'http://192.168.1.42:3033/api/v1';
const REQ_HEADER = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

class AppHiveBoxKey {
  final String currentUser;

  const AppHiveBoxKey({
    required this.currentUser,
  });
}

const AppHiveBoxKey HIVE_BOX_KEY = AppHiveBoxKey(currentUser: 'current_user');
