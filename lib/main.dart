import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/main/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/module/switch/switch_page.dart';

void main() {
  runApp(MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      title: 'GNav',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: const LoginPage()));
}
