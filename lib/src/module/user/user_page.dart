import 'package:farmdee/src/module/login/login_page.dart';
import 'package:farmdee/src/module/login/widgets/label_text.dart';
import 'package:farmdee/src/module/user/user_model.dart';
import 'package:farmdee/src/module/user/user_service.dart';
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
  UserModel model = UserModel(lastName: '', firstName: '', email: '');
  UserService service = UserService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserById();
  }
  getUserById() {
    service.getById().then((value){
      setState(() {
        model = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffoldItem(
      title: 'ข้อมูลผู้ใช้',
      canBack: false,
      child: Column(
        children: [
          Divider(
              color: Colors.black
          ),
          Row(children: [
            SizedBox(width: 10,),
            LabelText(text: 'อีเมล'),
            Spacer(),
            LabelText(text: model.email),
            SizedBox(width: 10,),
          ],),
          Divider(
              color: Colors.black
          ),
          Row(children: [
            SizedBox(width: 10,),
            LabelText(text: 'ชื่อ'),
            Spacer(),
            LabelText(text: model.firstName??''),
            SizedBox(width: 10,),
          ],),
          Divider(
              color: Colors.black
          ),
          Row(children: [
            SizedBox(width: 10,),
            LabelText(text: 'นามสกุล'),
            Spacer(),
            LabelText(text: model.lastName??''),
            SizedBox(width: 10,),
          ],),

          SizedBox(height: 20,),
          GestureDetector(
          onTap: () async{
            final LocalStorage storage = new LocalStorage('auth');
            await storage.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: LabelText(text: 'ออกจากระบบ',),
        )]
      ),
    );
  }
}
