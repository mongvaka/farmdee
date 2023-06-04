import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/main/main_page.dart';
import 'package:farmdee/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'src/module/switch/switch_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
    IO.Socket socket;

    socket = IO.io("http://192.168.1.45:3033", <String, dynamic>{
      "transports": ["websocket"],
    });
    socket!.onConnect((_) {
      print('connect');
    });
    final LocalStorage storage = LocalStorage('auth');
    int? ownerId =  storage.getItem('id');
    socket!.on('message$ownerId', (data) {
      // print("data['answer']");
      // print(data['answer']);
      // MessageModel newMessage = MessageModel(message: data['message'],
      //     type: data['type'],
      //     answer:data['answer']==null?null: UserModel(
      //         id: data['answer']['id']??1,
      //         email: data['answer']['email']??'',
      //         firstName: data['answer']['firstName']??'',
      //         lastName: data['answer']['lastName']??''
      //     )
      // );
      // setState(() {
      //   _posts.insert(0,newMessage);
      //   // _controller = ScrollController()..addListener(_loadMore);
      //
      //   // _controller.animateTo(_controller.position.maxScrollExtent , duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      // });
      // _controller.animateTo(0.0 , duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

      // _controller.jumpTo(0.0);

      print(data);
    });
    socket!.connect();

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
