import 'package:farmdee/src/module/message/message_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:http/http.dart' as http;

import '../../sockets/sockets_cubit.dart';
import '../home/home_page.dart';
import '../home/home_service.dart';
import '../shop/shop_page.dart';
import '../user/user_page.dart';

class MainPage extends StatefulWidget {
  final int ownerId;
  const MainPage({Key? key, required this.ownerId}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static  List<Widget> _widgetOptions = <Widget>[
     HomePage(),
    ShopPage(),
    MessagePage(),
    UserPage()
  ];



  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [ BlocProvider<SocketCubit>(
        create: (BuildContext context) => SocketCubit(ownerId: widget.ownerId),
      ),],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'อุปกรณ์',
                  ),
                  GButton(
                    icon: LineIcons.shoppingBasket,
                    text: 'สั่งอุปกรณ์',
                  ),
                  GButton(
                    icon: LineIcons.rocketChat,
                    text: 'สอบถาม',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'ผู้ใช้',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}

