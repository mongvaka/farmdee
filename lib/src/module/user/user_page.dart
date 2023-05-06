import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/widgets/app_button.dart';
import 'package:farmdee/src/widgets/scaffold/app_scaffold_item.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      title: 'ข้อมูลผู้ใช้',
      canBack: false,
      child: Center(
        child: GestureDetector(
          onTap: () async{
            final LocalStorage storage = new LocalStorage('auth');
            await storage.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: LabelText(text: 'ออกจากระบบ',),
        )
      ),
    );
  }
}
