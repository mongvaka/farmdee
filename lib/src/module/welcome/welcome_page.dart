import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/main/main_page.dart';
import 'package:farmdee/src/widgets/text/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../test_wifi/test_wifi_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final LocalStorage storage =  LocalStorage('auth');
  String? token;
  _getToken()async{
    await storage.ready;
    token = await storage.getItem('token');
    int? id = await storage.getItem('id');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  FlutterWifiIoT()),
    );
    // if(token!=null){
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) =>  MainPage(ownerId: id??0,)),
    //   );
    // }else{
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LoginPage()),
    //   );
    // }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    // token =  storage.getItem('token');
    // print(token);
    // if(token!=null){
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const MainPage()),
    //   );
    // }else{
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LoginPage()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
