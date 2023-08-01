import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/main/main_page.dart';
import 'package:farmdee/src/module/welcome/welcome_page.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'src/module/switch/switch_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      title: 'GNav',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.white
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home:const WelcomePage()));

}
